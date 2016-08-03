placeHolderEl = document.querySelector('#expanded-tabs-placeholder')
tabsList = [ 'projects', 'articles', 'posts', 'links' ]
elementsList = [ 'tabs' ].concat(tabsList)
elements = {}

getElementData = (elName)->
  el = document.querySelector("##{elName}")
  el.top = el.offsetTop
  el.bottom = el.offsetTop + el.offsetHeight
  if elName in tabsList
    el.tab = document.querySelector("a[href='##{elName}']")
  return el

elementsList.forEach (elName)-> elements[elName] = getElementData elName

margin = 25
updateTabsPosition = (e)->
  { pageY } = e
  { projects, articles, posts, links } = elements

  if pageY > elements.tabs.bottom then expandTabBar()
  else if pageY < elements.tabs.top then reduceTabBar()

  if pageY < projects.top - margin then unselectAll()
  else if pageY < articles.top - margin then selectTab 'projects'
  else if pageY < posts.top - margin then selectTab 'articles'
  else if pageY < links.top - margin then selectTab 'posts'
  else selectTab 'links'

expandTabBar = ->
  placeHolderEl.style.display = 'block'
  elements.tabs.classList.add 'expanded'

reduceTabBar = ->
  placeHolderEl.style.display = 'none'
  elements.tabs.classList.remove 'expanded'

selectTab = (tabName)->
  tabsList
  .filter NotThisTab(tabName)
  .forEach unselect

  select tabName

select = (tabName)-> if tabName? then elements[tabName].tab.classList.add 'selected'
unselect = (tabName)-> elements[tabName].tab.classList.remove 'selected'
NotThisTab = (excludedTabName)-> (tabName)-> tabName isnt excludedTabName
unselectAll = selectTab.bind(null, null)

window.addEventListener 'scroll', updateTabsPosition
