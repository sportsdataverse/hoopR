import React, { FC, ReactElement } from 'react'
import { ArticleData } from '../types/articles'
import { Grid } from '@material-ui/core'
import PreviewArticleCard from './PreviewArticleCard'
import { paddedItem } from '../../styles/shared'

type PreviewProps = {
  articles: ArticleData[]
}

export const PreviewArticle: FC<PreviewProps> = ({ articles }): ReactElement => {
  return (
    <div style={paddedItem}>
      <Grid container spacing={2} justify="flex-start">
        {articles.map((pd) => (
          <Grid key={pd.id} item xs={12} md={6} lg={3} xl={3}>
            <PreviewArticleCard article={pd} />
          </Grid>
        ))}
      </Grid>
    </div>
  )
}
