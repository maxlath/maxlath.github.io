fs = require 'fs'
_ = require './utils'
metaFiles = [ 'index.html', 'data.json', 'partials' ]
buildLi = require './build_li'

module.exports = (folder)->
  # get files names
  innerList = fs.readdirSync folder
    .filter isntMetaFile
    .map buildLi.bind(null, folder)
    .sort byDescendingDate
    .map _.property('html')
    .join '\n'

  return "<ul>#{innerList}</ul>"

byDescendingDate = (a, b)-> return a.data.date < b.data.date

isntMetaFile = (name)-> not (name in metaFiles)
