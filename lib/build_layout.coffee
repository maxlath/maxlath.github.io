_ = require './utils'
buildNav = require './build_nav'
buildHead = require './build_head'
tabs = _.readFileSync './partials/tabs.html'
  # on every other pages than the home, the tabs should be in top mode
  .replace('id="tabs"', 'id="tabs" class="top"')
  .replace(/href="#/g, 'href="/#')

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
    #{tabs}
    <nav>#{nav}</nav>
    <main #{idStr} #{classesStr}>#{main}</main>
  </body>
  </html>
  """
