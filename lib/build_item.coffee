_ = require './utils'
buildLayout = require './build_layout'
marked = require 'marked'
{ updateFile, getUpdatedFile } = require '../lib/update_part'
path_ = require 'path'
{ sectionsList, contentFile } = require 'config'

buildItemFooter = require '../lib/build_item_footer'

module.exports = (itemFolderPath)->
  data = _.getFolderData itemFolderPath
  { format, partials, parent } = data

  path = "#{itemFolderPath}/#{contentFile}"
  _.readFile path, (err, content)->

    if err? then _.throwError err, itemFolderPath

    content = addFooter content, data

    if partials? then content = addPartials content, data

    if format is 'markdown' then content = marked content
    else _.warn "not markdown compiled: #{path}"

    childClass = parent.split('/').slice(-1)[0]
    classes = if childClass? then "item #{childClass}-child" else 'item'

    item = buildLayout data, content, classes
    _.writeFile indexPath(itemFolderPath), item

indexPath = (itemFolderPath)-> "./#{itemFolderPath}/index.html"

addFooter = (content, data)->
  footer = buildItemFooter data
  return updateFile content, footer, 'itemfooter'

addPartials = (content, data)->
  { partials, parent, id } = data
  partials = _.forceArray partials
  partials.forEach (partialPath)->
    partialPath = path_.resolve "./#{parent}/#{id}/#{partialPath}"
    _.log 'partial path', partialPath
    content = getUpdatedFile partialPath, content

  return content
