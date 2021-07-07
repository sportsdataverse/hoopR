module.exports = {
  webpack: (config, { isServer }) => {
    if (isServer) {
      require('./scripts/generateSitemap')
    }

    return config
  },
}
