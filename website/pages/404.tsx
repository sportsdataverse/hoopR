import React, { FC, ReactElement } from 'react'
import styles from '../styles/404.module.css'
import { PageHeading } from '../src/components/PageHeading'
import { Typography } from '@material-ui/core'
import { GetStaticPropsResult } from 'next'
import { getSortedTopics } from '../src/lib/posts'
import TopicsDisplay from '../src/components/TopicsDisplay'

type FourOFourProps = { topics: string[] }

export const FourOFour: FC<FourOFourProps> = ({ topics }): ReactElement => {
  return (
    <div className={styles.error}>
      <div className={styles.container}>
        <div>
          <PageHeading title="404" />
        </div>
        <Typography variant="h6">This page could not be found 🙁</Typography>
        <div className={styles.topics}>
          <TopicsDisplay topics={topics} n={5} />
        </div>
      </div>
    </div>
  )
}

export const getStaticProps = async (): Promise<
  GetStaticPropsResult<{
    topics: string[]
  }>
> => {
  const sortedTopics = getSortedTopics()

  return {
    props: {
      topics: sortedTopics,
    },
  }
}

export default FourOFour
