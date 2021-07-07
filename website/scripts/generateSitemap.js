const fs = require('fs')
const globby = require('globby')
const matter = require('gray-matter')

const BASE_URL = new URL('https://saiemgilani.github.io/wehoop/');

async function generateSiteMap() {
  const patterns = [
    'pages/**/*.tsx', 
    '!pages/_*.tsx', 
    `!pages/**/\\[*\\].tsx`, 
    '!pages/404.tsx', 
    'posts/*.md',
    'reference/*.md',
    'articles/*.md']
  let pages = await globby(patterns)

  const fileNames = fs.readdirSync('posts')
  const topics = Array.from(
    new Set(
      fileNames.reduce((prev, fn) => {
        const fileContents = fs.readFileSync('posts/' + fn, 'utf8')
        const matterResult = matter(fileContents)
        const topics = matterResult.data.topics.split(',')
        return [...prev, ...topics]
      }, []),
    ),
  )

  pages = [...pages, ...topics.map((t) => `/topics/${t.replace(' ', '-')}`)]

  const sitemap =
    '<?xml version="1.0" encoding="UTF-8"?>\n' +
    '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n' +
    `${pages
      .map((page) => {
        const path = page
          .replace('pages', '')
          .replace('.tsx', '')
          .replace('.md', '')
          .replace('posts/', 'blog/')
          .replace('articles/','articles/')
          .replace('reference/','reference/')
          .replace('/index', '')
        const route = path === '/index' ? '' : path
        return `
                      <url><loc>${`${BASE_URL}${route}`}</loc></url>\n`.trimStart()
      })
      .join('')}</urlset>`.trim()

  fs.writeFileSync('public/sitemap.xml', sitemap)
}

generateSiteMap()
