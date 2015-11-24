_ = require './utils'
buildLayout = require './build_layout'
marked = require 'marked'
{ getUpdatedFile } = require '../lib/update_part'
path_ = require 'path'
{ sectionsList, contentFile } = require 'config'

module.exports = (itemFolderPath)->
  data = _.getFolderData itemFolderPath
  { format, partials } = data

  path = "#{itemFolderPath}/#{contentFile}"
  _.readFile path, (err, content)->

    if err? then _.throwError err, itemFolderPath

    if partials? then content = addPartials content, data

    if format is 'markdown' then content = marked content
    else _.warn "not markdown compiled: #{path}"

    item = buildLayout data, content, 'item'
    _.writeFile indexPath(itemFolderPath), item

indexPath = (itemFolderPath)-> "./#{itemFolderPath}/index.html"


addPartials = (content, data)->
  { partials, parent, id } = data
  partials = _.forceArray partials
  partials.forEach (partialPath)->
    partialPath = path_.resolve "./#{parent}/#{id}/#{partialPath}"
    _.log 'partial path', partialPath
    content = getUpdatedFile partialPath, content

  return content
