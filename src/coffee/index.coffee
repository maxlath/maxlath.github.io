placeHolderEl = document.querySelector('#expanded-tabs-placeholder')
tabsList = [ 'about', 'projects', 'articles', 'posts', 'links' ]
elementsList = [ 'tabs' ].concat(tabsList)
elements = {}

getElementData = (elName)->
  el = document.querySelector "##{elName}"
  el.top = el.offsetTop
  el.bottom = el.offsetTop + el.offsetHeight
  if elName in tabsList
    el.tab = document.querySelector "a[href='##{elName}']"
  return el

elementsList.forEach (elName)-> elements[elName] = getElementData elName
console.log('elements', window.elements = elements)

margin = 100
updateTabsPosition = (e)->
  { pageYOffset } = window
  { about, projects, articles, posts, links } = elements

  if pageYOffset > elements.tabs.bottom then expandTabBar()
  else if pageYOffset < elements.tabs.top then reduceTabBar()

  if pageYOffset < about.top - margin then selectTab null
  else if pageYOffset < projects.top - margin then selectTab 'about'
  else if pageYOffset < articles.top - margin then selectTab 'projects'
  else if pageYOffset < posts.top - margin then selectTab 'articles'
  else if pageYOffset < links.top - margin then selectTab 'posts'
  else selectTab 'links'


# flags used for debouncing with early returns when there is nothing to change
lastStateIsExpanded = false
lastSelectedTab = null

expandTabBar = ->
  if lastStateIsExpanded then return
  placeHolderEl.style.display = 'block'
  elements.tabs.classList.add 'expanded'
  lastStateIsExpanded = true

reduceTabBar = ->
  unless lastStateIsExpanded then return
  placeHolderEl.style.display = 'none'
  elements.tabs.classList.remove 'expanded'
  lastStateIsExpanded = false

selectTab = (tabName)->
  if tabName is lastSelectedTab then return

  unselect lastSelectedTab
  select tabName
  lastSelectedTab = tabName

select = (tabName)->
  if tabName? then elements[tabName].tab.classList.add 'selected'
unselect = (tabName)->
  if tabName? then elements[tabName].tab.classList.remove 'selected'

window.addEventListener 'scroll', updateTabsPosition
