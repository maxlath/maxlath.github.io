marked = require 'marked'
renderer = new marked.Renderer();
# highlight = require 'highlight.js'

# can't make it apply the correct css
# marked.setOptions
#   highlight: (code)->
#     return highlight.highlightAuto(code).value
renderer.link = (href, title, text)->
  title or= text
  localLink = href[0] is '/'
  targetAttr = if localLink then '' else 'target="_blank"'

  return """<a #{targetAttr} href="#{href}" title="#{title}">#{text}</a>"""

module.exports = (text)-> marked text, {renderer: renderer}
