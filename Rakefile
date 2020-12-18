require_relative './config/environment'
require_relative './instructions_data.rb'

require 'sinatra/activerecord/rake'
require 'colorize'

desc "Start our app console"
task :console do
  # enables logging in Pry console whenever ActiveRecord writes SQL for us
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  # open Pry console, similar to binding.pry
  Pry.start
end

namespace :remind_me_about do

  desc "🎁 process for adding a new table"
  task :adding_table do
    reminder_title("💧", "adding a table")
    iterate_over_steps($adding_table, "🌱")
  end

  desc "🎁 process for adding a column"
  task :adding_column do 
    reminder_title("🌬 ", "adding a column")
    iterate_over_steps($adding_column, "🌴")
  end

  desc "🎁 process for rolling back a column"
  task :rolling_back do 
    reminder_title("🍂 ", "rolling back")
    iterate_over_steps($rolling_back, "🍁")
  end

  desc "🎁 process for creating an instance"
  task :creating_an_instance do 
    reminder_title("🥚 ", "bringing new life")
    iterate_over_steps($creating_instance, "🐣")
  end 

  desc "🎁 process for reading instances"
  task :reading_instances do 
    reminder_title("📚 ", "reading the instances")
    iterate_over_steps($reading_instances, "🤓 ")
  end 

  desc "🎁 process for updating an instance"
  task :updating_an_instance do 
    reminder_title("🐛 ", "updating an instance")
    iterate_over_steps($updating_instance, "🦋 ")
  end 

  desc "🎁 process for updating all instances"
  task :updating_all_instances do 
    reminder_title("⚡️ ", "updating all instances")
    iterate_over_steps($updating_instances, "🔥 ")
  end 

  desc "🎁 process for deleting an instance"
  task :deleting_an_instance do 
    reminder_title("💀 ", "deleting an instance")
    iterate_over_steps($deleting_instance, "👻 ")
  end 

  desc "🎁 process for deleting all instances"
  task :deleting_all_instances do 
    reminder_title("👽 ", "deleting all instances")
    iterate_over_steps($deleting_instances, "🧟‍♀️ ")
  end 

end


def reminder_title(emoji, title)
  puts "\n\n #{four(emoji)} INSTRUCTIONS FOR #{title.upcase} #{four(emoji)} \n\n"
end

def four(emoji)
  "#{emoji} "*4
end

def iterate_over_steps(array_of_hashes, emoji)
  array_of_hashes.each_with_index do |hash, index|
    puts "#{four(emoji)}  STEP #{index}  #{four(emoji)} "
    puts hash[:name].colorize(:grey)
    code = hash[:code].empty? ? "no code!" : hash[:code].colorize(:green) 
    puts "code:".colorize(:red).underline + " " + code
    puts "#{four("🛑")} NOTE: #{hash[:note]}" if hash[:note] 
    puts "\n\n"
  end
end
