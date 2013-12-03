#require 'active_support/all'
require "huffman/version"
require "huffman/letter_frequency"

module Huffman
	extend self

	def encode_text(txt)
		frequencies = LetterFrequency.get_frequencies(txt)
	end

	def decode_text(txt)
		
	end


end
