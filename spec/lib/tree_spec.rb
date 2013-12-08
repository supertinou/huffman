require "spec_helper.rb"

module Huffman
	describe Tree do 
		xit "build a tree from frequencies" do
			 txt = "ABBCCCDDDEEEEE"
			 # Fréquences : A1 B2 C3 D3 E5
			 frequencies = LetterFrequency.get_frequencies(txt)
			 tree = Tree.new(frequencies)
			# 	     14
			# 	   /    \
			# 	  6      8
			#    / \    / \ 	
			# 	3	3  3   5	
			# 	   / \     
			# 	  1   2   
			node3 = Node.new(3,nil,Node.new(1),Node.new(2))
			node6 = Node.new(6,nil,Node.new(3),node3) 
			node8 = Node.new(8,nil,Node.new(3),Node.new(5))
			expected_tree = Node.new(14,nil,node6,node8)

			tree.visit_and_map(:postorder){|node| node.value}.should == expected_tree.visit_and_map(:postorder){|node| node.value}
		
			# Important, en fait il est difficile et plus compliquer de comparer deux arbres binaires
			# dans le contexte d'un codage de Huffman
			# Car deux arbres peuvent êtres structurellement différents mais pareil pour le codage de Huffman
			# Cela dépend donc dans quel ordre a été triés les noeuds de même valeur
			# Celà influence sur la structure de l'arbre

		end
	end
end