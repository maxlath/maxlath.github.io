_ = require './utils'

module.exports = (content, level, data, link)->
  { title } = data
  innerWrap = buildInnerWrap content, level, data
  return wrapItAll title, addLink(innerWrap, link)

buildInnerWrap = (content, level, data)->
  { title, subtitle } = data
  title = _.capitalizeFirstLetter title
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

wrapItAll = (title, innerWrap)->
  id = _.getIdFromTitle title
  "<section id='#{id}'>#{innerWrap}</section>"
