#!/usr/bin/env node
"use strict";

// Architecture structural analyzer for hoopR (R package).
// Usage: node ua-arch-analyze.js <input.json> <output.json>

const fs = require("fs");

function main() {
  const inPath = process.argv[2];
  const outPath = process.argv[3];
  if (!inPath || !outPath) {
    console.error("usage: node ua-arch-analyze.js <input.json> <output.json>");
    process.exit(1);
  }
  const data = JSON.parse(fs.readFileSync(inPath, "utf8"));
  const fileNodes = data.fileNodes || [];
  const importEdges = data.importEdges || [];
  const allEdges = data.allEdges || [];

  const idToNode = new Map();
  for (const n of fileNodes) idToNode.set(n.id, n);

  // ---------- Common prefix ----------
  const paths = fileNodes.map((n) => n.filePath || "");
  function commonPrefixDir(ps) {
    if (ps.length === 0) return "";
    const segLists = ps.map((p) => p.split("/").slice(0, -1)); // dir segments only
    let prefix = segLists[0];
    for (const segs of segLists) {
      let i = 0;
      while (i < prefix.length && i < segs.length && prefix[i] === segs[i]) i++;
      prefix = prefix.slice(0, i);
    }
    return prefix.join("/");
  }
  const prefix = commonPrefixDir(paths); // usually "" for a repo root layout

  // ---------- A. Directory grouping ----------
  function topGroup(p) {
    let rest = p;
    if (prefix && rest.startsWith(prefix + "/")) rest = rest.slice(prefix.length + 1);
    if (!rest.includes("/")) return "(root)";
    return rest.split("/")[0];
  }
  const directoryGroups = {};
  for (const n of fileNodes) {
    const g = topGroup(n.filePath || "");
    (directoryGroups[g] = directoryGroups[g] || []).push(n.id);
  }

  // ---------- B. Node type grouping ----------
  const nodeTypeGroups = {};
  for (const n of fileNodes) {
    (nodeTypeGroups[n.type] = nodeTypeGroups[n.type] || []).push(n.id);
  }

  // ---------- Filename-family grouping (the real architecture for a flat R/ dir) ----------
  function family(n) {
    const fp = n.filePath || "";
    const base = (n.name || "").replace(/\.[Rr]$/, "");
    const tags = (n.tags || []).join(" ").toLowerCase();
    const sum = (n.summary || "").toLowerCase();

    // non-R locations first
    if (fp.startsWith(".github")) return "ci-cd";
    if (fp.startsWith("vignettes")) return "vignettes";
    if (fp.startsWith("data-raw")) return "data-raw";
    if (fp.startsWith(".understand")) return "meta";
    if (!fp.startsWith("R/")) {
      // root-level files: configs / docs
      if (n.type === "document") return "docs";
      if (n.type === "config") return "config";
      return "config";
    }

    // R/ source families
    if (/^espn_mbb/.test(base)) return "espn_mbb";
    if (/^espn_nba/.test(base)) return "espn_nba";
    if (/^espn_basketball/.test(base)) return "espn_shared";
    if (/^nba_/.test(base) || base === "utils_nba_stats") return "nba_stats";
    if (/^cbbd_/.test(base)) return "cbbd";
    if (/^bref_/.test(base)) return "bref";
    if (/^realgm/.test(base)) return "realgm";
    if (/^kp_/.test(base) || base === "kp") return "kenpom";
    if (/^load_/.test(base)) return "loaders";
    if (/crosswalk|xwalk/.test(base)) return "crosswalk";
    // aux sources (Torvik, NBA G-League, salary, injuries, NCAA, Fox, draft, hoopshype, spotrac, rotowire)
    if (/^torvik|^nbagl|^ncaa|^fox|^hoopshype|^spotrac|^rotowire|^nbadraft|salary/.test(base)) return "aux_sources";
    if (base === "data") return "package_internal";
    if (base === "utils") return "utilities";
    if (/util|helper/.test(base)) return "utilities";
    return "package_internal";
  }
  const familyGroups = {};
  for (const n of fileNodes) {
    const f = family(n);
    (familyGroups[f] = familyGroups[f] || []).push(n.id);
  }

  // ---------- C. Import adjacency (importEdges empty for R, but compute anyway) ----------
  const fanOut = {};
  const fanIn = {};
  for (const n of fileNodes) {
    fanOut[n.id] = 0;
    fanIn[n.id] = 0;
  }
  for (const e of importEdges) {
    if (fanOut[e.source] !== undefined) fanOut[e.source]++;
    if (fanIn[e.target] !== undefined) fanIn[e.target]++;
  }

  // ---------- D. Cross-category dependency analysis (allEdges) ----------
  const crossMap = {};
  for (const e of allEdges) {
    const s = idToNode.get(e.source);
    const t = idToNode.get(e.target);
    if (!s || !t) continue;
    if (s.type === t.type) continue;
    const key = s.type + "->" + t.type + "::" + e.type;
    crossMap[key] = (crossMap[key] || 0) + 1;
  }
  const crossCategoryEdges = Object.entries(crossMap).map(([k, count]) => {
    const [pair, edgeType] = k.split("::");
    const [fromType, toType] = pair.split("->");
    return { fromType, toType, edgeType, count };
  });

  // ---------- E. Inter-family edge frequency (using allEdges, since importEdges empty) ----------
  const famOf = {};
  for (const n of fileNodes) famOf[n.id] = family(n);
  const interMap = {};
  const intra = {};
  for (const f of Object.keys(familyGroups)) intra[f] = { internalEdges: 0, totalEdges: 0 };
  for (const e of allEdges) {
    const fs_ = famOf[e.source];
    const ft = famOf[e.target];
    if (fs_ === undefined || ft === undefined) continue;
    if (fs_ === ft) {
      intra[fs_].internalEdges++;
      intra[fs_].totalEdges++;
    } else {
      const key = fs_ + "->" + ft;
      interMap[key] = (interMap[key] || 0) + 1;
      intra[fs_].totalEdges++;
      intra[ft].totalEdges++;
    }
  }
  const interGroupImports = Object.entries(interMap)
    .map(([k, count]) => {
      const [from, to] = k.split("->");
      return { from, to, count };
    })
    .sort((a, b) => b.count - a.count);

  const intraGroupDensity = {};
  for (const [f, v] of Object.entries(intra)) {
    intraGroupDensity[f] = {
      internalEdges: v.internalEdges,
      totalEdges: v.totalEdges,
      density: v.totalEdges ? +(v.internalEdges / v.totalEdges).toFixed(3) : 0,
    };
  }

  // ---------- G. Pattern matching for families ----------
  const patternMatches = {
    espn_mbb: "api",
    espn_nba: "api",
    espn_shared: "api",
    nba_stats: "api",
    cbbd: "api",
    bref: "api",
    realgm: "api",
    kenpom: "api",
    aux_sources: "api",
    loaders: "data",
    crosswalk: "utility",
    utilities: "utility",
    package_internal: "utility",
    vignettes: "documentation",
    docs: "documentation",
    config: "config",
    "ci-cd": "ci-cd",
    "data-raw": "data",
    meta: "config",
  };

  // ---------- H. Deployment topology ----------
  const infraFiles = [];
  let hasCI = false;
  for (const n of fileNodes) {
    const p = n.filePath || "";
    if (p.startsWith(".github/workflows")) {
      hasCI = true;
      infraFiles.push(p);
    }
  }
  const deploymentTopology = {
    hasDockerfile: false,
    hasCompose: false,
    hasK8s: false,
    hasTerraform: false,
    hasCI,
    infraFiles,
  };

  // ---------- I. Data pipeline ----------
  const dataPipeline = {
    schemaFiles: [],
    migrationFiles: [],
    dataModelFiles: (familyGroups.loaders || []).map((id) => idToNode.get(id).filePath),
    apiHandlerFiles: [],
  };

  // ---------- J. Documentation coverage ----------
  const docNodes = fileNodes.filter((n) => n.type === "document");
  const totalGroups = Object.keys(familyGroups).length;
  const groupsWithDocs = familyGroups.docs || familyGroups.vignettes ? 1 : 0;
  const docCoverage = {
    groupsWithDocs: docNodes.length > 0 ? 2 : 0,
    totalGroups,
    coverageRatio: totalGroups ? +((docNodes.length > 0 ? 2 : 0) / totalGroups).toFixed(2) : 0,
    undocumentedGroups: Object.keys(familyGroups).filter(
      (g) => g !== "docs" && g !== "vignettes"
    ),
  };

  // ---------- K. Dependency direction ----------
  const dirMap = {};
  for (const { from, to, count } of interGroupImports) {
    const rev = interMap[to + "->" + from] || 0;
    if (count > rev) dirMap[from + "->" + to] = true;
  }
  const dependencyDirection = Object.keys(dirMap).map((k) => {
    const [dependent, dependsOn] = k.split("->");
    return { dependent, dependsOn };
  });

  // ---------- file stats ----------
  const nodeTypeCounts = {};
  for (const [t, ids] of Object.entries(nodeTypeGroups)) nodeTypeCounts[t] = ids.length;
  const filesPerGroup = {};
  for (const [g, ids] of Object.entries(familyGroups)) filesPerGroup[g] = ids.length;

  const out = {
    scriptCompleted: true,
    commonPrefix: prefix,
    directoryGroups,
    familyGroups,
    nodeTypeGroups,
    crossCategoryEdges,
    interGroupImports,
    intraGroupDensity,
    patternMatches,
    deploymentTopology,
    dataPipeline,
    docCoverage,
    dependencyDirection,
    fileStats: {
      totalFileNodes: fileNodes.length,
      filesPerGroup,
      nodeTypeCounts,
    },
    fileFanIn: fanIn,
    fileFanOut: fanOut,
  };
  fs.writeFileSync(outPath, JSON.stringify(out, null, 2));
  console.log("OK totalFileNodes=" + fileNodes.length + " families=" + totalGroups);
}

try {
  main();
} catch (e) {
  console.error("FATAL:", e && e.stack ? e.stack : e);
  process.exit(1);
}
