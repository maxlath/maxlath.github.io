_ = require './utils'
{ getTitleFromTag } = require '../lib/build_tags'

module.exports = (data)->
  { title, subtitle, description, image, date, tags } = data

  previewHeader = ''

  previewHeaderCore = "<h3 class='title'>#{title}</h3>"

  if subtitle?
    previewHeaderCore += "<span class='subtitle'>#{subtitle}</span><br>"

  previewHeader += "<div class='core'>#{previewHeaderCore}</div>"

  detailsHtml = getDetails tags, date
  if detailsHtml.length > 0
    previewHeader += "<div class='details'>#{detailsHtml}</div>"

  # if description?
  #   description = description[0..200] + '...'
  #   previewHeader += "<p class='description'>#{description}</p>"

  """
  <div class='preview-cover' style='background-image: url(#{image})'>
  </div>
  <div class='preview-header'>#{previewHeader}</div>
  """

getDetails = (tags, date)->
  detailsHtml = ''

  if tags?.length > 0
    tagsList = tags.map(getTitleFromTag).join(' ')
    detailsHtml += "<div class='preview-tags'>#{tagsList}</div>"

  if date?
    dateString = _.toLogicalDayFormat date
    detailsHtml += "<div class='date'>#{dateString}</div>"

  return detailsHtml
