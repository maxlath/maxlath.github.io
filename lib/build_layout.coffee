_ = require './utils'

module.exports = (data, main='', classes)->
  { id, title } = data
  idStr = _.attributeString 'id', id
  classesStr = _.attributeString 'class', classes
  """
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="utf-8" />
    <title>#{title}</title>
    <link rel="stylesheet" href="/assets/css/bundle.css">
  </head>
  <body>
    <nav>
      <a href="/" title="home"><i class="fa fa-home"></i></a>
    </nav>
    <main #{idStr} #{classesStr}>#{main}</main>
  </body>
  </html>
  """
