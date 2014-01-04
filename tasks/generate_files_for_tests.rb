
desc "generate files for tests"
task :generate_files_for_tests do

	# Avec un nombre de symbols
	[125,175,210,255].each do |n|
		write_file_with_n_symbols(n)
	end
	# Avec une taille
	ko = 1_000 
	mo = 1_000 * ko

	[10 * ko, 25 * ko, 50 * ko,  80 * ko, 90 * ko,  110 * ko, 140 * ko].each do |n_octet|
		write_file_with_a_size_of(n_octet)
	end

end

private

def write_file_with_n_symbols(n)
	File.open("data/benchmark/symbols/#{n}-symbols.txt", 'wb' ) do |output|
		# On exclut 3 car c'est le EOT
		  output.write (0..n-1).map{|i| i.chr }.delete_if{|a| a == 3.chr}.join
	end
end

def write_file_with_a_size_of(n_octet)
	File.open("data/benchmark/size/#{n_octet}-octets.txt", 'wb' ) do |output|
		# On exclut 3 car c'est le EOT
		  characters = (32..126).to_a.pack('U*').chars.to_a
		  output.write (0..n_octet).map{characters.sample}.join
	end 
end

