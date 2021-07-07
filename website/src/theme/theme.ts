import { createMuiTheme, ThemeOptions } from '@material-ui/core'

export const paletteColorsDark = {
  primary: '#353A9E',
  secondary: '#7279FD',
  error: '#E44C65',
  background: '#424242',
  text: '#FFFFFF',
}

export const paletteColorsLight = {
  primary: '#6886c5',
  secondary: '#ffe0ac',
  error: '#E44C65',
  background: '#f9f9f9',
  text: '#050505',
}

const options = (dark: boolean): ThemeOptions => {
  const paletteColors = dark ? paletteColorsDark : paletteColorsLight
  return {
    palette: {
      type: dark ? 'dark' : 'light',
      primary: {
        main: paletteColors.primary,
      },
      secondary: {
        main: paletteColors.secondary,
      },
      error: {
        main: paletteColors.error,
      },
      background: {
        default: paletteColors.background,
      },
      text: {
        primary: paletteColors.text,
      },
    },
    typography: {
      fontFamily: 'Lato',
      h1: {
        fontFamily: 'Roboto Slab',
        fontWeight: 300,
        fontSize: '96px',
        lineHeight: '127px',
        letterSpacing: '-1.5px',
      },
      h2: { fontFamily: 'Roboto Slab', fontWeight: 300, fontSize: '60px', lineHeight: '79px', letterSpacing: '-0.5px' },
      h3: { fontFamily: 'Roboto Slab', fontSize: '48px', lineHeight: '63px' },
      h4: { fontFamily: 'Roboto Slab', fontSize: '34px', lineHeight: '45px', letterSpacing: '0.25px' },
      h5: { fontFamily: 'Lato', fontSize: '24px', lineHeight: '32px' },
      h6: { fontFamily: 'Lato', fontWeight: 500, fontSize: '20px', lineHeight: '26px', letterSpacing: '0.15px' },
      // p: { fontFamily: 'Lato', fontWeight: 500, fontSize: '20px', lineHeight: '26px', letterSpacing: '0.15px' },

      subtitle1: { fontFamily: 'Lato', fontSize: '16px', lineHeight: '19px', letterSpacing: '0.15px' },
      subtitle2: {
        fontFamily: 'Lato',
        fontWeight: 500,
        fontSize: '14px',
        lineHeight: '16.41px',
        letterSpacing: '0.1px',
      },
      body1: { fontFamily: 'Lato', fontSize: '18px', lineHeight: '200%', letterSpacing: '0.5px' },
      body2: { fontFamily: 'Lato', fontSize: '14px', lineHeight: '16px', letterSpacing: '0.25px' },
      button: { fontFamily: 'Lato', fontWeight: 500, fontSize: '14px', letterSpacing: '1.25px' },
      caption: { fontFamily: 'Lato', fontSize: '12px', lineHeight: '14px', letterSpacing: '0.4px' },
      overline: { fontFamily: 'Lato', fontSize: '10px', lineHeight: '12px', letterSpacing: '1.5px' },
    },
    overrides: {
      MuiCssBaseline: {
        '@global': {
          html: {
            height: '100%',
            padding: 0,
            margin: 0,
            width: '100vw',
          },
          body: {
            height: '100%',
            padding: 25,
            margin: 0,
            width: '100vw',
            overflowX: 'hidden',
          },
          a: {
            textDecoration: 'none',
            fontWeight: 900,
            color: paletteColors.text,
          },
        },
      },
    },
  }
}

export const darkTheme = createMuiTheme(options(true))
export const lightTheme = createMuiTheme(options(false))

export default darkTheme
