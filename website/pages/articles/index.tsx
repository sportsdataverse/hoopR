import { GetStaticPropsResult } from 'next'
import { getSortedArticlesData } from '../../src/lib/articles'

import React, { ReactElement } from 'react'
// import TopicsDisplay from '../../src/components/TopicsDisplay'
import { Grid } from '@material-ui/core'
import Box from '@material-ui/core/Box'
import { ArticleData } from '../../src/types/articles'
import { PreviewArticle } from '../../src/components/PreviewArticle'
import { PageHeading } from '../../src/components/PageHeading'
import Head from 'next/head'

const Topics = ({ articlesData }: { articlesData: ArticleData[] }): ReactElement => {
  return (
    <>
      <Head>
        <title>wehoop Articles</title>
        {/* <meta name="description" content={'Tech topics like ' + topics.slice(0, 5).join(', ') + ' and more'} /> */}
      </Head>
      <PageHeading title="wehoop Article" />
      {/* <TopicsDisplay topics={topics} n={1000} /> */}
      <Box pt={12} pb={6}>
        <Grid item xs={12}>
          <PreviewArticle articles={articlesData} />
        </Grid>
      </Box>
    </>
  )
}

export const getStaticProps = async (): Promise<
  GetStaticPropsResult<{
    articlesData: ArticleData[]
  }>
> => {
  const articlesData = getSortedArticlesData()

  return {
    props: {
      articlesData: articlesData,
    },
  }
}

export default Topics
