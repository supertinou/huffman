require 'ruby-progressbar'

module Huffman
	module BinaryStream
		extend self

		# binary stream to txt

		def get_bits_from_text(txt,dictionnary)
			progressbar = ProgressBar.create(:title => "Encodage du texte en flot binaire",  :total => txt.size, :format => '%t %p%% - %a |%b>>%i|')
			txt.each_char.map{|char| progressbar.increment ; dictionnary.invert[char]}.join
		end

		def get_text_from_bits(bits,dictionnary)
			original_text = ''
			buffer = ''
			progressbar = ProgressBar.create(:title => "Encodage du flot binaire en texte",  :total => bits.size, :format => '%t %p%% - %a |%b>>%i|')
			bits.each_char do |byte| 
				progressbar.increment
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
	end
end