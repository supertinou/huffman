![Arbre binaire](http://www.mathworks.com/matlabcentral/fx_files/33212/1/huffman.png)


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
Huffman.encode_text(txt) # text_encoded, dictionnary
```

    
Décoder un texte :
```ruby
Huffman.decode_text(txt_encoded, dictionnary) # text_decoded
```

## Les différents parcours d'un arbre binaire 

![Arbre binaire](http://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Arbre_binaire_ordonne.svg/408px-Arbre_binaire_ordonne.svg.png)




<table>
  <tr>
    <th>Parcours</th>
    <th>Implémentation</th>
    <th>Résultat</th>
  </tr>
  <tr>
    <td>Préfixe (Preorder) </td>
    <td>
        lire noeud <br />
        visiter gauche <br />
        visiter droite
    </td>
    <td>1, 2, 4, 5, 7, 8, 3, 6, 9</td>
  </tr>
  <tr>
    <td>Infixe (Inorder) </td>
    <td>
        visiter gauche <br />
        lire noeud <br />
        visiter droite
    </td>
    <td>4, 2, 7, 5, 8, 1, 3, 9, 6</td>
  </tr>
    <tr>
    <td>Postfixe (Postorder) </td>
    <td>
        
        visiter gauche <br />
        visiter droite <br />
        lire noeud 
    </td>
    <td>4, 7, 8, 5, 2, 9, 6, 3, 1</td>
  </tr>
</table>


## Contribuer à cette gem

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
