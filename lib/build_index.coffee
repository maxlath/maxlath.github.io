_ = require './utils'
buildLayout = require './build_layout'
wrapList = require './wrap_list'

module.exports = (folder, listHtml)->
  folderData = _.getFolderData folder
  indexHtml = wrapList listHtml, 1, folderData
  index = buildLayout folderData, indexHtml
  path = "./#{folder}/index.html"
  _.writeFile path, index