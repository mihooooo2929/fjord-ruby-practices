require 'date'
require 'optparse'

options = ARGV.getopts('y:m:')

year = options["y"] ? options["y"].to_i : Time.now.year
month = options["m"] ? options["m"].to_i : Time.now.month
    
this_month_date = Date.new(year, month, -1).day
week = ["日", "月", "火", "水", "木", "金", "土"]
header = month.to_s + "月" + " " + year.to_s
first_day_weekday = Date.new(year, month, 1).wday

puts header.center(20) 
puts week.join(" ") 
print "   " * first_day_weekday

(1..this_month_date).each do |date|
  print date.to_s.rjust(2) + " "
  if (date + first_day_weekday) % 7 == 0
    print "\n"
  end
end
print "\n"
