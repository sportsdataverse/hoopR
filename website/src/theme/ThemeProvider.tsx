import React, { useCallback, useEffect, useState } from 'react'
import { MuiThemeProvider, CssBaseline } from '@material-ui/core'
import { lightTheme, darkTheme } from './theme'
import { Theme } from '@material-ui/core'

interface ThemeProviderProps {
  children: React.ReactNode
}

export const ToggleThemeContext = React.createContext({
  toggleTheme: () => {
    console.log()
  },
  isDark: false,
})

type SelectedTheme = {
  themeName: string
  appliedTheme: Theme
}

export const ThemeProvider: React.FC<ThemeProviderProps> = ({ children }: ThemeProviderProps) => {
  const [selectedTheme, setSelectedTheme] = useState<SelectedTheme>({ appliedTheme: darkTheme, themeName: 'darkTheme' })

  useEffect(() => {
    const theme = localStorage.getItem('theme')
    if (theme && theme === 'lightTheme') {
      setSelectedTheme({ appliedTheme: lightTheme, themeName: 'lightTheme' })
    }
  }, [])

  const toggleTheme = useCallback(() => {
    if (!selectedTheme || selectedTheme.themeName === 'darkTheme') {
      setSelectedTheme({ appliedTheme: lightTheme, themeName: 'lightTheme' })
      localStorage.setItem('theme', 'lightTheme')
    } else {
      setSelectedTheme({ appliedTheme: darkTheme, themeName: 'darkTheme' })
      localStorage.setItem('theme', 'darkTheme')
    }
  }, [selectedTheme, setSelectedTheme])

  return (
    <ToggleThemeContext.Provider value={{ toggleTheme, isDark: !(selectedTheme.themeName === 'lightTheme') }}>
      <MuiThemeProvider theme={selectedTheme.appliedTheme}>
        <CssBaseline />
        {children}
      </MuiThemeProvider>
    </ToggleThemeContext.Provider>
  )
}

export default ThemeProvider
