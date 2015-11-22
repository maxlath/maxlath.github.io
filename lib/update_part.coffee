_ = require './utils'

module.exports = (filepath, separator, content)->
  file = _.readFileSync filepath

  # break the html on the separators
  parts = file.split separator
  # replace the part between separator by the new content
  parts[1] = content

  # rebuild the file with separators
  updatedFile = parts.join separator

  # console.log 'updatedFile', updatedFile

  _.writeFile filepath, updatedFile
