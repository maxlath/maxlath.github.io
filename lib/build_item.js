const _ = require('./utils')
const buildLayout = require('./build_layout')
const marked = require('./marked')
const { updateFile, getUpdatedFile } = require('../lib/update_part')
const path_ = require('path')
const { sectionsList, contentFile } = require('config')
const buildItemFooter = require('../lib/build_item_footer')
const { buildTag } = require('../lib/build_tags')

module.exports = itemFolderPath => {
  const data = _.getFolderData(itemFolderPath)
  const { format, partials, parent, tags, autotitle } = data

  const path = `${itemFolderPath}/${contentFile}`
  return _.readFile(path, (err, content) => {
    if (err != null) { _.throwError(err, itemFolderPath) }

    if (format === 'markdown') {
      content = marked(content)
    } else {
      _.warn(`not markdown compiled: ${path}`)
    }

    if (autotitle !== false) {
      content = buildTitleAndCover(data) + content
    }

    if ((tags != null ? tags.length : undefined) > 0) {
      content = buildTagsList(tags) + content
    }

    if (partials != null) { content = addPartials(content, data) }

    content += buildItemFooter(data)

    const childClass = parent.split('/').slice(-1)[0]
    const classes = (childClass != null) ? `item ${childClass}-child` : 'item'

    const item = buildLayout(data, content, classes)
    return _.writeFile(indexPath(itemFolderPath), item)
  })
}

const indexPath = itemFolderPath => `./${itemFolderPath}/index.html`

const buildTitleAndCover = data => {
  const { title, subtitle, image, showImageInContent = true } = data
  let titleHtml = `<h1>${title}</h1>`
  if (subtitle) titleHtml += `<strong>${subtitle}</strong>`

  let coverHtml = ''
  if (showImageInContent) {
    coverHtml = `<img src='${image}' alt='${title}'' class='cover'>`

    let { imageLink, imageTitle } = data
    if (imageLink != null) {
      if (!imageTitle) { imageTitle = title }
      coverHtml = `<a href='${imageLink}' target='_blank' title='${imageTitle}'>${coverHtml}</a>`
    }

    let { imageCredits, imageCreditsLink } = data
    if (imageCredits != null) {
      if (imageCreditsLink != null) {
        imageCredits = `<a href='${imageCreditsLink}' target='_blank'>${imageCredits}</a>`
      }

      imageCredits = `photo credits: ${imageCredits}`
      coverHtml += `<p class='credits'>${imageCredits}</p>`
    }
  }

  return titleHtml + coverHtml
}

const addPartials = (content, data) => {
  let { partials, parent, id } = data
  partials = _.forceArray(partials)
  partials.forEach(function (partialPath) {
    partialPath = path_.resolve(`./${parent}/${id}/${partialPath}`)
    _.log('partial path', partialPath)
    return content = getUpdatedFile(partialPath, content)
  })

  return content
}

const buildTagsList = tags => {
  const innerTagsList = tags
    .map(tag => buildTag(tag, null))
    .join('')

  return `<div class='tags-line'>
  <label>TAGS:</label>
  <ul>${innerTagsList}</ul>
</div>`
}
