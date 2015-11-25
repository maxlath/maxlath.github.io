_ = require './utils'
{ sections, sectionsList, contentFile } = require 'config'

module.exports = (folder, title)->
  unless folder? then _.throwError 'missing folder', folder
  unless _.rootSection(folder) in sectionsList
    _.throwError 'invalid folder root section', [folder, sectionsList]

  unless title? then _.throwError 'missing title', title

  id = _.getIdFromTitle title

  # create item sub-directory
  url = "/#{folder}/#{id}"
  newFolderPath = ".#{url}"
  _.mkdirpSync newFolderPath
  _.log 'created folder', newFolderPath

  # add content file
  contentPath = "#{newFolderPath}/#{contentFile}"
  _.writeFileSync contentPath, "<-- content -->"
  _.log 'created content file', contentPath

  # add data.json
  data = buildDataBase id, title, folder
  dataPath = "#{newFolderPath}/data.json"
  _.writeJsonSync dataPath, data
  _.log 'created data file', dataPath

  _.cb url

  # index.html will be built on next ./scripts/build-items


buildDataBase = (id, title, parent)->
  id: id
  title: title
  subtitle: null
  description: null
  image: null
  date: new Date()
  parent: parent
  partials: []
  format: "markdown"
  tags: []
