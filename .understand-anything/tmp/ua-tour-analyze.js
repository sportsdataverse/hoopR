#!/usr/bin/env node
"use strict";
const fs = require("fs");

function main() {
  const inPath = process.argv[2];
  const outPath = process.argv[3];
  if (!inPath || !outPath) {
    console.error("usage: node ua-tour-analyze.js <input.json> <output.json>");
    process.exit(1);
  }
  const data = JSON.parse(fs.readFileSync(inPath, "utf8"));
  const nodes = data.nodes || [];
  // accept both `edges` and `allEdges`
  const edges = data.edges || data.allEdges || [];
  const layers = data.layers || [];

  const nodeById = new Map();
  for (const n of nodes) nodeById.set(n.id, n);

  const nameOf = (id) => (nodeById.get(id) ? nodeById.get(id).name : id);

  // --- Fan-in / Fan-out ---
  const fanIn = new Map();
  const fanOut = new Map();
  for (const n of nodes) { fanIn.set(n.id, 0); fanOut.set(n.id, 0); }
  for (const e of edges) {
    if (fanOut.has(e.source)) fanOut.set(e.source, fanOut.get(e.source) + 1);
    if (fanIn.has(e.target)) fanIn.set(e.target, fanIn.get(e.target) + 1);
  }

  const fanInRanking = [...fanIn.entries()]
    .map(([id, v]) => ({ id, fanIn: v, name: nameOf(id) }))
    .sort((a, b) => b.fanIn - a.fanIn)
    .slice(0, 20);
  const fanOutRanking = [...fanOut.entries()]
    .map(([id, v]) => ({ id, fanOut: v, name: nameOf(id) }))
    .sort((a, b) => b.fanOut - a.fanOut)
    .slice(0, 20);

  // percentile helpers
  const fanOutVals = [...fanOut.values()].sort((a, b) => a - b);
  const fanInVals = [...fanIn.values()].sort((a, b) => a - b);
  const pct = (arr, p) => {
    if (arr.length === 0) return 0;
    const idx = Math.floor((arr.length - 1) * p);
    return arr[idx];
  };
  const fanOutTop10 = pct(fanOutVals, 0.9);
  const fanInBottom25 = pct(fanInVals, 0.25);

  // --- Entry Point Candidates ---
  const codeEntryNames = new Set([
    "index.ts","index.js","main.ts","main.js","app.ts","app.js","server.ts","server.js",
    "mod.rs","main.go","main.py","main.rs","manage.py","app.py","wsgi.py","asgi.py","run.py",
    "__main__.py","Application.java","Main.java","Program.cs","config.ru","index.php",
    "App.swift","Application.kt","main.cpp","main.c"
  ]);
  const entryScores = [];
  for (const n of nodes) {
    let score = 0;
    const fp = (n.filePath || "").replace(/\\/g, "/");
    const depth = fp ? fp.split("/").length : 99;
    if (n.type === "document") {
      const base = (n.name || "").toLowerCase();
      const rootLevel = depth <= 1;
      if (base === "readme.md" && rootLevel) score += 5;
      else if (base.endsWith(".md") && rootLevel) score += 2;
    } else {
      if (codeEntryNames.has(n.name)) score += 3;
      if (depth <= 2) score += 1;
      if (fanOut.get(n.id) >= fanOutTop10 && fanOutTop10 > 0) score += 1;
      if (fanIn.get(n.id) <= fanInBottom25) score += 1;
    }
    if (score > 0) entryScores.push({ id: n.id, score, name: n.name, type: n.type, summary: n.summary || "" });
  }
  entryScores.sort((a, b) => b.score - a.score);
  const entryPointCandidates = entryScores.slice(0, 5);

  // --- BFS from top CODE entry point (skip documents) ---
  const adj = new Map();
  for (const n of nodes) adj.set(n.id, []);
  const bfsEdgeTypes = new Set(["imports", "calls", "depends_on", "related"]);
  for (const e of edges) {
    if (!bfsEdgeTypes.has(e.type)) continue;
    if (adj.has(e.source)) adj.get(e.source).push(e.target);
  }
  // pick top code entry point: first non-document entry candidate, else top fan-out code node
  let startNode = null;
  for (const c of entryScores) {
    if (c.type !== "document") { startNode = c.id; break; }
  }
  if (!startNode) {
    const codeFanOut = fanOutRanking.find((r) => {
      const t = nodeById.get(r.id);
      return t && t.type !== "document";
    });
    startNode = codeFanOut ? codeFanOut.id : (nodes[0] && nodes[0].id);
  }

  const order = [];
  const depthMap = {};
  if (startNode) {
    const visited = new Set([startNode]);
    let queue = [[startNode, 0]];
    while (queue.length) {
      const [id, d] = queue.shift();
      order.push(id);
      depthMap[id] = d;
      for (const nxt of (adj.get(id) || [])) {
        if (!visited.has(nxt)) {
          visited.add(nxt);
          queue.push([nxt, d + 1]);
        }
      }
    }
  }
  const byDepth = {};
  for (const id of order) {
    const d = depthMap[id];
    (byDepth[d] = byDepth[d] || []).push(id);
  }

  // --- Non-Code File Inventory ---
  const nonCodeFiles = { documentation: [], infrastructure: [], data: [], config: [] };
  for (const n of nodes) {
    const entry = { id: n.id, name: n.name, type: n.type, summary: n.summary || "" };
    if (n.type === "document") nonCodeFiles.documentation.push(entry);
    else if (["service", "pipeline", "resource"].includes(n.type)) nonCodeFiles.infrastructure.push(entry);
    else if (["table", "schema", "endpoint"].includes(n.type)) nonCodeFiles.data.push(entry);
    else if (n.type === "config") nonCodeFiles.config.push(entry);
  }

  // --- Tightly Coupled Clusters ---
  // bidirectional pairs over imports/calls/depends_on/related
  const pairKey = (a, b) => (a < b ? a + "||" + b : b + "||" + a);
  const directed = new Set();
  const undirectedCount = new Map();
  for (const e of edges) {
    if (!bfsEdgeTypes.has(e.type)) continue;
    directed.add(e.source + "->" + e.target);
    const k = pairKey(e.source, e.target);
    undirectedCount.set(k, (undirectedCount.get(k) || 0) + 1);
  }
  const clusterSeeds = [];
  const seen = new Set();
  for (const e of edges) {
    if (!bfsEdgeTypes.has(e.type)) continue;
    const a = e.source, b = e.target;
    const back = directed.has(b + "->" + a);
    const k = pairKey(a, b);
    if (back && !seen.has(k)) {
      seen.add(k);
      clusterSeeds.push(new Set([a, b]));
    }
  }
  // build undirected adjacency for expansion
  const undAdj = new Map();
  for (const n of nodes) undAdj.set(n.id, new Set());
  for (const e of edges) {
    if (!bfsEdgeTypes.has(e.type)) continue;
    if (undAdj.has(e.source)) undAdj.get(e.source).add(e.target);
    if (undAdj.has(e.target)) undAdj.get(e.target).add(e.source);
  }
  const clusters = [];
  for (const seed of clusterSeeds) {
    const members = new Set(seed);
    let changed = true;
    while (changed && members.size < 5) {
      changed = false;
      const candidates = new Map();
      for (const m of members) {
        for (const nb of (undAdj.get(m) || [])) {
          if (!members.has(nb)) candidates.set(nb, (candidates.get(nb) || 0) + 1);
        }
      }
      for (const [cand, cnt] of candidates) {
        if (cnt >= 2 && members.size < 5) { members.add(cand); changed = true; }
      }
    }
    // edge count within cluster
    let ec = 0;
    const arr = [...members];
    for (const e of edges) {
      if (!bfsEdgeTypes.has(e.type)) continue;
      if (members.has(e.source) && members.has(e.target)) ec++;
    }
    clusters.push({ nodes: arr, edgeCount: ec });
  }
  // dedupe clusters by member-set signature; keep top by edgeCount
  const clusterSig = new Set();
  const dedupClusters = [];
  clusters.sort((a, b) => b.edgeCount - a.edgeCount);
  for (const c of clusters) {
    const sig = [...c.nodes].sort().join("|");
    if (clusterSig.has(sig)) continue;
    clusterSig.add(sig);
    dedupClusters.push(c);
  }
  const topClusters = dedupClusters.slice(0, 10);

  // --- Layers ---
  const layersOut = {
    count: layers.length,
    list: layers.map((l) => ({ id: l.id, name: l.name, description: l.description })),
  };

  // --- Node Summary Index ---
  const nodeSummaryIndex = {};
  for (const n of nodes) {
    nodeSummaryIndex[n.id] = { name: n.name, type: n.type, summary: n.summary || "" };
  }

  const out = {
    scriptCompleted: true,
    entryPointCandidates,
    fanInRanking,
    fanOutRanking,
    bfsTraversal: { startNode, order, depthMap, byDepth },
    nonCodeFiles,
    clusters: topClusters,
    layers: layersOut,
    nodeSummaryIndex,
    totalNodes: nodes.length,
    totalEdges: edges.length,
  };
  fs.writeFileSync(outPath, JSON.stringify(out, null, 2));
  process.stdout.write("OK nodes=" + nodes.length + " edges=" + edges.length + " entry=" + startNode + "\n");
}

try { main(); } catch (err) {
  console.error("FATAL:", err && err.stack ? err.stack : String(err));
  process.exit(1);
}
