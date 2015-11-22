module.exports = (data, main='', classes='')->
  { title } = data
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
    <main class="#{classes}">#{main}</main>
  </body>
  </html>
  """
