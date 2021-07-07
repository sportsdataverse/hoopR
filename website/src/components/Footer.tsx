import React, { FC, ReactElement } from 'react'
import style from '../../styles/Footer.module.css'
import { Typography } from '@material-ui/core'

export const Footer: FC = ({}): ReactElement => {
  return (
    <div className={style.footer}>
      <Typography variant="body1" display="inline" className={style['footer-content']}>
        Copyright © {new Date().getFullYear()} <strong>wehoop</strong>, developed by <a href="http://www.github.com/saiemgilani" target="_blank" rel="noreferrer">
          Saiem Gilani
        </a> and <a href="http://www.github.com/hutchngo" target="_blank" rel="noreferrer">
          Geoff Hutchinson
        </a>, part of the <a href='https://sportsdataverse.org'>SportsDataverse</a>.
      </Typography>
    </div>
  )
}
