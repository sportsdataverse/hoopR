import { getSortedReferencesData } from '../src/lib/references'
import { GetStaticPropsResult } from 'next'
import clsx from 'clsx';
import React, { ReactElement } from 'react'
import { Grid, Typography } from '@material-ui/core'
import Box from '@material-ui/core/Box'
import { ReferenceData } from '../src/types/references'
import useMediaQuery from '@material-ui/core/useMediaQuery'
import { PreviewReference } from '../src/components/PreviewReference'
import Head from 'next/head'
import { NAME, NAME_AND_DOMAIN, BASE_URL, DESC } from '../src/types/constants'
import styles from '../styles/styles.module.css';
import Hero from '../src/components/Hero'
import Layout from '../src/components/Layout'

const FeatureList = [
  {
    title: "",
    // Svg: require('../../static/img/undraw_docusaurus_mountain.svg').default,
    description: (
      <>
        
      </>
    ),
  },
  {
    title: '',
    // Svg: require('../../static/img/undraw_docusaurus_tree.svg').default,
    description: (
      <>
        
      </>
    ),
  },
];
function Feature({title, description }) {
  
  return (
    <div className={clsx('col col--6', styles.feature)}>
      <h3>{title}</h3>
      <p>{description}</p>
    </div>
  );
}
const Home = ({ referencesData }: { referencesData: ReferenceData[];  }): ReactElement => {
  const large = useMediaQuery('(min-width:700px)')

  return (
    <>
      <Head>
        <title>{NAME}</title>
        <Head>
        <meta name="description" content={`${NAME}`} />
        <meta property="og:type" content="article" />
        <meta property="og:title" content={`${NAME}`} />
        <meta property="og:description" content={`${DESC}`} />
        <meta property="og:url" content={`${BASE_URL}/`} />
        <meta property="og:site_name" content={NAME} />
        <meta property="og:image" content={`${BASE_URL}/logo/logo.png`} />
        <meta property="og:image:secure_url" content={`${BASE_URL}/logo/logo.png`} />
        <meta name="twitter:card" content="summary" />
        <meta name="twitter:description" content={`${NAME}`} />
        <meta name="twitter:title" content={`${NAME}`} />
        <meta name="twitter:image" content={`/logo/logo.png`} />
      </Head>
        <meta
          name="description"
          content={`${DESC}`}
        />
      </Head>
      <Layout>
      <main className="bg-white p-4">
        <Hero />
      </main>
      </Layout>
    </>
  )
}


export const getStaticProps = async (): Promise<
  GetStaticPropsResult<{
    referencesData: ReferenceData[]
  }>
> => {
  const referencesData = getSortedReferencesData()

  return {
    props: {
      referencesData: referencesData.filter((pd) => pd.featured),
    },
  }
}


export default Home
