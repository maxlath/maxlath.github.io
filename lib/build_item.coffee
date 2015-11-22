_ = require './utils'
buildLayout = require './build_layout'
marked = require 'marked'
{ sectionsList, contentFile } = require 'config'

module.exports = (itemFolderPath)->
  data = _.getFolderData itemFolderPath
  _.readFile "#{itemFolderPath}/#{contentFile}", (err, content)->

    if err? then _.throwError err, itemFolderPath

    item = buildLayout data, marked(content), 'item'
    _.writeFile indexPath(itemFolderPath), item

indexPath = (itemFolderPath)-> "./#{itemFolderPath}/index.html"
