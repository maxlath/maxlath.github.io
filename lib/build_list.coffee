fs = require 'fs'
_ = require './utils'
metaFiles = [ 'index.html', 'data.json', 'partials' ]
buildLi = require './build_li'
{ addToTag } = require './build_tags'

module.exports = (folder)->
  # get files names
  innerList = fs.readdirSync folder
    .filter isntMetaFile
    .map buildLi.bind(null, folder)
    # SIDE EFFECT
    .map spreadByTags
    .sort _.sortByDescendingDate
    .map _.property('html')
    .join '\n'

  return "<ul>#{innerList}</ul>"

isntMetaFile = (name)-> (not (name in metaFiles)) and not /html$/.test name

spreadByTags = (li)->
  li.data.tags?.forEach addToTag.bind(null, li)
  return li
