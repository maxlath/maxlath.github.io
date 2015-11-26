_ = require './utils'
buildNav = require './build_nav'
buildHead = require './build_head'

module.exports = (data, main='', classes)->
  { id, title } = data
  idStr = _.attributeString 'id', id
  classesStr = _.attributeString 'class', classes
  nav = buildNav data
  head = buildHead data

  """
  <!DOCTYPE html>
  <html>
  #{head}
  <body>
    <nav>#{nav}</nav>
    <main #{idStr} #{classesStr}>#{main}</main>
  </body>
  </html>
  """
