require 'simplecov'
SimpleCov.start

$:.unshift File.dirname(__FILE__)+'../lib'

require 'version_parser'
require 'log_file_finder'
require 'log_search'
require 'insensitive_log_search'
require 'line_match'
require 'result_saver'