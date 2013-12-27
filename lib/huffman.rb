# encoding: utf-8
require 'active_support/all'
require "huffman/version"
require "huffman/letter_frequency"
require "huffman/node"
require "huffman/tree"
require "huffman/log"

module Huffman
	EOT = 3.chr

	extend self

	def encode_text(txt)
		# On ajoute le marqueur EOT (enf of transmission 003)
		txt = txt + EOT
		log.info "Encodage du texte"
		frequencies = LetterFrequency.get_frequencies(txt)
		log.info "Creation de l'arbre de Huffman"
		tree = Tree.new(frequencies)
		log.info "Génération de l'image de l'arbre"
		tree.display_as_png()
		dictionnary = tree.dictionnary
		encoded_text = txt.each_char.map{|char| dictionnary.invert[char]}.join		 
		return encoded_text, dictionnary
	end

	def decode_text(encoded_text,dictionnary)
		log.info "Decodage du fichier"
		original_text = ''
		buffer = ''
		encoded_text.each_char do |byte| 
			buffer += byte
			# Si il y'a une correspondance
			if dictionnary[buffer] 
				 # Si c'est le marqueur de fin EOF 
			     return original_text if dictionnary[buffer] == EOT
			    
				 original_text += dictionnary[buffer] 
				 buffer.clear
			end
		end
		original_text
	end

	def encode_file(file_path)
		log.info "Encodage du fichier #{file_path}"
		log.info "Taille originale : #{File.size(file_path)} octets"
		
		encoded_text, dictionnary = encode_text(File.read(file_path).encode('UTF-8', :invalid => :replace))	
		encoded_file_name =file_path+".huffman-encoded"
		
		log.info "Taille du fichier encodé : #{File.size(encoded_file_name)} octets"
		
		File.open(encoded_file_name, 'wb' ) do |output|
		  output.write [encoded_text].pack("B*")
		end
		# Fichiers séparés par des tabulation
		dictionnary_stream = dictionnary.collect { |bin, char| bin+"\t"+char }.join('')
		File.open(file_path+".huffman-dictionnary", 'wb' ) do |output|
		  output.write dictionnary_stream
		end
		nil
	end

	def decode_file(file_path, dictionnary_file_path)
		log.info "Decodage du fichier #{file_path}"
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
		encoded_text = File.read(file_path).unpack("B*").join
		original_text = decode_text(encoded_text,dictionnary)
		File.open(file_path+"-back-to-original", 'wb' ) do |output|
		  output.write original_text
		end
		log.info "Fin du décodage du fichier"
		nil
	end


end
