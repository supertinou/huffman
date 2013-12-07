module Huffman
	class Node
	    attr_accessor :value, :symbol, :left, :right
	    # Set the getters and setters

	    def initialize(value=nil, symbol=nil, left=nil, right=nil)
	    	# The value of the node can't be nil
	    	raise error if not value
	        @value, @symbol, @left, @right = value, symbol, left, right
	    end



	    def leaf?
	    	(not @left and not @right)
	    end
	end
end
