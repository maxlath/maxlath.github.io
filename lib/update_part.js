const _ = require('./utils')
const marked = require('./marked')

const API = module.exports = {
  writeFileUpdatedWithContent: (filepath, name, content) => {
    const file = _.readFileSync(filepath)

    const updatedFile = API.updateFile(file, content, name)

    if (updatedFile.length > 0) {
      return _.writeFile(filepath, updatedFile)
    } else {
      return console.log('updatedFile is empty'.red, name, updatedFile)
    }
  },

  getUpdatedFile: (partialPath, file) => {
    const partialContent = _.readFileSync(partialPath)

    const name = getPartialName(partialPath)
    const separator = getSeparator(name)

    return API.updateFile(file, partialContent, name)
  },

  updateFile: (file, partialContent, name, markdown) => {
    if (markdown == null) { markdown = false }
    const separator = getSeparator(name)
    // break the html on the separators
    const parts = file.split(separator)

    if (markdown) { partialContent = marked(partialContent) }

    // replace the parts between separators by the new content
    // that is, replace every odd parts
    parts.forEach(function (part, index) {
      if ((index % 2) !== 0) {
        return parts[index] = partialContent
      }
    })

    // rebuild the file with separators
    return parts.join(separator)
  }
}

const getPartialName = partialPath => partialPath.split('/').slice(-1)[0].split('.')[0]

const getSeparator = name => {
  const uppercasedName = name.toUpperCase()
  return `<!-- ${uppercasedName} -->`
}
