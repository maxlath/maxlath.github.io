buildIndex = require './build_index'
{ getTagsLists, buildTag } = require './build_tags'
_ = require './utils'
marked = require './marked'

module.exports = ->
  # has to run after build_list passed all the items through spreadByTags
  tagsList = getTagsLists()

  tagsList.forEach (tagData)->
    { tag, items, data } = tagData
    folder = "tags/#{tag}"
    innerList = items
      .sort _.sortByDescendingDate
      .map _.property('html')
      .join '\n'

    { fullTitle, description, image } = data

    tagHeader = ''
    # if fullTitle?
      # fullTitle = marked fullTitle
      # tagHeader += "<h2 class='full-title'>#{fullTitle}</h2>"

    if description?
      description = marked description
      tagHeader += "<div class='description'>#{description}</div>"

    if image? then tagHeader += "<img class='cover' src='#{image}' alt='#{fullTitle}'>"

    listHtml = """
      <div class='tag-context'>#{tagHeader}</div>
      <h3>related items:</h3>
      <ul>#{innerList}</ul>
    """
    buildIndex folder, listHtml, 'tags'

  innerTagsListHtml = _(tagsList)
    .sortBy (tag)-> - tag.data.count
    .map (tagData)->
      { tag, data } = tagData
      { title, count, url } = data
      return buildTag tag, count

    .join '\n'

  console.log 'innerTagsListHtml'.red, innerTagsListHtml

  tagsListHtml = "<ul>#{innerTagsListHtml}</ul>"

  tagsListHtmlWithGraph = """
      <section class='graph'></section>
      #{tagsListHtml}
      <script src="//d3js.org/d3.v3.min.js"></script>
      <script src="/assets/js/tags_graph.min.js"></script>
    """

  buildIndex 'tags', tagsListHtmlWithGraph

  return tagsListHtml