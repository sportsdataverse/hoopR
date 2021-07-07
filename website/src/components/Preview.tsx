import React, { FC, ReactElement } from 'react'
import { PostData } from '../types/posts'
import { Grid } from '@material-ui/core'
import PreviewCard from './PreviewCard'
import { paddedItem } from '../../styles/shared'

type PreviewProps = {
  posts: PostData[]
}

export const Preview: FC<PreviewProps> = ({ posts }): ReactElement => {
  return (
    <div style={paddedItem}>
      <Grid container spacing={3} justify="flex-start">
        {posts.map((pd) => (
          <Grid key={pd.id} item xs={12} md={6} lg={4} xl={3}>
            <PreviewCard post={pd} />
          </Grid>
        ))}
      </Grid>
    </div>
  )
}
