_ = require './utils'

module.exports = (content, level, title, link)->
  innerWrap = buildInnerWrap content, level, title
  return wrapItAll title, addLink(innerWrap, link)

buildInnerWrap = (content, level, title)->
  title = _.capitalizeFirstLetter title
  """
    <h#{level}>#{title}</h#{level}>
    #{content}
  """

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
