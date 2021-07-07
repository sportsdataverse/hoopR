import React, { FC, ReactElement, useEffect } from 'react'
import { getArticle, getSortedArticlesData } from '../../src/lib/articles'
import { ArticleData } from '../../src/types/articles'
import { GetStaticPropsContext, GetStaticPropsResult } from 'next'
import marked from 'marked'
import Head from 'next/head'
import hljs from 'highlight.js'
import '../../node_modules/highlight.js/styles/monokai.css'
import '../../node_modules/highlight.js/lib/highlight'
import styles from '../../styles/Slug.module.css'
import { PageHeading } from '../../src/components/PageHeading'
import { Card, CardMedia, Typography } from '@material-ui/core'
import GitHubIcon from '@material-ui/icons/GitHub'
// import TopicsDisplay from '../../src/components/TopicsDisplay'
import PreviewArticleCard from '../../src/components/PreviewArticleCard'
import { BASE_URL, NAME } from '../../src/types/constants'

type Props = { articleData: ArticleData; nextPath: ArticleData }

const Slug: FC<Props> = ({ articleData, nextPath }): ReactElement => {
  marked.setOptions({
    highlight: function (code) {
      return hljs.highlightAuto(code).value
    },
  })

  useEffect(() => {
    document.querySelectorAll('pre code').forEach((block: HTMLElement) => {
      hljs.highlightBlock(block)
    })
  }, [articleData])

  return (
    <>
      <Head>
        <title>{articleData.title}</title>
        <meta name="description" content={articleData.description} />
        <meta name="twitter:card" content="summary" />
        <meta name="twitter:description" content={articleData.description} />
        <meta name="twitter:title" content={articleData.title} />
        <meta name="twitter:image" content={`${BASE_URL}/large/${articleData.id}.png`} />
        <meta property="og:type" content="article" />
        <meta property="og:title" content={articleData.title} />
        <meta property="og:description" content={articleData.description} />
        <meta property="og:url" content={`${BASE_URL}/articles/${articleData.id}`} />
        <meta property="og:site_name" content={NAME} />
        <meta property="og:image" content={`${BASE_URL}/large/${articleData.id}.png`} />
        <meta property="og:image:secure_url" content={`${BASE_URL}/large/${articleData.id}.png`} />
      </Head>
      <div className={styles['text-content']}>
        <PageHeading title={articleData.title} />
      </div>
      <div className={styles['image-container']}>
        <div className={styles.info}>
          <Typography variant="body1">
            {articleData.date} — written by{' '}
            <a
              href="http://www.github.com/saiemgilani"
              target="_blank"
              rel="noreferrer"
              style={{
                display: 'inline-flex',
                alignItems: 'center',
              }}
            >
              Saiem <GitHubIcon fontSize="small" style={{ marginLeft: 10 }} />
            </a>
          </Typography>
          {/* <TopicsDisplay topics={articleData.topics} n={10} noMargin /> */}
        </div>
      </div>
      {/* <div className={styles['image-container']}>
        <Card className={styles.image}>
          <CardMedia>
            <img alt={postData.title} loading="lazy" src={`/large/${postData.id}.png`} />
          </CardMedia>
        </Card>
      </div> */}
      <div className={styles['article-container']} dangerouslySetInnerHTML={{ __html: marked(articleData.content) }} />
    </>
  )
}

type StaticPaths = { paths: { params: { slug: string } }[]; fallback: boolean }

export const getStaticProps = async ({
  params: { slug },
}: GetStaticPropsContext<{ slug: string }>): Promise<
  GetStaticPropsResult<{
    articleData: ArticleData
    nextPath: ArticleData
  }>
> => {
  const articleData = getArticle(slug, true)

  const paths = getSortedArticlesData()

  const nextPath = !articleData.recommended
    ? paths.reduce((prev, curr, i) => (curr.id === slug && i >= 1 ? paths[i - 1] : curr), paths[paths.length - 1])
    : paths.filter((p) => p.id === articleData.recommended).pop()

  return {
    props: {
      articleData,
      nextPath,
    },
  }
}

export const getStaticPaths = async (): Promise<StaticPaths> => {
  const paths = getSortedArticlesData().map(({ id }) => ({
    params: {
      slug: id,
    },
  }))

  return {
    paths,
    fallback: false,
  }
}

export default Slug
