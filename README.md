![Arbre binaire](http://www.mathworks.com/matlabcentral/fx_files/33212/1/huffman.png)

[![Code Climate](https://codeclimate.com/repos/52c06ecae30ba036eb00347b/badges/adbbcd5f91fb73caf186/gpa.png)](https://codeclimate.com/repos/52c06ecae30ba036eb00347b/feed)[![Build Status](https://travis-ci.org/lagrangemartin/huffman.png?branch=master)](https://travis-ci.org/lagrangemartin/huffman)

# La gem Huffman

Cette gem permet de compresser et décompresser du texte en utilisant l'encodage de Huffman.
Elle a aussi un but pédagogique car elle permet de visualiser l'arbre de Huffman généré.

## Installation

Ajoutez cette ligne à votre Gemfile :

```ruby
gem 'huffman'
```

Et executez :

    $ bundle

Ou installez la indépendamment :

    $ gem install huffman

## Utilisation


Encoder un texte :

```ruby
Huffman.encode_text(txt) # return text_encoded, dictionnary
Huffman.encode_text(txt,{tree_picture: true, tree_path: "my_tree"}) # return text_encoded, dictionnary and build a png tree picture
```

    
Décoder un texte :
```ruby
Huffman.decode_text(txt_encoded, dictionnary) # return text_decoded
```

Encoder un fichier texte :
```ruby
Huffman.encode_file(file_name) # write a file_name.huffman-encoded file and a file_name.huffman-dictionnary
Huffman.encode_file(file_name,{tree_picture: true, tree_path: "my_tree"}) # write a file_name.huffman-encoded file and a file_name.huffman-dictionnary and generate a png tree picture
```

Décoder un fichier texte :
```ruby
Huffman.decode_file(huffman_encoded_file,huffman-dictionnary) # write a huffman-encoded-back-to-original file
```

## Specifications

Executez cette commande pour consulter les spécifications

    $ rake


## Génération de l'arbre de Huffman

La gem permet de générer la visualisation de l'arbre de Huffman.
Pour celà, vous devez installer graphviz 



## Contribuer à cette gem

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
