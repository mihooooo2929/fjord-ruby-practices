arg = ARGV[0]
  items = Dir.glob("*")
  window_length = (`tput cols`).to_i 
  max_item_string_length = 0 
  items.each do |item|
    if max_item_string_length <= item.to_s.length
      max_item_string_length = item.to_s.length
    end
  end
  number_of_columns = window_length / (max_item_string_length + 1)
  

  i = items.length % number_of_columns
  puts i
  while i != 0
    items.push("")
    i = items.length % number_of_columns
  end

  puts i
  puts items.length.to_s + ":itemsの配列の要素数" 

  number_of_rows = (items.length / number_of_columns.to_i).to_i
  transposed_items = items.each_slice(number_of_rows).to_a.transpose
  puts max_item_string_length.to_s + ":一番長い名前の文字数"
  puts window_length.to_s + ":ウィンドウの幅の文字数"
  puts number_of_rows.to_s + ":行の数"
  puts transposed_items.length.to_s + ":transpose後の配列の数" 
  puts number_of_columns.to_s + ":カラムの数"
  number_of_t_items = transposed_items.length
  this_item_ary_position_first_arg = 0
  ary = []
  while this_item_ary_position_first_arg < transposed_items.length do
    this_item_ary_position_second_arg = 0
    while this_item_ary_position_second_arg < number_of_columns do
        print transposed_items[this_item_ary_position_first_arg][this_item_ary_position_second_arg].ljust(max_item_string_length.to_i + 1," ")
        ary << transposed_items[this_item_ary_position_first_arg][this_item_ary_position_second_arg]
        this_item_ary_position_second_arg += 1
    end
    this_item_ary_position_first_arg += 1
    ary.each_with_index do |a, i|
        if i % (number_of_columns * this_item_ary_position_first_arg) == 0
            print "\n"
        end
    end
  end
case arg
  when "-a"
  when "-l"
  when "-r"
end
print "\n"
