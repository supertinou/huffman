module Huffman
	module LetterFrequency
		extend self

		def get_frequencies(txt)
			frequencies = Hash.new(0)
			txt.each_char{|char| frequencies[char] += 1 }
			frequencies
		end
	end
end
