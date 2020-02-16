const marked = require('marked')
const renderer = new marked.Renderer()
// highlight = require 'highlight.js'

// can't make it apply the correct css
// marked.setOptions
//   highlight: (code)->
//     return highlight.highlightAuto(code).value
renderer.link = (href, title, text) => {
  if (!title) { title = text }
  const localLink = href[0] === '/'
  const targetAttr = localLink ? '' : 'target="_blank"'

  return `<a ${targetAttr} href="${href}" title="${title}">${text}</a>`
}

module.exports = text => marked(text, { renderer })
