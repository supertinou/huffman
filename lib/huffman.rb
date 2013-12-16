require 'active_support/all'
require "huffman/version"
require "huffman/letter_frequency"
require "huffman/node"
require "huffman/tree"

module Huffman
	extend self

	def encode_text(txt)
		frequencies = LetterFrequency.get_frequencies(txt)
		tree = Tree.new(frequencies)
		tree.display_as_png()
		dictionnary = tree.dictionnary
		encoded_text = txt.each_char.map{|char| dictionnary.invert[char]}.join		 
		return encoded_text, dictionnary
	end

	def decode_text(encoded_text,dictionnary)
		original_text = ''
		buffer = ''
		encoded_text.each_char do |byte| 
			buffer += byte
			# Si il y'a une correspondance
			if dictionnary[buffer] 
				 original_text += dictionnary[buffer] 
				 buffer.clear
			end
		end
		original_text
	end


end
