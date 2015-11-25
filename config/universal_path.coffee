appRoot = require('app-root-path').path

module.exports =
  paths:
    root: ''
    lib: '/lib'
    scripts: '/scripts'
    articles: '/articles'
    posts: '/posts'
    slides: '/slides'
    assets: '/assets'
    img: '/assets/img'
  path: (route, name)->
    path = @paths[route]
    return "#{appRoot}#{path}/#{name}"
  require: (route, name)-> require @path(route, name)
