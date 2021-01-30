#!/usr/bin/ruby

arg_one = ARGV[0]
raise 'Need argument' unless arg_one
name = arg_one.downcase
camelcase = name.split('_').collect(&:capitalize).join

def mkdirifnone_exists(name)
  Dir.mkdir(name) unless File.exists?(name)
end

mkdirifnone_exists "lib"
mkdirifnone_exists "spec"

File.open("lib/#{name}.rb", "w") do |f|
  f.write("class #{camelcase}\nend\n")
end

File.open("spec/#{name}_spec.rb", "w") do |f|
  f.write("require 'rspec'\n")
  f.write("require 'byebug'\n")
  f.write("require './lib/#{name}.rb'\n\n")
  f.write("describe #{camelcase} do\nend\n")
end

system('rspec')
