module Huffman
	module LetterFrequency
		extend self

		def get_frequencies(txt)
			frequencies = {}
			txt.each_char{|char| frequencies[char] = frequencies.has_key?(char) ? frequencies[char] + 1 : 1 }
			frequencies
		end
	end
end