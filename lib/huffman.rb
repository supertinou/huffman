# encoding: utf-8
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

	def encode_file(file_path)
		encoded_text, dictionnary = encode_text(File.read(file_path).encode('UTF-8', :invalid => :replace))
		File.open(file_path+".huffman-encoded", 'wb' ) do |output|
		  output.write [encoded_text].pack("A*")
		end
		# Fichiers séparés par des tabulation
		dictionnary_stream = dictionnary.collect { |bin, char| bin+"\t"+char }.join('')
		File.open(file_path+".huffman-dictionnary", 'wb' ) do |output|
		  output.write dictionnary_stream
		end
		nil
	end

	def decode_file(file_path, dictionnary_file_path)
		dictionnary, bits_buffer, next_char_is_the_symbol = {}, '',false

		File.read(dictionnary_file_path).each_char do |c|
			if c == "\t" 
				next_char_is_the_symbol = true
			elsif next_char_is_the_symbol
				dictionnary[bits_buffer] = c
				bits_buffer.clear
				next_char_is_the_symbol = false
			else
				bits_buffer += c
			end
		end


		#encoded_text = IO.read(file_path).bytes.collect{|b| b.to_s(2)}.join
		encoded_text = File.read(file_path).unpack("A*").join
		original_text = decode_text(encoded_text,dictionnary)
		File.open(file_path+"-back-to-original", 'wb' ) do |output|
		  output.write original_text
		end
		nil
	end


end
