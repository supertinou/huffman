
desc "generate files for tests"
task :generate_files_for_tests do

	[125,175,210,255].each do |n|
		write_file_with_n_symbols(n)
	end
end
private

def write_file_with_n_symbols(n)
	File.open("data/#{n}-symbols.txt", 'wb' ) do |output|
		  output.write (0..n-1).map{|i| i.chr }.join
	end
end

