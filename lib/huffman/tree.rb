module Huffman
	class Tree
		def initialize
		end

	    def build(frequencies)
			# Liste de noeuds feuilles toujours triés par ordre croissant qui vont nous permettre de créer l'arbre de Huffman
			nodes = frequencies.map{|freq| Node.new(freq[1], freq[0])}
			# Penser aux Priority Queue

			# Tant qu'il y'a pas plus qu'un seul noeud dans la liste
			while nodes.size > 1

				# 1) On créer un noeud dont ses fils sont les deux premiers noeuds du tableau triés de noeud et la valeur leur somme
				
				# On enlève les deux premiers noeuds
				node1, node2 = nodes.shift, nodes.shift
				# On créer un noeud parent
				parent = Node.new(node1.value+node2.value,nil,node1,node2)
				
				# 2) On ajoute se noeud à la liste triée
				nodes << parent 
				nodes = nodes.sort_by{|node| node.value}
			end
			
			nodes.first
		end
	end
end
