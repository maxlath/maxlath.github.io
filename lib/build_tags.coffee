__ = require('config').universalPath
_ = require '../lib/utils'
updateTagsGraph = require '../lib/update_tags_graph'

tags = {}

module.exports = API =
  addToTag: (li, tag)->
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

    updateTagsGraph tagsList

    return tagsList

  buildTag: (tag, count)->
    url = API.getUrlFromTag tag
    title = API.getTitleFromTag tag
    countHtml = if count? then "<span class='count'>(#{count})</span>" else ''
    """
    <li class="tag-li">
      <a class="tag-link" href='#{url}' title='#{tag}'>
      #{title} #{countHtml}
      </a>
    </li>
    """

  getTitleFromTag: (tag)-> '#' + tag
  getUrlFromTag: (tag)-> "/tags/#{tag}"

initDataFile = (tag)->
  folder = "tags/#{tag}"
  try
    data = _.getFolderData folder
    data.title or= API.getTitleFromTag tag

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
  title: API.getTitleFromTag tag
  fullTitle: null
  image: null
  description: null
  parent: 'tags'
  url: API.getUrlFromTag tag
  wikidata: null
