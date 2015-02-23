require 'simplecov'
SimpleCov.start

$:.unshift File.dirname(__FILE__)+'../lib'

require 'version_parser'
require 'log_file_finder'
require 'log_search'
require 'line_match'
require 'search_terms/keyword'
require 'search_terms/and'
require 'search_terms/or'
require 'search_terms/any'
