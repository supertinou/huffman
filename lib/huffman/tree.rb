require 'graphviz'

module Huffman
	class Tree

		# Methodes délégués au noeud racine

		delegate :visit, :to => :@root
		delegate :visit_and_map, :to => :@root
		delegate :set_binary_values, :to => :@root

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
			set_binary_values
		end

		# On récupére la table de correspondance
		def dictionnary
			# '001' => A
			h = {}
			visit(:postorder){|node| h[node.binary_value] = node.symbol if node.symbol }
			h
		end


		def display_as_png(path="tree")
			# Create a new graph
			g = GraphViz.new(:G)
			visit(:postorder) do |node|
				# C'est un noeud parent inventé
				color = node.symbol ? "yellow" : "red"
				label = case node.symbol
					when EOT
						" EOT"
					when "\t"
						" TAB"
					when "\b"
						" BACKSPACE"
					when " "
						" WHITESPACE"
					when "\n"
						" LINE RETURN"		
					else 
						"#{node.symbol ? " " +node.symbol : ""}"
				end


				graphviz_node = g.add_nodes(node.__id__.to_s, label: "#{node.value}:#{node.binary_value}#{label}", "style" => "filled", "color" => color )
				# On créer les arretes de ses enfants
				g.add_edges(graphviz_node, g.get_node(node.left.__id__.to_s)) if node.left
				g.add_edges(graphviz_node, g.get_node(node.right.__id__.to_s)) if node.right

			end
			g.output( :png => "#{path}.png" )

		end
	end
end
