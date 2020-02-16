const buildIndex = require('./build_index')
const { getTagsLists, buildTag } = require('./build_tags')
const _ = require('./utils')
const marked = require('./marked')

module.exports = () => {
  // has to run after build_list passed all the items through spreadByTags
  const tagsList = getTagsLists()

  tagsList.forEach(tagData => {
    const { tag, items, data } = tagData
    const folder = `tags/${tag}`
    const innerList = items
      .sort(_.sortByDescendingDate)
      .map(_.property('html'))
      .join('\n')

    let { fullTitle, description, image } = data

    let tagHeader = ''
    // if fullTitle?
    // fullTitle = marked fullTitle
    // tagHeader += "<h2 class='full-title'>#{fullTitle}</h2>"

    if (description != null) {
      description = marked(description)
      tagHeader += `<div class='description'>${description}</div>`
    }

    if (image != null) { tagHeader += `<img class='cover' src='${image}' alt='${fullTitle}'>` }

    const listHtml = `<div class='tag-context'>${tagHeader}</div>
<h3>related items:</h3>
<ul>${innerList}</ul>`
    return buildIndex(folder, listHtml, 'tags')
  })

  const innerTagsListHtml = _(tagsList)
    .sortBy(tag => -tag.data.count)
    .map(tagData => {
      const { tag, data } = tagData
      const { title, count, url } = data
      return buildTag(tag, count)
    })
    .join('\n')

  const tagsListHtml = `<ul>${innerTagsListHtml}</ul>`

  const tagsListHtmlWithGraph = `<section class='graph'></section>
${tagsListHtml}
<script src="//d3js.org/d3.v3.min.js"></script>
<script src="/assets/js/tags_graph.min.js"></script>`

  buildIndex('tags', tagsListHtmlWithGraph)

  return tagsListHtml
}
