__ = require('config').universalPath
_ = __.require 'lib', 'utils'
{ newNode } = __.require 'lib', 'deep_list'

part2 = newNode 'part2', null, '2'

part2_1 = newNode "Foundation of Bernard Stiegler's work: Indetermination of technique, pharmacology and organology", part2

part2_2 = newNode "Behavior sciences and marketing co-developments: the rush for motivation and the consumerist era", part2
part2_2_1 = newNode "Freud's core concept: the libidinal economy", part2_2
part2_2_2 = newNode "Freud's American nephew: Edward Bernays", part2_2
part2_2_2_1 = newNode "The birth of Public Relations", part2_2_2
part2_2_2_2 = newNode " "Without mind control to minimize cleavages, democracy would be chaos"", part2_2_2
part2_2_3 = newNode "From a scientific approach of propaganda to the birth of modern marketing: the science of motivation", part2_2
part2_2_4 = newNode "Problems inherent to marketing's scientific approach of its influence on behaviors: playing with the system limits", part2_2
part2_2_5 = newNode "The Birth of Consumer Behavior and consumerism", part2_2
part2_2_5_1 = newNode "From Consumerism to mass consumerism", part2_2_5


part2_3 = newNode "The use of psycho-technologies by marketing as the continuation of biopower by psychopower", part2
part2_3_1 = newNode "The Simondonian psychic apparatus genesis: psychic and collective individuation", part2_3
part2_3_2 = newNode "Powers upon individuals", part2_3
part2_3_2_1 = newNode "Biopower and psychopower", part2_3_2
part2_3_2_2 = newNode "Neuropower", part2_3_2
part2_3_3 = newNode "Esprit capacities and psychotechniques", part2_3
part2_3_3_1 = newNode "Memory and attention", part2_3_3
part2_3_3_3 = newNode "Psychotechnology", part2_3_3
part2_3_4 = newNode "Formation and capture of attention and the capacity of care", part2_3

part2_4 = newNode "How marketing use of psychopower plays with system limits toward attention capture and motivation canalization, producing the destruction of the capacity of care and of desire", part2
part2_4_1 = newNode "Consumerism as the opposite of the care", part2_4
part2_4_2 = newNode "Marketing use of psychotechnologies through the highly strategic cultural and program industries", part2_4
part2_4_3 = newNode "Marketing versus the intergenerational transmission of savoir and the constitution of a Super-Ego", part2_4
part2_4_4 = newNode "Esprit resources shortage", part2_4
part2_4_5 = newNode "Trans-individuation short-circuit, disaffected individuals, symbolic misery", part2_4

module.exports = part2
