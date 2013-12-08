require 'graphviz'

module Huffman
	class Tree

		# Methodes délégués au noeud racine

		delegate :visit, :to => :@root
		delegate :visit_and_map, :to => :@root

		def initialize(frequencies)
			# Liste de noeuds feuilles toujours triés par ordre croissant qui vont nous permettre de créer l'arbre de Huffman
			nodes = frequencies.map{|freq| Node.new(freq[1], freq[0])}
			# Penser aux Priority Queue

			# Tant qu'il y'a pas plus qu'un seul noeud dans la liste

			until nodes.size == 1

				# 1) On créer un noeud dont ses fils sont les deux premiers noeuds du tableau triés de noeud et la valeur leur somme
				
				# On enlève les deux premiers noeuds
				node1, node2 = nodes.shift, nodes.shift
				# On créer un noeud parent
				parent = Node.new(node1.value+node2.value,nil,node1,node2)
				
				# 2) On ajoute le noeud à la liste 
				nodes << parent 
				# On trie la liste
				nodes = nodes.sort_by{|node| node.value}
			end
			
			@root = nodes.first
		end


		def display_as_png(path="tree")

			# Create a new graph
			g = GraphViz.new(:G)

			visit(:postorder) do |node|
				# C'est un noeud parent inventé
				color = node.symbol ? "yellow" : "red"
				label = node.symbol ? " #{node.symbol}" : ''

				graphviz_node = g.add_nodes(node.__id__.to_s, label: "#{node.value}#{label}", "style" => "filled", "color" => color )

				# On créer les arretes de ses enfants
				g.add_edges(graphviz_node, g.get_node(node.left.__id__.to_s)) if node.left
				g.add_edges(graphviz_node, g.get_node(node.right.__id__.to_s)) if node.right

			end

			# Create an edge between the two nodes
			# g.add_edges( hello, world )

			# Generate output image
			g.output( :png => "#{path}.png" )

		end
	end
end
