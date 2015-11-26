_ = require './utils'
marked = require 'marked'

module.exports = (content, level, data, link)->
  innerWrap = buildInnerWrap content, level, data
  innerWrap = addLink innerWrap, link

  # don't wrap it in a section if its already the highest level
  # as there is no more point in making it a sections
  # and <main> will already have its id
  if level is 1 then return innerWrap
  else return wrapItAll data, innerWrap

buildInnerWrap = (content, level, data)->
  { title, fullTitle, subtitle, description } = data
  if fullTitle? then title = marked fullTitle
  innerWrap = "<h#{level} class='title'>#{title}</h#{level}>"
  if subtitle?
    innerWrap += "<span class='legend'>#{subtitle}</span>"

  innerWrap += content
  return innerWrap

addLink = (innerWrap, link)->
  if link? then innerWrap += """
    <div class='more'>
      <a href='#{link}'><i class="fa fa-angle-right"></i>see all</a>
    </div>
    """
  return innerWrap

wrapItAll = (data, innerWrap)->
  { id } = data
  "<section id='#{id}'>#{innerWrap}</section>"
