_ = require './utils'
marked = require './marked'

module.exports = API =
  writeFileUpdatedWithContent: (filepath, name, content)->
    file = _.readFileSync filepath

    updatedFile = API.updateFile file, content, name

    if updatedFile.length > 0
      _.writeFile filepath, updatedFile
    else
      console.log 'updatedFile is empty'.red, name, updatedFile

  getUpdatedFile: (partialPath, file)->
    partialContent = _.readFileSync partialPath

    name = getPartialName partialPath
    separator = getSeparator name

    return API.updateFile file, partialContent, name

  updateFile: (file, partialContent, name, markdown=false)->
    separator = getSeparator name
    # break the html on the separators
    parts = file.split separator

    if markdown then partialContent = marked partialContent

    # replace the parts between separators by the new content
    # that is, replace every odd parts
    parts.forEach (part, index)->
      if index % 2 isnt 0
        parts[index] = partialContent

    # rebuild the file with separators
    return parts.join separator


getPartialName = (partialPath)->
  return partialPath.split('/').slice(-1)[0].split('.')[0]

getSeparator = (name)->
  uppercasedName = name.toUpperCase()
  "<!-- #{uppercasedName} -->"
