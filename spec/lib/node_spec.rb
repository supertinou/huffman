require "spec_helper.rb"

module Huffman

	describe Node do 

		xit "can get a node and it will be inserted depending on the way we want to" do
			
			a = Node.new([1,"a"])
			b = Node.new([50,'b'])
			b = Node.new([50,'b'])

		end

		context "with a binary tree" do
			# We consider the tree example in the Readme
			# 	      1
			# 	   /     \
			# 	  2       3
			#    / \       \ 	
			# 	4	5	    6	
			# 	   / \     /
			# 	  7   8   9

			# Left part 
			n7 = Node.new(7)
			n8 = Node.new(8)
			n5 = Node.new(5,nil,n7,n8)
			n4 = Node.new(4)
			n2 = Node.new(2,nil,n4,n5)
			# Right part
			n9 = Node.new(9,nil)
			n6 = Node.new(6,nil,n9)
			n3 = Node.new(3,nil,nil,n6)
			# Tree
			tree = Node.new(1,nil,n2,n3)

			it "can be visited by the preorder algorithm" do 
				tree.visit_and_map(:preorder){|node| node.value}.should == [1, 2, 4, 5, 7, 8, 3, 6, 9] 
			end
			it "can be visited by the inorder algorithm" do
			 tree.visit_and_map(:inorder){|node| node.value}.should == [4, 2, 7, 5, 8, 1, 3, 9, 6] 
			end
			it "can be visited by the postorder algorithm" do
			 tree.visit_and_map(:postorder){|node| node.value}.should == [4, 7, 8, 5, 2, 9, 6, 3, 1] 
			end

		end
	end
	
end