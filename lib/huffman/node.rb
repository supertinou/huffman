module Huffman
	class Node
	    attr_accessor :value, :symbol, :left, :right
	    # Set the getters and setters

	    def initialize(value=nil, symbol=nil, left=nil, right=nil)
	    	# The value of the node can't be nil
	    	raise StandardError.new "The value of the node cannot be nil" if not value
	        @value, @symbol, @left, @right = value, symbol, left, right
	    end


	    # Le parametre &block signifie qu'on peut passer en paramètre de la fonction un bloc de codes
	    # Soit en créeant un objet Proc.new avec du code, ou soit un lambda et en le passant en parametre => visit(:order)
	    # Ou encore directement un bloc comme : visit{|node| puts node.value}
	    # Ce bloc vas servir de visiteur et va permettre d'effectuer une action sur le bloc visité avec le mot clé "yield"

	    def visit(order=:preorder, &block)

	    	raise StandardError.new "Wrong order" if not [:preorder,:inorder,:postorder].include?(order)
	    	case order
	    		when :preorder 
            		yield self
            		@left.visit(order, &block) if left
            		@right.visit(order, &block) if right
        		when :inorder
        			@left.visit(order, &block) if left
        			yield self
            		@right.visit(order, &block) if right
        		when :postorder
            		@left.visit(order, &block) if left
            		@right.visit(order, &block) if right
            		yield self
            end
	    end

	    # Invokes the given block once for each node visited
        # Creates a new array containing the values returned by the block.

	    def visit_and_map(order=:preorder, &block)
	    	array = []
	    	visit(order){|node| array << yield(node)}
	    	array
	    end

	    def leaf?
	    	(not @left and not @right)
	    end
	end
end
