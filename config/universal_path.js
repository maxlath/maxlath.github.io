const appRoot = require('app-root-path').path

module.exports = {
  paths: {
    root: '',
    lib: '/lib',
    scripts: '/scripts',
    articles: '/articles',
    posts: '/posts',
    tags: '/tags',
    slides: '/slides',
    assets: '/assets',
    img: '/assets/img'
  },
  path: function (route, name) {
    const path = this.paths[route]
    return `${appRoot}${path}/${name}`
  },
  require: function (route, name) {
    return require(this.path(route, name))
  }
}
