import { getSortedPostsData, getSortedTopics } from '../../src/lib/posts'
import { GetStaticPropsContext, GetStaticPropsResult } from 'next'
import { PostData } from '../../src/types/posts'
import React, { FC, ReactElement } from 'react'
import { PageHeading } from '../../src/components/PageHeading'
import Box from '@material-ui/core/Box'
import { Grid } from '@material-ui/core'
import { Preview } from '../../src/components/Preview'
import TopicsDisplay from '../../src/components/TopicsDisplay'
import Head from 'next/head'

type Props = { postsData: PostData[]; topic: string; topics: string[] }

const adaptTopicName = (topicName: string): string => {
  return topicName.replace('-', ' ')
}

const Topic: FC<Props> = ({ postsData, topic, topics }): ReactElement => {
  const realTopicName = adaptTopicName(topic)
  return (
    <>
      <Head>
        <title>{realTopicName}</title>
        <meta
          name="description"
          content={
            'Learn about ' +
            realTopicName +
            ' by reading the most recent blog posts about ' +
            realTopicName +
            ' and more topics like ' +
            topics.join(', ') +
            '.'
          }
        />
      </Head>
      <PageHeading title={realTopicName} />
      <TopicsDisplay topics={topics.filter((t) => adaptTopicName(t) !== realTopicName)} n={5} />
      <Box pt={4} pb={4}>
        <Grid item xs={12}>
          <Preview posts={postsData} />
        </Grid>
      </Box>
    </>
  )
}

export const getStaticProps = async ({
  params: { topic },
}: GetStaticPropsContext<{ topic: string }>): Promise<
  GetStaticPropsResult<{
    postsData: PostData[]
    topic: string
    topics: string[]
  }>
> => {
  const postsData = getSortedPostsData()
  const topics = getSortedTopics()

  return {
    props: {
      postsData: postsData.filter((pd) => pd.topics.map((t) => adaptTopicName(t)).includes(adaptTopicName(topic))),
      topic: topic,
      topics,
    },
  }
}

type StaticPaths = { paths: { params: { topic: string } }[]; fallback: boolean }
export const getStaticPaths = async (): Promise<StaticPaths> => {
  const paths = getSortedTopics().map((topic) => ({
    params: {
      topic: topic.replace(' ', '-'),
    },
  }))

  return {
    paths,
    fallback: false,
  }
}

export default Topic
