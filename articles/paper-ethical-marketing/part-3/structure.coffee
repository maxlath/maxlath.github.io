__ = require('config').universalPath
_ = __.require 'lib', 'utils'
{ newNode } = __.require 'lib', 'deep_list'

part3 = newNode 'part3', null, '3'

part3_1 = newNode "Toward an ecology of the spirit?", part3
part3_1_1 = newNode "Downfall of the esprit value and systemic toxicity", part3_1
part3_1_2 = newNode "The problem of added value evaluation", part3_1

part3_2 = newNode "What are the alternatives?", part3
part3_2_1 = newNode "Fighting the attention and desire resource shortage: stoping to use advertisement?", part3_2
part3_2_2 = newNode "Change in the industrial and commercial paradigm", part3_2
part3_2_3 = newNode "Opportunities of the new social organization and P2P-RM", part3_2

module.exports = part3
