module Huffman
	module BinaryStream
		extend self

		def get_bits_from_text(txt,dictionnary)
			dictionnary = dictionnary.invert
			txt.each_char.map{|char|  ; dictionnary[char]}.join
		end

		def get_text_from_bits(bits,dictionnary)
			original_text = '' ; buffer = ''
			bits.each_char do |bit| 
				buffer += bit
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
	end
end