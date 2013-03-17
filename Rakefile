require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rake/clean'

GEM_NAME = 'uninclude'.freeze
DLEXT = RbConfig::CONFIG['DLEXT']

CLEAN.include("ext/**/*.{#{DLEXT},log,o}")
CLEAN.include('ext/**/Makefile')
CLEAN.include("lib/**/*.#{DLEXT}")
CLOBBER.include("lib/**/*.#{DLEXT}")

file "lib/#{GEM_NAME}/#{GEM_NAME}.#{DLEXT}" => Dir.glob("ext/#{GEM_NAME}/*.{rb, c}") do
  Dir.chdir("ext/#{GEM_NAME}") do
    ruby 'extconf.rb'
    sh 'make'
  end
  cp "ext/#{GEM_NAME}/#{GEM_NAME}.#{DLEXT}", "lib/#{GEM_NAME}/#{GEM_NAME}.#{DLEXT}"
end

RSpec::Core::RakeTask.new(:spec)
task :spec => "lib/#{GEM_NAME}/#{GEM_NAME}.#{DLEXT}"

task :default => :spec
