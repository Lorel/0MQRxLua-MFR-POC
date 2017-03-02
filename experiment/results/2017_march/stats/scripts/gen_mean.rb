#!/usr/bin/ruby

# Generates mean from any column of a text file. (c) 2009 Etienne Riviere, NTNU Trondheim. etriviere@gmail.com
#
# Changelog:
# 15/01/2009 -- first version
# 16/01/2009 -- ignore comments and white lines

# todo:
# - add an option for the scale effect (i.e. CDF not smoothed, but stairs-looking)
# - add the possibility to specify operations on the columns (arithmetic) instead of a single one

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = 
  "Usage: gen_mean.rb "+
  "[-f/--file inputfile] "+
  "[-c/--col=I] "+
  "[-o/--remove-outliers=I] "+
  "[-h/--help]"

  opts.on("-h", "--help", "Get some help") do
    puts opts.banner
    exit()
  end
  opts.on("-f inputfile", "--file filename", "Inputfile") do |f|
    options[:inputfile] = f
  end
  opts.on("-c integer", "--col integer", "Column to use") do |c|
    options[:column] = c.to_i-1
  end
  opts.on("-o", "--remove-outliers integer", "Remove the X extreme samples (min and max)") do |c|
    options[:remove_outliers] = c.to_i
  end
end.parse!

# check the arguments and apply defaults
if options[:inputfile] and !File.exists?(options[:inputfile])
  puts "File #{options[:inputfile]} does not exist"
  exit()
end
if !options[:column]
  options[:column]=0 # first column is the default
end

$elements=Array.new
def process_elem(line, col)
  num=line.split(' ')[col].to_f
  $elements << num
end

if options[:inputfile]
  File.open(options[:inputfile]).each do |line|
    if !(line =~ /(^[[:space:]]*#|^[[:space:]]*$)/)
      process_elem(line,options[:column])
    end
  end
else
  STDIN.readlines.each do |line|
    if !(line =~ /(^[[:space:]]*#|^[[:space:]]*$)/)
      process_elem(line,options[:column])
    end
  end
end

# remove outliers
if options[:remove_outliers]
  # make sure we have at least 2x options[:remove_outliers] + 1 samples...
  $elements.sort!
  # remove the outliers
  1.upto(options[:remove_outliers]) do 
    # remove only if there are still enough samples ...
    if ($elements.size-2 >= 1)
      $elements.delete_at(0)
      $elements.delete_at($elements.size-1)
    end
  end
end

total=0
$elements.each do |elem|
  total = total + elem
end
mean=0
if ($elements.size > 0)
  mean = total / $elements.size
end

puts("#{mean}")

