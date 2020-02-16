const _ = require('./utils')
const buildPreview = require('./build_preview')

module.exports = (folder, name) => {
  const relativePath = `${folder}/${name}`
  const absolutePath = `/${relativePath}/`
  const data = _.getFolderData(relativePath)
  const preview = buildPreview(data)
  return {
    html: `<li><a href='${absolutePath}'>${preview}</a></li>`,
    data
  }
}
