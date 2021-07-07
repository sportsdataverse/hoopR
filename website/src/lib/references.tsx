import fs from 'fs'
import path from 'path'
import matter from 'gray-matter'
import { ReferenceData } from '../types/references'

const referencesDirectory = path.join(process.cwd(), 'references')

export const getReference = (id: string, includeContent = false): ReferenceData => {
  const fullPath = path.join(referencesDirectory, `${id}.md`)
  return getReferenceFromFile(fullPath, id, includeContent)
}

export const getSortedReferencesData = (): ReferenceData[] => {
  // Get file names under /References
  const fileNames = fs.readdirSync(referencesDirectory)
  const allReferencesData: ReferenceData[] = fileNames.map((fileName) => {
    // Remove ".md" from file name to get id
    const id = fileName.replace(/\.md$/, '')

    // Read markdown file as string
    const fullPath = path.join(referencesDirectory, fileName)
    return getReferenceFromFile(fullPath, id)
  })
  // Sort References by date
  return allReferencesData.sort((a, b) => {
    if (a.date < b.date) {
      return 1
    } else {
      return -1
    }
  })
}

const getReferenceFromFile = (fullPath: string, id: string, includeContent = false): ReferenceData => {
  const fileContents = fs.readFileSync(fullPath, 'utf8')

  // Use gray-matter to parse the Reference metadata section
  const matterResult = matter(fileContents)
  // Combine the data with the id
  return {
    id,
    ...matterResult.data,
    content: includeContent ? matterResult.content : null,
    // topics: matterResult.data.topics.split(','),
  } as ReferenceData
}

// export const getSortedTopics = (): string[] => {
//   const references = getSortedReferencesData()

//   const allTopics = references

//   const map: Record<string, number> = {}

//   allTopics.map((t) => {
//     map[t] = allTopics.filter((topic) => t === topic).length
//   })

//   return Array.from(new Set(allTopics)).sort((a, b) => map[b] - map[a])
// }
