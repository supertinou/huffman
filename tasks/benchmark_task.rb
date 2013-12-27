require "huffman"
require "method_profiler"

desc "Benchmark the huffman methods"
task :benchmark do
  profiler_huffman = MethodProfiler.observe(Huffman)
  profiler_letter_frequency = MethodProfiler.observe(Huffman::LetterFrequency)
  profiler_tree = MethodProfiler.observe(Huffman::Tree)
  profiler_node = MethodProfiler.observe(Huffman::Node)

  file_name = "data/Les_miserables_Tome_I_Chapitre_1-5.txt" 
  Huffman.encode_file(file_name)
  Huffman.decode_file(file_name+".huffman-encoded",file_name+".huffman-dictionnary")
  

  puts profiler_huffman.report
  puts profiler_letter_frequency.report
  puts profiler_tree.report
  puts profiler_node.report
 
end