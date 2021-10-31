const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
  title: 'hoopR',
  tagline: "The SportsDataverse's R Package for Men's Basketball Data.",
  url: 'https://hoopR.sportsdataverse.org',
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.ico',
  organizationName: 'sportsdataverse', // Usually your GitHub org/user name.
  projectName: 'docusaurus', // Usually your repo name.
  themeConfig: {
    hideableSidebar: true,
    sidebarCollapsible: false,
    colorMode: {
      defaultMode: 'light',
      disableSwitch: false,
      respectPrefersColorScheme: true,
    },
    image: 'img/hoopR-gh.png',
    navbar: {
      hideOnScroll: true,
      title: 'hoopR',
      logo: {
        alt: 'hoopR Logo',
        src: 'img/logo.ico',
      },
      items: [
        {
          type: 'doc',
          docId: 'intro',
          position: 'left',
          label: 'Docs',
        },
        {
          label: 'Tutorial',
          position: 'left',
          items: [
            {
              label: 'Intro to hoopR',
              to: '/blog/intro-to-hoopR',
              target: '_self',
            },
            {
              label: 'KenPom Examples',
              to: '/blog/kenpom-example-functions',
              target: '_self',
            },
          ],
        },
        {
          label: 'News',
          to: 'CHANGELOG',
          position: 'left',
        },
        {
          label: 'SDV',
          position: 'left',
          items: [
            {
              href: 'https://sportsdataverse.org',
              label: 'SportsDataverse',
              target: '_self',
            },
            {
              label: 'Python Packages',
            },
            {
              label: 'sportsdataverse-py',
              href: 'https://py.sportsdataverse.org/',
              target: '_self',
            },
            {
              label: 'R Packages',
            },
            {
              label: 'cfbfastR',
              href: 'https://saiemgilani.github.io/cfbfastR/',
              target: '_self',
            },
            {
              label: 'wehoop',
              href: 'https://wehoop.sportsdataverse.org/',
              target: '_self',
            },
            {
              label: 'recruitR',
              href: 'https://saiemgilani.github.io/recruitR/',
              target: '_self',
            },
            {
              label: 'puntr',
              href: 'https://puntalytics.github.io/puntr/',
              target: '_self',
            },
            {
              label: 'gamezoneR',
              href: 'https://jacklich10.github.io/gamezoneR/',
              target: '_self',
            },
            {
              label: 'cfbplotR',
              href: 'https://kazink36.github.io/cfbplotR/',
              target: '_self',
            },
            {
              label: 'cfb4th',
              href: 'https://kazink36.github.io/cfb4th/',
              target: '_self',
            },
            {
              label: 'worldfootballR',
              href: 'https://jaseziv.github.io/worldfootballR/',
              target: '_self',
            },
            {
              label: 'baseballr',
              href: 'https://BillPetti.github.io/baseballr/',
              target: '_self',
            },
            {
              label: 'hockeyR',
              href: 'https://hockeyr.netlify.app/',
              target: '_self',
            },
            {
              label: 'fastRhockey',
              href: 'https://BenHowell71.github.io/fastRhockey/',
              target: '_self',
            },
            {
              label: 'powerplay',
              href: 'https://saiemgilani.github.io/powerplay/',
              target: '_self',
            },
            {
              label: 'Node.js Packages',
            },
            {
              label: 'sportsdataverse.js',
              href: 'https://saiemgilani.github.io/sportsdataverse/',
              target: '_self',
            },
            {
              label: 'nfl-nerd',
              href: 'https://github.com/nntrn/nfl-nerd/',
              target: '_self',
            },
          ]
        },
        {
          href: 'https://github.com/saiemgilani/hoopR',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'Docs',
              to: '/docs/intro',
            },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: 'Twitter',
              href: 'https://twitter.com/saiemgilani',
            },
            {
              label: 'SportsDataverse Twitter',
              href: 'https://twitter.com/sportsdataverse',
            },
            {
              label: 'cfbfastR Twitter',
              href: 'https://twitter.com/cfbfastR',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/saiemgilani/hoopR',
              target: '_self',
            },
            {
              label: 'SportsDataverse',
              href: 'https://sportsdataverse.org',
              target: '_self',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} <strong>hoopR</strong>, developed by <a href='https://twitter.com/saiemgilani'>Saiem Gilani</a>, part of the <a href='https://sportsdataverse.org'>SportsDataverse</a>.`,
    },
    prism: {
      theme: lightCodeTheme,
      darkTheme: darkCodeTheme,
    },
  },
  presets: [
    [
      '@docusaurus/preset-classic',
      {
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          editUrl:
            'https://github.com/saiemgilani/hoopR/edit/master/docs/',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      },
    ],
  ],
};
