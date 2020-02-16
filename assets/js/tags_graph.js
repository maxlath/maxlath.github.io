const width = 600
const height = 400
const color = d3.scale.category20()
const force = d3.layout.force().charge(-120).linkDistance(30).size([width, height])

const svg = d3.select('.graph')
  .append('svg')
  .attr('width', width)
  .attr('height', height)

d3.json('/tags/graph.json', (error, graph) => {
  if (error) throw error

  force.nodes(graph.nodes).links(graph.links).start()

  const link = svg.selectAll('.link')
    .data(graph.links)
    .enter()
    .append('line')
    .attr('class', 'link')
    .style('stroke-width', d => Math.sqrt(d.value))

  const node = svg.selectAll('.node')
    .data(graph.nodes)
    .enter()
    .append('circle')
    .attr('class', 'node')
    .attr('r', 10)
    .style('fill', d => color(d.group))
    .call(force.drag)

  node.append('title').text(d => d.name)

  force.on('tick', () => {
    link
    .attr('x1', d => d.source.x)
    .attr('y1', d => d.source.y)
    .attr('x2', d => d.target.x)
    .attr('y2', d => d.target.y)

    return node
    .attr('cx', d => d.x)
    .attr('cy', d => d.y)
  })

  return node.on('click', (d, i) => window.location.href = d.url)
})
