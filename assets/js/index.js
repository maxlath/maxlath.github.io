const placeHolderEl = document.querySelector('#expanded-tabs-placeholder')
const tabsList = ['about', 'projects', 'articles', 'posts', 'links']
const elementsList = ['tabs'].concat(tabsList)
const elements = {}

const getElementData = elName => {
  const el = document.querySelector(`#${elName}`)
  el.top = el.offsetTop
  el.bottom = el.offsetTop + el.offsetHeight
  if (tabsList.includes(elName)) {
    el.tab = document.querySelector(`a[href='#${elName}']`)
  }
  return el
}

elementsList.forEach(elName => elements[elName] = getElementData(elName))

const margin = 100
const updateTabsPosition = e => {
  const { pageYOffset } = window
  const { tabs, about, projects, articles, posts, links } = elements

  if (pageYOffset > tabs.bottom) expandTabBar()
  else reduceTabBar()

  if (pageYOffset < about.top) {
    return selectTab(null)
  } else if (pageYOffset < (projects.top - margin)) {
    return selectTab('about')
  } else if (pageYOffset < (articles.top - margin)) {
    return selectTab('projects')
  } else if (pageYOffset < (posts.top - margin)) {
    return selectTab('articles')
  } else if (pageYOffset < (links.top - margin)) {
    return selectTab('posts')
  } else {
    return selectTab('links')
  }
}

// flags used for debouncing with early returns when there is nothing to change
let lastStateIsExpanded = false
let lastSelectedTab = null

const expandTabBar = () => {
  if (lastStateIsExpanded) return
  placeHolderEl.style.display = 'block'
  elements.tabs.classList.add('expanded')
  return lastStateIsExpanded = true
}

const reduceTabBar = () => {
  if (!lastStateIsExpanded) return
  placeHolderEl.style.display = 'none'
  elements.tabs.classList.remove('expanded')
  return lastStateIsExpanded = false
}

const selectTab = tabName => {
  if (tabName === lastSelectedTab) return

  unselect(lastSelectedTab)
  select(tabName)
  return lastSelectedTab = tabName
}

const select = tabName => {
  if (tabName != null) {
    elements[tabName].tab.classList.add('selected')
    // updating the hash without jumping to it
    return history.pushState(null, null, `#${tabName}`)
  }
}

const unselect = tabName => {
  if (tabName != null) return elements[tabName].tab.classList.remove('selected')
}

window.addEventListener('scroll', updateTabsPosition)
