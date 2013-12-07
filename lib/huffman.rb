#require 'active_support/all'
require "huffman/version"
require "huffman/letter_frequency"
require "huffman/node"
require "huffman/tree"

module Huffman
	extend self

	def encode_text(txt)

		frequencies = LetterFrequency.get_frequencies(txt)
		tree = Tree.new.build(frequencies)		 
	end

	def decode_text(txt)
		
	end


end
