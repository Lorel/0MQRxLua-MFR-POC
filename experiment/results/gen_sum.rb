#!/usr/bin/ruby

# Generates CDF from any column of a text file. (c) 2009 Etienne Riviere, NTNU Trondheim. etriviere@gmail.com
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
    "Usage: gen_cdf.rb "+
    "[-f/--file inputfile] "+
    "[-c/--col=I] "+
    "[-o/--remove-outliers=I] "+
    "[-d/--div=F] "+
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
  opts.on("-d divider", "--divider float", "Optional divider") do |d|
    options[:divider] = d.to_f
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
if !options[:divider]
  options[:divider]=1.0 # no divider by default
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
removed=0.0
if options[:remove_outliers]
  # make sure we have at least 2x options[:remove_outliers] + 1 samples...
  $elements.sort!
  # remove the outliers
  1.upto(options[:remove_outliers]) do 
    # remove only if there are still enough samples ...
    if ($elements.size-2 >= 1)
      $elements.delete_at(0)
      $elements.delete_at($elements.size-1)
      removed=removed+2
    end
  end
end

#STDERR.puts "$elements.size = #{$elements.size}, removed #{removed}, divider=#{options[:divider]}"
# if we removed outliers, we must divide according to the real number of
# samples (proportionaly)
if options[:remove_outliers]
  options[:divider] = options[:divider] * ($elements.size / ($elements.size + removed))
end
#STDERR.puts "new divider=#{options[:divider]}"

total=0
$elements.each do |elem|
  total = total + elem
end

puts("#{total/options[:divider]}")
