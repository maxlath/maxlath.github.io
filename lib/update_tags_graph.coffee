_ = require '../lib/utils'

combinations = (array)->
  results = []
  console.log 'array', array
  while array.length > 0
    key1 = array.pop()
    array.forEach (key2)->
      results.push [key1, key2]

  return results

module.exports =  (tagsList)->

  tagsGraph =
    nodes: []
    links: []

  tagMap = {}
  id = 0

  groupId = (P31)->
    if P31 then P31.replace /^Q/, ''
    else 0

  tagsList.forEach (tag)->
    name = tag.tag
    tagMap[name] = id
    id += 1
    group = groupId tag.data.P31
    tagsGraph.nodes.push
      name: name
      group: group
      url: "/tags/#{name}"

  linkStrenght = {}

  increaseLinkStrenght = (couple)->
    [ key1, key2 ] = couple
    if key1 > key2
      [a, b] = [key1, key2]
    else
      [a, b] = [key2, key1]

    linkStrenght[a] or= {}
    linkStrenght[a][b] or= 0
    linkStrenght[a][b] += 1

  tagsList.forEach (tag)->
    tag.items.forEach (item)->
      { tags } = item.data
      if tags?
        couples = combinations tags
        couples.forEach (couple)->
          # console.log 'couple', couple
          increaseLinkStrenght couple
      else
        console.log 'TAGS NOT FOUND'.red, Object.keys(item)

  for tag1, linkedTags of linkStrenght
    for tag2, linkValue of linkedTags
      tagsGraph.links.push
        source: tagMap[tag1]
        target: tagMap[tag2]
        value: linkValue

  _.writeJson './tags/graph.json', tagsGraph
