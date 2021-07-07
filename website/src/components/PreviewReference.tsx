import React, { FC, ReactElement } from 'react'
import { ReferenceData } from '../types/references'
import { Grid } from '@material-ui/core'
import PreviewReferenceCard from './PreviewReferenceCard'
import { paddedItem } from '../../styles/shared'

type PreviewProps = {
  references: ReferenceData[]
}

export const PreviewReference: FC<PreviewProps> = ({ references }): ReactElement => {
  return (
    <div style={paddedItem}>
      <Grid container spacing={2} justify="flex-start">
        {references.map((pd) => (
          <Grid key={pd.id} item xs={12} md={6} lg={3} xl={3}>
            <PreviewReferenceCard reference={pd} />
          </Grid>
        ))}
      </Grid>
    </div>
  )
}
