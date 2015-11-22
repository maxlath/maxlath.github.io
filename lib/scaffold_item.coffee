_ = require './utils'
{ sections, sectionsList, contentFile } = require 'config'

module.exports = (folder, name)->
  unless folder? then _.throwError 'missing folder', folder
  unless _.rootSection(folder) in sectionsList
    _.throwError 'invalid folder root section', [folder, sectionsList]

  unless name? then _.throwError 'missing name', name

  newFolderPath = "./#{folder}/#{name}"
  # create item sub-directory
  _.mkdirSync newFolderPath
  # add content file
  _.writeFileSync "#{newFolderPath}/#{contentFile}", "<-- content -->"
  # add data.json with title=name
  _.writeJsonSync "#{newFolderPath}/data.json", buildDataBase(name)
  # build index.html from content and data or wait for next rebuild?


buildDataBase = (name)->
  title: name
  description: null
  image: null
  date: new Date()
