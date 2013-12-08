module Huffman
	module LetterFrequency
		extend self

		def get_frequencies(txt)

			# {} permet de déclarer un tableau associatif
			frequencies = Hash.new(0)
			txt.each_char{|char| frequencies[char] += 1 }

			# return

			# Le tableau des frequences est trié par frequences croissantes
			# [
			#	['a' => 1],
			# ...
			# ]
			frequencies.sort_by{|h| [h[1], h[0]]}
		end
	end
end
