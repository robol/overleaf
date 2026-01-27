settings = {
  siteUrl: process.env.SITE_URL || 'localhost',
  apis: {
    geoIpLookup: {
      url: 'https://json.geoiplookup.io/'
    },
  }
}

module.exports = settings;
