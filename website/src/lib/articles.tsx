import fs from 'fs'
import path from 'path'
import matter from 'gray-matter'
import { ArticleData } from '../types/articles'

const articlesDirectory = path.join(process.cwd(), 'articles')

export const getArticle = (id: string, includeContent = false): ArticleData => {
  const fullPath = path.join(articlesDirectory, `${id}.md`)
  return getArticleFromFile(fullPath, id, includeContent)
}

export const getSortedArticlesData = (): ArticleData[] => {
  // Get file names under /Articles
  const fileNames = fs.readdirSync(articlesDirectory)
  const allArticlesData: ArticleData[] = fileNames.map((fileName) => {
    // Remove ".md" from file name to get id
    const id = fileName.replace(/\.md$/, '')

    // Read markdown file as string
    const fullPath = path.join(articlesDirectory, fileName)
    return getArticleFromFile(fullPath, id)
  })
  // Sort Articles by date
  return allArticlesData.sort((a, b) => {
    if (a.date < b.date) {
      return 1
    } else {
      return -1
    }
  })
}

const getArticleFromFile = (fullPath: string, id: string, includeContent = false): ArticleData => {
  const fileContents = fs.readFileSync(fullPath, 'utf8')

  // Use gray-matter to parse the Article metadata section
  const matterResult = matter(fileContents)
  // Combine the data with the id
  return {
    id,
    ...matterResult.data,
    content: includeContent ? matterResult.content : null,
    // topics: matterResult.data.topics.split(','),
  } as ArticleData
}

// export const getSortedTopics = (): string[] => {
//   const articles = getSortedArticlesData()

//   const allTopics = articles

//   const map: Record<string, number> = {}

//   allTopics.map((t) => {
//     map[t] = allTopics.filter((topic) => t === topic).length
//   })

//   return Array.from(new Set(allTopics)).sort((a, b) => map[b] - map[a])
// }
