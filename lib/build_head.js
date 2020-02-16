const _ = require('./utils')
const escapeHtml = require('escape-html')
const host = 'http://maxlath.eu'
const defaultImage = `${host}/assets/img/path_in_the_Bois_de_Vincennes_under_the_summer_sun.jpg`

module.exports = data => {
  let { id, parent, title, image, url, fullUrl, date, tags, lang } = data

  const type = getType(parent)

  if (fullUrl == null) {
    if (url != null) {
      fullUrl = getFullUrl(url)
    } else if ((parent != null) && (id != null)) {
      fullUrl = `${host}/${parent}/${id}/`
    } else if (id != null) {
      fullUrl = `${host}/${id}/`
    }
  }

  if (image != null) {
    image = getFullUrl(image, false)
  } else {
    _.warn('missing image', id)
    image = defaultImage
  }

  // rewrite the image there to avoid Github 302 answers
  image = image
    .replace('https://github.com', 'https://raw.githubusercontent.com')
    .replace('/raw/', '/')

  title = escapeHtml(title)

  let metaHtml = `
<meta charset="utf-8" />
<title>${title}</title>
<link rel="stylesheet" href="/assets/css/bundle.css">

<link rel="alternate" type="application/rss+xml" href="http://maxlath.eu/rss.xml" title="Maxime Lathuilière Web Hub RSS">

<meta name="twitter:title" content="${title}">
<meta property="og:title" content="${title}">

<meta property="og:image" content="${image}">
<meta name="twitter:image" content="${image}">

<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:site" content="@maxlath">
<meta name="twitter:creator" content="@maxlath">

<meta property="og:site_name" content="maxlath.eu">
<meta property="og:url" content="${fullUrl}">
<meta property="og:type" content="${type}" />
`

  // lang or= 'en'
  // <meta property='og:locale' content='#{lang}' />

  let { description, cleanDesc, subtitle, cleanSub } = data

  // prefer versions cleared from markups
  const sub = cleanSub || subtitle
  const desc = cleanDesc || description

  if ((sub != null) && (desc != null) && (sub !== desc)) {
    description = `${sub} | ${desc}`
  } else {
    description = sub || desc
  }

  if (description != null) {
    description = escapeHtml(description)
    metaHtml += `\n
<meta name="twitter:description" content="${description}">
<meta name="description" property="og:description" content="${description}" />`
  } else {
    _.warn('missing description', id)
  }

  if (type === 'article') {
    if (date != null) {
      date = date.split('T')[0]
      metaHtml += `\n<meta property="og:article:published_time" content="${date}" />`
    }

    if (tags != null) {
      tags.forEach(tag => metaHtml += `\n<meta property="article:tag" content="${tag}" />`)
    }
  }

  return `<head>\n${metaHtml}\n</head>`
}

const getFullUrl = (url, trailingSlash) => {
  if (trailingSlash == null) { trailingSlash = true }
  url = (url != null ? url[0] : undefined) === '/' ? host + url : url
  // adding trailing slash
  if (trailingSlash && (url.slice(-1)[0] !== '/')) { url += '/' }
  return url
}

const getType = parent => {
  switch ((parent != null ? parent.split('/')[0] : undefined)) {
    case 'articles': case 'posts': return 'article'
    default: return 'website'
  }
}

const escapeMetaText = text => text.replace(/"/g, '\\"')
