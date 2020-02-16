const _ = require('./utils')
const { sections, sectionsList, contentFile } = require('config')

module.exports = (folder, title) => {
  let needle
  if (folder == null) { _.throwError('missing folder', folder) }
  if ((needle = _.rootSection(folder), !Array.from(sectionsList).includes(needle))) {
    _.throwError('invalid folder root section', [folder, sectionsList])
  }

  if (title == null) { _.throwError('missing title', title) }

  const id = _.getIdFromTitle(title)

  // create item sub-directory
  const url = `/${folder}/${id}`
  const newFolderPath = `.${url}`
  _.mkdirpSync(newFolderPath)
  _.log('created folder', newFolderPath)

  // add content file
  const contentPath = `${newFolderPath}/${contentFile}`
  _.writeFileSync(contentPath, '<-- content -->')
  _.log('created content file', contentPath)

  // add data.json
  const data = buildDataBase(id, title, folder)
  const dataPath = `${newFolderPath}/data.json`
  _.writeJsonSync(dataPath, data)
  _.log('created data file', dataPath)

  return _.cb(url)
}

// index.html will be built on next ./scripts/build-items

const buildDataBase = (id, title, parent) => ({
  id,
  title,
  subtitle: null,
  description: null,
  cleanDesc: null,
  image: null,
  date: new Date(),
  parent,
  partials: [],
  format: 'markdown',
  tags: [],
  lang: 'en'
})
