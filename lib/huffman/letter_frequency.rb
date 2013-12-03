module Huffman
	module LetterFrequency
		extend self

		def get_frequencies(txt)

			# {} permet de déclarer le tableau associatif
			frequencies = {}
			txt.each_char{|char| frequencies[char] = frequencies.has_key?(char) ? frequencies[char] + 1 : 1 }
			
			# return
			frequencies
		end
	end
end
