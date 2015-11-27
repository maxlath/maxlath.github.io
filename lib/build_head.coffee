_ = require './utils'
host = 'http://maxlath.eu'
defaultImage = "#{host}/assets/img/path_in_the_Bois_de_Vincennes_under_the_summer_sun.jpg"

module.exports = (data)->
  { id, parent, title, image, url, fullUrl, date, tags, lang } = data

  type = getType parent

  unless fullUrl?
    if url? then fullUrl = getFullUrl url
    else if parent? and id? then fullUrl = "#{host}/#{parent}/#{id}"
    else if id? then fullUrl = "#{host}/#{id}"

  if image? then image = getFullUrl image, false
  else
    _.warn 'missing image', id
    image = defaultImage

  metaHtml = """
    <meta charset="utf-8" />
    <title>#{title}</title>
    <link rel="stylesheet" href="/assets/css/bundle.css">

    <meta name="twitter:title" content="#{title}">
    <meta property="og:title" content="#{title}">

    <meta property="og:image" content="#{image}">
    <meta name="twitter:image" content="#{image}">

    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:site" content="@maxlath">
    <meta name="twitter:creator" content="@maxlath">

    <meta property="og:site_name" content="maxlath.eu">
    <meta property="og:url" content="#{fullUrl}">
    <meta property="og:type" content="#{type}" />
  """

  # lang or= 'en'
  # <meta property='og:locale' content='#{lang}' />

  { description, cleanDesc, subtitle, cleanSub } = data

  # prefer versions cleared from markups
  sub = cleanSub or subtitle
  desc = cleanDesc or description

  if sub? and desc? then description = "#{sub} | #{desc}"
  else description = sub or desc

  if description?
    metaHtml += """\n
    <meta name="twitter:description" content="#{description}">
    <meta name="description" property="og:description" content="#{description}" />
    """
  else
    _.warn 'missing description', id


  if type is 'article'
    if date?
      date = date.split('T')[0]
      metaHtml += """\n<meta property="og:article:published_time" content="#{date}" />"""

    tags?.forEach (tag)->
      metaHtml += """\n<meta property="article:tag" content="#{tag}" />"""

  return "<head>\n#{metaHtml}\n</head>"

getFullUrl = (url, trailingSlash=true)->
  url = if url?[0] is '/' then host + url else url
  # adding trailing slash
  # if trailingSlash and url.slice(-1)[0] isnt '/' then url += '/'
  return url

getType = (parent)->
  switch parent?.split('/')[0]
    when 'articles', 'posts' then 'article'
    else 'website'
