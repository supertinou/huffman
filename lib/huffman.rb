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

		# On ajoute le marqueur EOT (enf of transmission 003)
		log.info "=== Début de l'encodage du texte"
		txt = txt + EOT
		log.info "=== Calcul des fréquences d'apparition des caractères du texte"
		frequencies = LetterFrequency.get_frequencies(txt)
		log.info "=== Creation de l'arbre de Huffman (Module 2)"
		tree = Tree.new(frequencies)
		log.info "=== Génération de l'image de l'arbre"
		tree.display_as_png(options[:tree_path]) if options[:tree_picture]
		log.info "=== Création du dictionnaire d'encodage"
		dictionnary = tree.dictionnary
		log.info "=== Encodage du texte en flot binaire"
		encoded_text = BinaryStream.get_bits_from_text(txt,dictionnary)
		log.info "=== Fin de l'encodage du texte"		 
		return encoded_text, dictionnary
	
	end

	def decode_text(encoded_text,dictionnary)
		log.info "=== Début du décodage du flux binaire de Huffman avec son dictionnaire (Module 3)"
		BinaryStream.get_text_from_bits(encoded_text,dictionnary)
	end

	def encode_file(file_path, options = {})
		log.info "= Début encodage du fichier #{file_path}"
		
		options[:tree_path] ||= file_path
		encoded_text, dictionnary = encode_text(File.read(file_path).encode('UTF-8', :invalid => :replace),options)	
		encoded_file_name =file_path+".huffman-encoded"
	
		
		log.info "== Ecriture du fichier binaire à partir du flux"
		File.open(encoded_file_name, 'wb' ){|f| f.write [encoded_text].pack("B*") }

		# Bits et caractère sont séparés par des tabulations
		dictionnary_stream = dictionnary.collect { |bin, char| bin+"\t"+char }.join('')

		log.info "== Ecriture du fichier dictionnaire de correspondance"
		dictionnary_file_name = file_path+".huffman-dictionnary"
		File.open(dictionnary_file_name, 'wb' ){|f| f.write dictionnary_stream }
		

		log.info "== Fin encodage du fichier"

		##### STATS #######
		original_size = File.size(file_path)
		dictionnary_size = File.size(dictionnary_file_name)
		encoded_size = File.size(encoded_file_name)
		
		begin
			ratio =  (encoded_size + dictionnary_size) / ( original_size / 100 )
		rescue ZeroDivisionError
			ratio = 0
		end

		log.info "== Taille originale : #{original_size} octets"
		log.info "== Taille du fichier binaire encodé : #{encoded_size} octets"
		log.info "== Taille du fichier dictionnnaire : #{dictionnary_size} octets"
		
		log.info "= Taux de compression = #{ratio} %"

		nil
	end

	def decode_file(file_path, dictionnary_file_path)
		log.info "= Decodage du fichier #{file_path}"
		dictionnary, bits_buffer, next_char_is_the_symbol = {}, '',false

		log.info "== Restauration du dictionnaire de correspondance"
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
		log.info "== Lecture du flux binaire"
		encoded_text = File.read(file_path).unpack("B*").join
		log.info "== Décodage des bits en texte"
		original_text = decode_text(encoded_text,dictionnary)
		log.info "== Ecriture du fichier original"
		File.open(file_path+"-back-to-original", 'wb' ){|f| f.write original_text }
		log.info "= Fin du décodage du fichier"
		nil
	end


end