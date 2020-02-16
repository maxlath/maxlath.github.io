const _ = require('./utils')
const buildNav = require('./build_nav')
const buildHead = require('./build_head')
const tabs = _.readFileSync('./partials/tabs.html')
  // on every other pages than the home, the tabs should be in top mode
  .replace('id="tabs"', 'id="tabs" class="top"')
  .replace(/href="#/g, 'href="/#')

module.exports = (data, main, classes) => {
  if (main == null) { main = '' }
  const { id, title } = data
  const idStr = _.attributeString('id', id)
  const classesStr = _.attributeString('class', classes)
  const nav = buildNav(data)
  const head = buildHead(data)

  return `<!DOCTYPE html>
<html>
${head}
<body>
  ${tabs}
  <main ${idStr} ${classesStr}>
    <nav>${nav}</nav>
    ${main}
  </main>
</body>
</html>`
}
