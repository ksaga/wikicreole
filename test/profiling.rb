#!/usr/bin/env ruby

require 'rubygems'
require 'wiki_creole'
require 'ruby-prof'

wc = WikiCreole.new

result = RubyProf.profile do
  10.times do
    %w(amp block escape inline specialchars jsp_wiki).each do |name|
      markup = File.read("./test/test_#{name}.markup")
      parsed = wc.parse(markup, :top)
    end
  end
end

printer = RubyProf::GraphHtmlPrinter.new(result)
File.open("profiling.html", "w") do |file|
  printer.print(file)
end

