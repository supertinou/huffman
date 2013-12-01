require "spec_helper.rb"

describe "LetterFrequency" do 

	it "get the frequencies of the characters of a text" do

		# Create an array with random letters frequencies
		#
		# a : 1
		# b : 8
		# c : 9

		frequencies = ('a'..'z').collect{|c| [c,rand(100)]} 
		# Create the string from the frequencies
		txt = "" ; frequencies.each{|letter,freq| txt += letter*freq}
		# Test
		LetterFrequency.get_frequencies(txt).should == frequencies

	end

end