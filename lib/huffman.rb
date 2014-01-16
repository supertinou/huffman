# encoding: utf-8
require 'active_support/all'
require "huffman/version"
require "huffman/letter_frequency"
require "huffman/binary_stream"
require "huffman/node"
require "huffman/tree"
require "huffman/log"


module Huffman
	# Caractère fin de transmission
	EOT = 3.chr

	extend self

	def encode_text(txt, options={})
		
		options[:tree_picture] ||= false
		options[:tree_path] ||= "tree"

		frequencies = LetterFrequency.get_frequencies(txt)
		tree = Tree.new(frequencies)
		dictionnary = tree.dictionnary
		tree.display_as_png(options[:tree_path]) if options[:tree_picture]
		encoded_text = BinaryStream.get_bits_from_text(txt,dictionnary)	 
		return encoded_text, dictionnary
	
	end

	def decode_text(encoded_text,dictionnary)
		BinaryStream.get_text_from_bits(encoded_text,dictionnary)
	end

	def encode_file(file_path, options = {})
		
		options[:tree_path] ||= file_path
		txt = File.read(file_path).encode('UTF-8', :invalid => :replace)
		txt = txt + EOT # On ajoute le marqueur EOT (enf of transmission 003)
		encoded_text, dictionnary = encode_text(txt,options)	
		encoded_file_name =file_path+".huffman-encoded"
	
		
		File.open(encoded_file_name, 'wb' ){|f| f.write [encoded_text].pack("B*") }

		dictionnary_stream = dictionnary.collect { |bin, char| bin+"\t"+char }.join('')

		dictionnary_file_name = file_path+".huffman-dictionnary"
		File.open(dictionnary_file_name, 'wb' ){|f| f.write dictionnary_stream }
		
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

		encoded_text = File.read(file_path).unpack("B*").join
		original_text = decode_text(encoded_text,dictionnary)
		File.open(file_path+"-back-to-original", 'wb' ){|f| f.write original_text }
		nil
	end





end