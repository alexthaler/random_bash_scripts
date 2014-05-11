#!/usr/bin/env ruby
require 'date'
require 'digest'

dateFormat = "%d%m%Y%H%M%S"

if ENV["BACKUP_PASSWORD"].nil?
    puts "PASSWORD NOT FOUND IN ENV, exiting."
    exit
else
    envPassword = ENV["BACKUP_PASSWORD"]
end

if ARGV[0].nil?
    d = DateTime.now
else
    d = DateTime.strptime(ARGV[0], dateFormat)
end

dateString = d.strftime(dateFormat)

shadPass = Digest::SHA512.hexdigest envPassword
combinedHash = Digest::SHA512.hexdigest "${shadPass}#{dateString}"

puts combinedHash