module.exports =
  universalPath: require './universal_path'
  sectionsList: ['articles', 'posts']
  contentFile: 'content.md'
  # use to reload only content you are working on
  lazyFolders: [
    'posts'
    'articles/p2p-rm'
  ]
