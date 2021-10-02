#!/usr/bin/env ruby

require 'rugged'
require 'logger'

class Git
	attr_accessor :repository
	attr_accessor :branch
	attr_accessor :output_directory
	attr_accessor :logger

	def initialize(repository:nil, branch:nil, output_directory:nil, logger:nil)
		self.repository = repository
		self.branch = branch
		self.output_directory = output_directory
		# logger
		self.logger = Logger.new(STDOUT)
		self.logger.level = Logger::INFO

	end

	def clone()
		# return false if do not set constracotr
		self.output_directory ||= "clone_directory"
		if not (self.repository && self.branch)
			self.logger.error("does not set constractor")
			exit 1
		end
		# check output directory
		output_directory = File.join(Dir.pwd, self.output_directory)
		if File.directory?(output_directory)
			self.logger.error("#{output_directory}is exist !!")
			exit 1
		end
		# do it !!
		begin
			Rugged::Repository.clone_at(self.repository, output_directory, {
				checkout_branch:self.branch
			})
		rescue => e
			self.logger.error("git clone error")
			self.logger.error(e.class)
			self.logger.error(e.message)
			self.logger.error(e.backtrace)
			exit 1
		else
			self.logger.info("git clone success !!")
		end
		
	end
end

if $0 == __FILE__
	git = Git.new(repository:"https://github.com/nobukunisyota/ruby_script.git", branch:"main")
	git.clone()
end
