---
title: 'Material UI and Next.js – How to Toggle the Selected Theme with React Context'
date: '2020-11-24'
description: 'Material-UI comes with great support for applying a theme to all components of your app. However, if you want to allow your users to toggle between different modes, like dark and light mode, there is no built-in solution for this use case. In this post, we are going to see how this feature can be easily implemented with React context.'
featured: true
topics: React,Material-UI,Next.js,React Hooks,React Context
recommended: null
---

This is the second post in the series about how this blog functions, and it is an example of a use case for when to apply React context and how this can be achieved.

Material-UI comes with great support for applying a theme to all components of your app. However, if you want to allow your users to toggle between different modes, like dark and light mode, there is no built-in solution for this use case.
We can however, implement it in a straight forward way by creating a custom [theme provider](https://material-ui.com/customization/theming/#theme-provider) 
and applying [React context](https://reactjs.org/docs/context.html).

## React context explained

Theming a web app is a great use case for when to apply context in a React app. You might want to use
context in all those cases that you usually would have to pass down props through many levels of your virtual DOM.
For a theme, components on all levels of your app might depend it, starting from the bar at the top of your app down to the buttons deep down in the DOM hierarchy. Passing down props through this many levels would complicate your app and make refactorings much more difficult. Here, context comes in handy. Applying context in a React app involves two roles:

* A provider is responsible for storing the values relating to the context and for making it accessible to its children.
* The consumers have to be children of the provider. They have access to its values. These values are not passed as props,
instead there is a `useContext` hook to access them.

## Theme context in Material-UI

You can find all code for this blog post in the Github repository of this blog's implementation.
The following snippets are taken from _src/theme/ThemeProvider.tsx_.

Material-UI already brings a provider for accessing the current theme with it out of the box:

```typescript
      <MuiThemeProvider theme={selectedTheme.appliedTheme}>
        <CssBaseline />
        {children}
      </MuiThemeProvider>
```

We pass the content of the app to this provider as its children. One example of the children
using the provider to get the themed values are the `useStyles`/`makeStyles` calls in our app.
You can find the following for example in _src/components/PreviewCard.tsx_:
```typescript
const useStyles = makeStyles((theme) => ({
  card: {
    width: 400,
    [theme.breakpoints.down('md')]: {
      width: 430,
    },
    // ...
  }
}))

export const PreviewCard: FC<PreviewCardProps> = ({ post, noMargin }): ReactElement => {
  const classes = useStyles()
  // ...
}
```

Still, there is no solution for toggling the theme, so we have to implement it ourselves.
We also have to make sure when switching between pages, the selected theme stays the same for each user,
and in all of this have to consider the workings of React.js.

Let's take a look at the complete code and then walk through it:

```typescript
interface ThemeProviderProps {
  children: React.ReactNode
}

export const ToggleThemeContext = React.createContext({
  toggleTheme: () => {},
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
``` 
We firstly create the context ``ToggleThemeContext``. This context gets a function that will be used to toggle between dark
and light mode and initially has an "empty" implementation. The actual implementation is specified in the ``ThemeContext.Provider`` definition.

In the provider, we ``useState`` to keep track of the selected theme. Also, the name of this theme gets saved in _localStorage_.
This makes sure that whenever the user visits the blog, the correct theme gets applied directly by our ``useEffect``, where the value
written to _localStorage_ is evaluated.

As the provider wraps the whole blog, we could make it possible in every component to both toggle and access the current theme.
We can use another React hook – ``useContext`` – in _src/components/TopBar.tsx_ to toggle the selected theme and to show either
the sun or the moon icon on the toggle button, depending on the currently selected theme:
```typescript
export const TopBar = (): ReactElement => {
  const trigger = useScrollTrigger()
  const classes = useStyles()
  const { toggleTheme, isDark } = useContext(ToggleThemeContext)

  return (
    // ...
    <div className={classes.toolbarRight}>
      <Tooltip title="Toggle Theme">
        <Button variant="text" color="inherit" onClick={toggleTheme}>
          {isDark ? <SunIcon /> : <MoonIcon />}
        </Button>
      </Tooltip>
    </div>
  )
}
```

## Theming an app with Next.js
There is just one caveat left that we have to deal with: As the blog is a Next.js application, the page contents get prerendered
on the server. The server, however, has no way of knowing what theme the user has selected. Also note that ``localStorage`` is only
used on client-side in the code above, to avoid the server from trying to execute this code (which would not make any sense).

If we kept our app as it is, the standard theme would be the dark theme, and clients would receive prerendered content themed this way, even if they prefer the light mode. This would cause the client-side Javascript code to override the server styles as soon as it is ready, potentially leading to flashing content.

We can deal with this situation in _\_app.tsx_ as follows:

```typescript
const MyApp = ({ Component, pageProps }: AppProps): React.ReactNode => {
  const [style, setStyle] = useState<React.CSSProperties>({ visibility: 'hidden' })
  useEffect(() => {
    const jssStyles = document.querySelector('#jss-server-side')
    if (jssStyles) {
      jssStyles.parentElement.removeChild(jssStyles)
    }
    setStyle({})
  }, [])

  return (
    <>
      <div className={styles['app-container']} style={style}>
        <ThemeProvider>
          <div className={styles['content-container']}>
            <TopBar />
            <Component {...pageProps} />
          </div>
          <Footer />
        </ThemeProvider>
      </div>
    </>
  )
}
```

Initially, the content of our page receives the ``visibility: 'hidden'`` property. That is how it is rendered by the server,
and how the client is going to receive it. Our visitors can't see the content until the ``useEffect`` hook is executed.
Even if this approach slightly increases the time until visitors see the blog, we still benefit from 
server-side rendering: The DOM is already rendered by the server, so the time is faster than with a usual single-page app.
Also, the contents of the page are directly visible in the page HTML code, which brings benefits concerning Google and other 
search engines.

## When to use context in React?
If you have only a few props that you need to pass to a component's children and nesting is not deep, context may introduce
additional complexity that should better be avoided. 

Instead, context can be applied in those cases were some data or functionality needs to be accessible by many components in different levels
of your DOM. Another example for a good context use case is i18n. Your components contain text probably on all levels of the component tree.


It should be noted that not in all cases, you want to implement the context provider on the top level of your app
as we did it here. It is also is possible to create a context provider that only serves a subtree of your app. Let's take
a complex table as an example which displays data about items, but it also can be filtered by different attributes, rows 
include checkboxes and buttons which trigger actions, etc. If this table becomes fairly complex, it might make sense
to introduce a new context at the top level of this table which provides functions for managing the state of this table,
potentially via a _useReducer_. All subcomponents of the table now can directly use these functions, which makes the app simpler.