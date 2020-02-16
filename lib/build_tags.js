const __ = require('config').universalPath
const _ = require('../lib/utils')
const updateTagsGraph = require('../lib/update_tags_graph')

const tags = {}

const API = module.exports = {
  addToTag: (li, tag) => {
    if (!tags[tag]) { tags[tag] = [] }
    return tags[tag].push(li)
  },

  getTagsLists: () => {
    const tagsList = []
    for (const tag in tags) {
      const items = tags[tag]
      const data = initDataFile(tag)
      data.count = items.length

      tagsList.push({
        tag,
        items,
        data
      })
    }

    updateTagsGraph(tagsList)

    return tagsList
  },

  buildTag: (tag, count) => {
    const url = API.getUrlFromTag(tag)
    const title = API.getTitleFromTag(tag)
    const countHtml = (count != null) ? `<span class='count'>(${count})</span>` : ''
    return `<li class="tag-li">
  <a class="tag-link" href='${url}' title='${tag}'>
  ${title} ${countHtml}
  </a>
</li>`
  },

  getTitleFromTag: tag => '#' + tag ,
  getUrlFromTag: tag => `/tags/${tag}`
}

const initDataFile = tag => {
  let data
  const folder = `tags/${tag}`
  try {
    data = _.getFolderData(folder)
    if (!data.title) { data.title = API.getTitleFromTag(tag) }
  } catch (err) {
    console.log('new tag'.green, tag)
    const absoluteFolderPath = __.path('tags', tag)
    const absolutePath = `${absoluteFolderPath}/data.json`
    data = tagDataBase(tag)
    _.mkdirpSync(absoluteFolderPath)
    _.writeJsonSync(absolutePath, data)
  }

  return data
}

const tagDataBase = tag => ({
  id: tag,
  title: API.getTitleFromTag(tag),
  fullTitle: null,
  image: null,
  description: null,
  parent: 'tags',
  url: API.getUrlFromTag(tag),
  wikidata: null
})
