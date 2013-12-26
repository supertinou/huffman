require "logger"
	module Huffman
	extend self		
		class Log < Logger
		 private_class_method :new

		  @@logger = nil

		  def self.instance()
		    @@logger = new 'huffman.log' unless @@logger
		    @@logger
		  end
		end
		def log
			Log.instance
		end
end