require "logger"
	module Huffman
	extend self		
		class Log < Logger
		 private_class_method :new

		  @@logger = nil

		  def self.instance()
		    @@logger = new 'huffman.log' unless @@logger
		    @@logger.datetime_format = "%d/%m %H:%M:%S:%6N"
		    @@logger.formatter = proc do |severity, datetime, progname, msg|
				  "#{datetime.strftime(@@logger.datetime_format)}: #{msg}\n"
				end
		    @@logger
		  end
		end
		def log
			Log.instance
		end
end