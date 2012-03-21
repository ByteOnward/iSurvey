#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require File.expand_path('../config/environment', __FILE__)
ISurvey::Application.load_tasks

require 'rubygems'
require 'ci/reporter/rake/rspec'     # use this if you're using RSpec
require 'ci/reporter/rake/cucumber'  # use this if you're using Cucumber
require 'ci/reporter/rake/test_unit' # use this if you're using Test::Unit


namespace :dbinit do
  task :ews do
    names = %w{
      v-anzhang
      v-brohuang
      v-cahe
      v-cyyang
      v-lianchen
      v-dguilai
      v-fdong
      v-keli
      v-ptan
      v-rlei
      v-yaxwang
      v-yongyang
      v-mwen
      v-vsong
      v-zhwang

      v-dawang
      v-hfu
      v-janyzhang
      v-tizhan
      v-liwu
      v-mzhang
      v-nqiu
      v-xiazhang
      v-zhihwang
      v-serhu
      v-swei
      v-xjia
    }
    role = Role.where(:name => "EWS").first
    names.each do |name|
      email = name + "@expedia.com"
      user = User.where(:email => email).first
      if !user
        user = User.new({email: email, password: "expedia"})
        user.save!
      end 
      role.users << user     
    end
  end
end
