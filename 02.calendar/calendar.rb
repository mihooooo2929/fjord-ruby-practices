require 'date'
require 'optparse'

options = ARGV.getopts('y:m:')
puts options
puts options["y"]
puts options["m"]

if options["y"] && options["m"]
  year =  options["y"].to_i
  month = options["m"].to_i
elsif options["m"]
  year = Time.now.year
  month = options["m"].to_i
else
  year = Time.now.year
  month = Time.now.month
end

this_month_date = Date.new(year, month, -1).day
week = ["日", "月", "火", "水", "木", "金", "土"]
header = month.to_s + "月" + " " + year.to_s
first_day_weekday = Date.new(year, month, 1).wday

puts header.center(20) 
puts week.join(" ") 
print "   " * first_day_weekday

i = 1
while i <= this_month_date
  print i.to_s.rjust(2) + " "
  i += 1
  if (i + first_day_weekday -1) % 7 == 0
    print "\n"
  end
end
print "\n"
