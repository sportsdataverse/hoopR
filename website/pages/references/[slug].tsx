import React, { FC, ReactElement, useEffect } from 'react'
import { getReference, getSortedReferencesData } from '../../src/lib/references'
import { ReferenceData } from '../../src/types/references'
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
// import PreviewCard from '../../src/components/PreviewCard'
import { BASE_URL, NAME } from '../../src/types/constants'

type Props = { referenceData: ReferenceData; nextPath: ReferenceData }

const Slug: FC<Props> = ({ referenceData, nextPath }): ReactElement => {
  marked.setOptions({
    highlight: function (code) {
      return hljs.highlightAuto(code).value
    },
  })

  useEffect(() => {
    document.querySelectorAll('pre code').forEach((block: HTMLElement) => {
      hljs.highlightBlock(block)
    })
  }, [referenceData])

  return (
    <>
      <Head>
        {/* <title>{referenceData.title}</title>
        {/* <meta name="description" content={referenceData.description} />
        <meta property="article:published_time" content={`${referenceData.date}T10:00:00Z`} />
        <meta name="twitter:card" content="summary" />
        <meta name="twitter:description" content={referenceData.description} />
        <meta name="twitter:title" content={referenceData.title} />
        <meta name="twitter:image" content={`${BASE_URL}/large/${referenceData.id}.png`} />
        <meta property="og:type" content="article" />
        <meta property="og:title" content={referenceData.title} />
        <meta property="og:description" content={referenceData.description} />
        <meta property="og:url" content={`${BASE_URL}/blog/${referenceData.id}`} />
        <meta property="og:site_name" content={NAME} />
        <meta property="og:image" content={`${BASE_URL}/large/${referenceData.id}.png`} />
        <meta property="og:image:secure_url" content={`${BASE_URL}/large/${referenceData.id}.png`} /> */}
      </Head>
      <div className={styles['text-content']}>
        <PageHeading title={referenceData.title} />
      </div>
      {/* <div className={styles['image-container']}>
        <Card className={styles.image}>
          <CardMedia>
            <img alt={referenceData.title} loading="lazy" src={`/large/${referenceData.id}.png`} />
          </CardMedia>
        </Card>
      </div> */}
      <div className={styles['reference-container']} dangerouslySetInnerHTML={{ __html: marked(referenceData.content) }} />
      
    </>
  )
}

type StaticPaths = { paths: { params: { slug: string } }[]; fallback: boolean }

export const getStaticProps = async ({
  params: { slug },
}: GetStaticPropsContext<{ slug: string }>): Promise<
  GetStaticPropsResult<{
    referenceData: ReferenceData
    nextPath: ReferenceData
  }>
> => {
  const referenceData = getReference(slug, true)

  const paths = getSortedReferencesData()

  const nextPath = !referenceData.recommended
    ? paths.reduce((prev, curr, i) => (curr.id === slug && i >= 1 ? paths[i - 1] : curr), paths[paths.length - 1])
    : paths.filter((p) => p.id === referenceData.recommended).pop()

  return {
    props: {
      referenceData,
      nextPath,
    },
  }
}

export const getStaticPaths = async (): Promise<StaticPaths> => {
  const paths = getSortedReferencesData().map(({ id }) => ({
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
