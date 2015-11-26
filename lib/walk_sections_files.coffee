{ sectionsList } = require 'config'
rread = require 'readdir-recursive'
_ = require './utils'

module.exports = (cb)->
  files = sectionsList.map walkSectionFiles.bind(null, cb)
  unless cb? then return _.flatten files

walkSectionFiles = (cb, section)->
  if cb? then rread.file "./#{section}", cb
  else rread.fileSync "./#{section}"

