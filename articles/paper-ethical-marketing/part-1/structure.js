const __ = require('config').universalPath
const { newNode } = __.require('lib', 'deep_list')

const part1 = newNode('part1', null, '1')

const part1_1 = newNode('Marketing definition', part1)
const part1_1_1 = newNode('Reframing marketing', part1_1)
const part1_1_2 = newNode('The marketing strategy and its implementation through the 4P: analyzing and sending signals', part1_1)

const part1_2 = newNode('Critiques of the marketing leading to the ethical marketing approach', part1)

const part1_3 = newNode('Responsible marketing as a mirror of corporate responsibility', part1)

const part1_4 = newNode('The Corporate Social Responsibility insufficiencies regarding marketing', part1)

module.exports = part1
