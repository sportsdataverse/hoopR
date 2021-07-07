import React, { ReactElement } from 'react'
import { Chip } from '@material-ui/core'
import Link from 'next/link'
import { makeStyles } from '@material-ui/core/styles'

const useStyles = makeStyles({
  buttonPadding: {
    margin: '10px',
    padding: 3,
  },
  buttonPaddingNoMargin: {
    marginRight: '10px',
    marginTop: '3px',
  },
})

type TopicsDisplayProps = {
  topics: string[]
  n?: number
  noMargin?: boolean
}

const TopicsDisplay = ({ topics, n, noMargin = undefined }: TopicsDisplayProps): ReactElement => {
  const classes = useStyles()
  return (
    <div style={noMargin ? {} : { width: '90%', margin: 'auto', textAlign: 'center', display: 'absolute' }}>
      {topics.slice(0, n ?? 1000).map((t) => (
        <Link key={t} href={`/topics/${t.replace(' ', '-')}`}>
          <Chip className={noMargin ? classes.buttonPaddingNoMargin : classes.buttonPadding} label={t} />
        </Link>
      ))}
      {topics.length > n && (
        <Link href={`/topics`}>
          <Chip className={classes.buttonPadding} label="…" />
        </Link>
      )}
    </div>
  )
}

export default TopicsDisplay
