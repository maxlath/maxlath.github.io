const _ = require('./utils')
const { getTitleFromTag } = require('../lib/build_tags')

module.exports = data => {
  const { title, subtitle, description, image, date, tags } = data

  let previewHeader = ''

  let previewHeaderCore = `<h3 class='title'>${title}</h3>`

  if (subtitle != null) {
    previewHeaderCore += `<span class='subtitle'>${subtitle}</span><br>`
  }

  previewHeader += `<div class='core'>${previewHeaderCore}</div>`

  const detailsHtml = getDetails(tags, date)
  if (detailsHtml.length > 0) {
    previewHeader += `<div class='details'>${detailsHtml}</div>`
  }

  // if description?
  //   description = description[0..200] + '...'
  //   previewHeader += "<p class='description'>#{description}</p>"

  return `<div class='preview-cover' style='background-image: url(${image})'>
</div>
<div class='preview-header'>${previewHeader}</div>`
}

const getDetails = (tags, date) => {
  let detailsHtml = ''

  if (date != null) {
    const dateString = _.toLogicalDayFormat(date)
    detailsHtml += `<div class='date'>${dateString}</div>`
  }

  if ((tags != null ? tags.length : undefined) > 0) {
    const tagsList = tags.map(getTitleFromTag).join(' ')
    detailsHtml += `<div class='preview-tags'>${tagsList}</div>`
  }

  return detailsHtml
}
