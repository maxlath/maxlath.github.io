_ = require './utils'
buildLayout = require './build_layout'
wrapList = require './wrap_list'

module.exports = (folder, listHtml)->
  indexHtml = wrapList listHtml, 1, folder
  index = buildLayout _.getFolderData(folder), indexHtml
  path = "./#{folder}/index.html"
  _.writeFile path, index