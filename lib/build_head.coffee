_ = require './utils'
host = 'http://maxlath.eu'
defaultImage = '#{host}/assets/img/path_in_the_Bois_de_Vincennes_under_the_summer_sun.jpg'

module.exports = (data)->
  { id, parent, title, image, url, date, tags, lang } = data

  type = getType parent


  if url? then fullUrl = getFullUrl url
  else if parent? and id? then fullUrl = "#{host}/#{parent}/#{id}/"
  else fullUrl = ''

  if image? then image = getFullUrl(image)
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
  """

  # lang or= 'en'
  # <meta property='og:locale' content='#{lang}' />

  { description, cleanedDesc, subtitle, cleanedSub } = data
  descElements = []
  # prefer versions cleared from markups
  sub = cleanedSub or subtitle
  desc = cleanedDesc or description

  if sub? and desc? then description = "#{sub} | #{desc}"
  else description = sub or desc

  if description?
    console.log id, 'description'.green, description
    metaHtml += """
    <meta name="twitter:description" content="#{description}">
    <meta name="description" property="og:description" content="#{description}" />
    """
  else
    _.warn 'missing description', id


  if type is 'article'
    metaHtml += "<meta property='og:type' content='article' />"

    if date?
      date = date.split('T')[0]
      metaHtml += "<meta property='og:article:published_time' content='#{date}' />"

    tags?.forEach (tag)->
      metaHtml += "<meta property='article:tag' content='#{tag}' />"

  return "<head>#{metaHtml}</head>"

# getFullUrl = (url, id, parent)->
#   console.log 'args'.blue, arguments
#   # url or= "/#{parent}/#{id}"
#   unless url? then url = "/#{parent}/#{id}"
#   buildFullUrl url

getFullUrl = (url)->
  if url?[0] is '/' then host + url else url

getType = (parent)->
  switch parent?.split('/')[0]
    when 'articles', 'posts' then 'article'
