tabsEl = document.querySelector('#tabs')
placeHolderEl = document.querySelector('#expanded-tabs-placeholder')
tabsTop = tabsEl.offsetTop
tabsBottom = tabsTop + tabsEl.offsetHeight

updateTabsPosition = (e)->
  if e.pageY > tabsBottom then expandTabBar()
  else if e.pageY < tabsTop then reduceTabBar()

expandTabBar = ->
  placeHolderEl.style.display = 'block'
  tabsEl.classList.add('expanded')

reduceTabBar = ->
  placeHolderEl.style.display = 'none'
  tabsEl.classList.remove('expanded')

window.addEventListener 'scroll', updateTabsPosition
