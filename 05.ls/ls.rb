require 'optparse'

options = ARGV.getopts('alr')
puts "\n"
puts options

set_max_column = 3
items = Dir.glob("*")
window_length = (`tput cols`).to_i 
max_item_string_length = 0 
items.each do |item|
    if max_item_string_length <= item.to_s.length
        max_item_string_length = item.to_s.length
    end
end
number_of_columns = window_length / (max_item_string_length + 1)
number_of_columns = set_max_column if number_of_columns > set_max_column

i = items.length % number_of_columns
while i != 0
    items.push("")
    i = items.length % number_of_columns
end

number_of_rows = (items.length / number_of_columns.to_i).to_i
transposed_items = items.each_slice(number_of_rows).to_a.transpose
puts i.to_s + ":itemの配列要素数/カラム数"
puts items.length.to_s + ":itemsの配列の要素数" 
puts max_item_string_length.to_s + ":一番長い名前の文字数"
puts window_length.to_s + ":ウィンドウの幅の文字数"
puts number_of_rows.to_s + ":行の数"
puts transposed_items.length.to_s + ":transpose後の配列の数" 
puts number_of_columns.to_s + ":カラムの数"
puts "\n"
number_of_t_items = transposed_items.length
this_item_x = 0
ary = []
while this_item_x < transposed_items.length do
    this_item_y = 0
    while this_item_y < number_of_columns do
        print transposed_items[this_item_x][this_item_y].ljust(max_item_string_length.to_i + 1," ")
        ary << transposed_items[this_item_x][this_item_y]
        this_item_y += 1
    end
    this_item_x += 1
    ary.each_with_index do |a, i|
        if i % (number_of_columns * this_item_x) == 0
            print "\n"
        end
    end
end
case options
  when options["a"] == true
  when options["l"] == true
  when options["r"] == true
end
print "\n"
