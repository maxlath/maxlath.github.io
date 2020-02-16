const { sectionsList } = require('config')
const rread = require('readdir-recursive')
const _ = require('./utils')

module.exports = cb => {
  const files = sectionsList.map(walkSectionFiles.bind(null, cb))
  if (cb == null) return _.flatten(files)
}

const walkSectionFiles = (cb, section) => {
  if (cb != null) {
    return rread.file(`./${section}`, cb)
  } else {
    return rread.fileSync(`./${section}`)
  }
}
