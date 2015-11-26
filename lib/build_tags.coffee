__ = require('config').universalPath
_ = require '../lib/utils'

tags = {}

module.exports =
  addToTag: (li, tag)->
    console.log tag.red, li.data.id
    tags[tag] or= []
    tags[tag].push li

  getTagsLists: ->
    tagsList = []
    for tag, items of tags
      data = initDataFile tag
      data.count = items.length

      tagsList.push
        tag: tag
        items: items
        data: data

    return tagsList

  buildTag: (tag, count)->
    url = getUrlFromTag tag
    title = getTitleFromTag tag
    countHtml = if count? then "<span class='count'>(#{count})</span>" else ''
    """
    <li><a class="tag-link" href='#{url}' title='#{tag}'>
    #{title} #{countHtml}
    </a></li>
    """

initDataFile = (tag)->
  folder = "tags/#{tag}"
  try
    data = _.getFolderData folder
    data.title or= getTitleFromTag tag

  catch err
    console.log 'new tag'.green, tag
    absoluteFolderPath = __.path 'tags', tag
    absolutePath = "#{absoluteFolderPath}/data.json"
    data = tagDataBase tag
    _.mkdirpSync absoluteFolderPath
    _.writeJsonSync absolutePath, data

  return data

tagDataBase = (tag)->
  id: tag
  title: getTitleFromTag tag
  image: null
  description: null
  parent: 'tags'
  url: getUrlFromTag tag

getTitleFromTag = (tag)-> '#' + tag.replace /-/g, ' '
getUrlFromTag = (tag)-> "/tags/#{tag}"
