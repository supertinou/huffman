![Huffman](http://www.mathworks.com/matlabcentral/fx_files/33212/1/huffman.png)

[![Code Climate](https://codeclimate.com/repos/52c06ecae30ba036eb00347b/badges/adbbcd5f91fb73caf186/gpa.png)](https://codeclimate.com/repos/52c06ecae30ba036eb00347b/feed) [![Build Status](https://travis-ci.org/supertinou/huffman.png?branch=master)](https://travis-ci.org/supertinou/huffman) [![Gem Version](https://badge.fury.io/rb/huffman.png)](http://badge.fury.io/rb/huffman)

# The Huffman gem

This gem allow you to encode and decode a text using the Huffman encoding compression algorithm.
It can also generate and visualize the huffman tree as a png file.

## Setup

-Add this line to your application's Gemfile:

```ruby
gem 'huffman'
```

-And then execute:

    $ bundle

-Or install it yourself as:

    $ gem install huffman


-Install graphviz if you want to be able to visualize trees.

## Usage


Encode a text :

```ruby
Huffman.encode_text(txt) # return text_encoded, dictionnary
Huffman.encode_text(txt) # return text_encoded, dictionnary
```

    
Decode a text :
```ruby
Huffman.decode_text(encoded_txt, dictionnary) # return decoded_text
```

Encode a text file
```ruby
Huffman.encode_file(file_name) # write a file_name.huffman-encoded file and a file_name.huffman-dictionnary
Huffman.encode_file(file_name) # write a file_name.huffman-encoded file and a file_name.huffman-dictionnary
```

Decode a text file :
```ruby
Huffman.decode_file(huffman_encoded_file_path,huffman-dictionnary_path) # write a huffman-encoded-back-to-original file
```


## Generate a Huffman tree

![Huffman tree](http://img15.hostingpics.net/pics/575352tree.png)


This gem give you the ability to generate and visualize the huffman tree.
You have to install graphviz before.

All you need to do is to optionally add some options to the encode_file and decode_file method :


```ruby
Huffman.encode_text(txt, tree_picture: true, tree_path: "my_trees/the_tree")     # or
Huffman.encode_file(file_name, tree_picture: true, tree_path: "my_trees/the_tree") 
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
