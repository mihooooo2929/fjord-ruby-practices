require 'date'

year = Date.today.year.to_s
month = Date.today.month.to_s
this_month_date = Date.new(Time.now.year, Time.now.month, -1).day
week = ["日", "月", "火", "水", "木", "金", "土"]
header = month + "月" + " " + year 
first_day_weekday = Date.new(Time.now.year, Time.now.month, 1).wday

puts first_day_weekday
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
