_ = require './utils'
buildPreview = require './build_preview'

module.exports = (folder, name)->
  relativePath = "#{folder}/#{name}"
  absolutePath = "/#{relativePath}/"
  data = _.getFolderData relativePath
  preview = buildPreview data
  return li =
    html: "<li><a href='#{absolutePath}'>#{preview}</a></li>"
    data: data
