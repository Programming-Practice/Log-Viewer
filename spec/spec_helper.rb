require 'simplecov'

SimpleCov.start

require 'version_parser'

$:.unshift File.dirname(__FILE__)+'../lib'

require 'log_search'
require 'insensitive_log_search'
require 'line_match'
