# encoding: UTF-8

require 'bundler'
require 'digest'

require 'rspec/core/rake_task'
require 'rubygems/package_task'

require './lib/rtl_string'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end
