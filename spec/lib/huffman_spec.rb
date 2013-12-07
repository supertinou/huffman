require "spec_helper.rb"

describe "HuffmanCoder" do 
	it "decode an encoded string and get back the original string" do
		 txt = "La vie est un long fleuve tranquille avec des impasses, des courants de mer"	
  		 encoded_text, dictionnary = Huffman.encode_text(txt)
  		 new_text = Huffman.decode_text(encoded_text,dictionnary)
  		 new_txt.should == txt
	end
end