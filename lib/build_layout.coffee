_ = require './utils'
buildNav = require './build_nav'

module.exports = (data, main='', classes)->
  { id, title } = data
  idStr = _.attributeString 'id', id
  classesStr = _.attributeString 'class', classes
  nav = buildNav data
  """
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="utf-8" />
    <title>#{title}</title>
    <link rel="stylesheet" href="/assets/css/bundle.css">
  </head>
  <body>
    <nav>#{nav}</nav>
    <main #{idStr} #{classesStr}>#{main}</main>
  </body>
  </html>
  """
