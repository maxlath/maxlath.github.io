/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
const _ = require('./utils')
const buildLayout = require('./build_layout')
const wrapList = require('./wrap_list')

module.exports = (folder, listHtml, classes) => {
  const folderData = _.getFolderData(folder)
  const indexHtml = wrapList(listHtml, 1, folderData)
  const index = buildLayout(folderData, indexHtml, classes)
  const path = `./${folder}/index.html`
  return _.writeFile(path, index)
}
