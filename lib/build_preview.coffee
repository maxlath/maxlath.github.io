_ = require './utils'

module.exports = (data)->
  { title, subtitle, description, image, date } = data

  previewHeader = ''

  if date?
    dateString = _.toLogicalDayFormat date
    previewHeader += "<span class='date'>#{dateString}</span>"

  previewHeader += "<h3 class='title'>#{title}</h3>"

  if subtitle? then previewHeader += "<span class='subtitle'>#{subtitle}</span><br>"

  # if description?
  #   description = description[0..200] + '...'
  #   previewHeader += "<p class='description'>#{description}</p>"

  """
  <div class='preview-cover' style='background-image: url(#{image})'>
  </div>
  <div class='preview-header'>#{previewHeader}</div>
  """