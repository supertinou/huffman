require "spec_helper.rb"

module Huffman
	describe "HuffmanCoder" do 
		it "decode an encoded string and get back the original string" do
			 txt = "La vie est un long fleuve tranquille avec des impasses, des courants de mer"	
	  		 encoded_text, dictionnary = Huffman.encode_text(txt)
	  		 new_txt = Huffman.decode_text(encoded_text,dictionnary)
	  		 new_txt.should == txt
		end

		it "decode an encoded file and get back the original file" do
			
			#file_name = "data/test.txt"
			file_name = "data/test.txt" 
			original_content = File.read(file_name)
			Huffman.encode_file(file_name)
			Huffman.decode_file(file_name+".huffman-encoded",file_name+".huffman-dictionnary")
			original_content_after_decoding = File.read(file_name+".huffman-encoded-back-to-original")
			original_content.should == original_content_after_decoding		 
		end
	end	
end