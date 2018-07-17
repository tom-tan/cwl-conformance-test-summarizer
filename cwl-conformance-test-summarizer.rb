#!/usr/bin/env ruby
# coding: utf-8
require 'optparse'
require 'json'
require 'rexml/document'

if $0 == __FILE__
  opt = OptionParser.new
  opt.banner = "Usage: #{$0} results.xml"
  opt.parse!(ARGV)

  unless ARGV.length == 1
    puts opt.help
    exit
  end

  file = ARGV.pop
  xml = REXML::Document.new(open(file))

  all = REXML::XPath.match(xml, '/testsuites/@tests').first.to_s.to_i
  errors = REXML::XPath.match(xml, '/testsuites/@errors').first.to_s.to_i
  failures = REXML::XPath.match(xml, '/testsuites/@failures').first.to_s.to_i
  success = all-errors-failures

  ratio = ((success/all.to_f)*100).round(1)

  required = REXML::XPath.match(xml, '//testcase').select{ |tc|
    REXML::XPath.match(tc, '@class').first.to_s.split(', ').include? 'required'
  }
  nrequired = required.length
  success_required = nil

  # color schemes are from shields/lib/colorscheme.json in https://github.com/badges/shields
  status = if success == all
             '97CA00' # green
           elsif success_required == nrequired
             'fe7d37' # orange
           else
             'e05d44' # red
           end
  result = {
    :success => success,
    :success_required => nil,
    :nall => all,
    :nrequired => nrequired,
    :ratio => ratio,
    :status => status,
  }
  puts JSON.dump(result)
end
