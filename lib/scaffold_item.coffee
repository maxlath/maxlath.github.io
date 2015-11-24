_ = require './utils'
{ sections, sectionsList, contentFile } = require 'config'

module.exports = (folder, title)->
  unless folder? then _.throwError 'missing folder', folder
  unless _.rootSection(folder) in sectionsList
    _.throwError 'invalid folder root section', [folder, sectionsList]

  unless title? then _.throwError 'missing title', title

  id = _.getIdFromTitle title

  newFolderPath = "./#{folder}/#{id}"
  # create item sub-directory
  _.mkdirSync newFolderPath
  # add content file
  _.writeFileSync "#{newFolderPath}/#{contentFile}", "<-- content -->"
  # add data.json
  data = buildDataBase id, title, folder
  _.writeJsonSync "#{newFolderPath}/data.json", data
  # index.html will be built on next ./scripts/build-items


buildDataBase = (id, title, parent)->
  id: id
  title: title
  subtitle: null
  description: null
  image: null
  date: new Date()
  parent: parent
