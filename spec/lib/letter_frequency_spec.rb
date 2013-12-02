require "spec_helper.rb"

describe "LetterFrequency" do 

	it "get the frequencies of the characters of a text" do

		# Create an hash (associative array) with random letters frequencies
		#
		# a => 1
		# b => 8
		# c => 9

		frequencies = {} 
		('a'..'z').each{|c| frequencies[c] = rand(1..100) }
		# Create a string from the frequencies hash
		txt = frequencies.map{|letter,freq| letter*freq}.join.split('').shuffle.join
		# Test
		Huffman::LetterFrequency.get_frequencies(txt).should == frequencies

	end

end