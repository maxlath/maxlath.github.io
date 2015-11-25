__ = require('config').universalPath
_ = __.require 'lib', 'utils'

parts = [ 1, 2, 3].map (num)->
  name = "part-#{num}"
  part = require "./#{name}/structure"
  part.path = path = "#{__dirname}/#{name}"
  part.data = _.getFolderData path
  part.num = num
  return part

recursiveBuild = (child)->
  { id, level, title, children } = child

  dotedId = id.replace /-/g, '.'

  innerHtml = """
    <a href='##{id}' class='deep-#{level}'>
      <span class='rank'>#{dotedId}</span><span class='title'>#{title}</span>
    </a>
    """
  if children.length > 0
    innerList = children.map(recursiveBuild).join ''
    innerHtml += "<ul>#{innerList}</ul>"

  return "<li class='deep-#{level}'>#{innerHtml}</li>"


romanFigures = ['I', 'II', 'III']

buildSummary = (part)->
  { children, path, data, num } = part
  { title } = data
  html = children.map(recursiveBuild).join ''
  romanFig = romanFigures[num-1]
  html = """
    <h1 class="highlight">#{romanFig}.<span class="titletab"></span> #{title}</h1>
    <ul class='structure panel'>#{html}</ul>
    """

  _.writeFile "#{path}/partials/summary.html", html, true

parts.forEach buildSummary
