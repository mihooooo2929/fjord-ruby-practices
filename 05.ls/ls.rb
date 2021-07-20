# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('alr')
puts "\n"
puts options

set_max_column = 3

items = if options['a'] == true && options['l'] == true && options['r'] == true
    Dir::entries('.').sort.reverse
elsif options['a'] == true && options['l'] == true && options['r'] == false
    Dir::entries('.').sort
elsif options['a'] == true && options['r'] == true && options['l'] == false
    Dir::entries('.').sort.reverse
elsif options['l'] == true && options['r'] == true && options['a'] == false
    Dir.glob('*').sort.reverse
elsif options['a'] == true && options['l'] == false && options['r'] == false
    Dir::entries('.').sort
elsif options['l'] == true && options['a'] == false && options['r'] == false
    Dir.glob('*').sort
elsif options['r'] == true && options['a'] == false && options['l'] == false
    Dir.glob('*').sort.reverse
else
    items = Dir.glob('*')
end


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
while i != 0 && options['l'] != true
    items.push('')
    i = items.length % number_of_columns
end

if options['l'] != true
    number_of_rows = (items.length / number_of_columns.to_i).to_i
    transposed_items = items.each_slice(number_of_rows).to_a.transpose
    puts i.to_s + ':itemの配列要素数/カラム数'
    puts items.length.to_s + ':itemsの配列の要素数' 
    puts max_item_string_length.to_s + ':一番長い名前の文字数'
    puts window_length.to_s + ':ウィンドウの幅の文字数'
    puts number_of_rows.to_s + ':行の数'
    puts transposed_items.length.to_s + ':transpose後の配列の数' 
    puts number_of_columns.to_s + ':カラムの数'
    puts "\n"
    number_of_t_items = transposed_items.length
    this_item_x = 0
    ary = []
    while this_item_x < transposed_items.length do
        this_item_y = 0
        while this_item_y < number_of_columns do
            print transposed_items[this_item_x][this_item_y].ljust(max_item_string_length.to_i + 1,' ')
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
end


if options['l'] == true
    items.each do |item|
        file_path = File.absolute_path(item.to_s)
        file_stat = File.stat(file_path)
        file_mode_2octal = file_stat.mode.to_s(2).rjust(8,'0')
        file_mode_2octal_permission = (file_mode_2octal.to_i / 1) % 1000000000
        permission_number_ary = file_mode_2octal_permission.to_s.split('')
        file_type = file_stat.ftype
        if file_type == 'directory'
            file_type = 'd'
        elsif file_type == 'file'
            file_type = '-'
        elsif file_type == 'link'
            file_type - 'l'
        end
        file_size = file_stat.size
        file_time_mtime = file_stat.mtime
        file_time_mtime_m = file_time_mtime.month
        file_time_mtime_d = file_time_mtime.day
        file_time_mtime_hour = file_time_mtime.hour
        file_time_mtime_min = file_time_mtime.min
        file_link = file_stat.nlink 
        permission_number_ary.each_with_index do |n, i|
            if n == '1' && i == 0
                n = 'r'
            elsif n == '1' && i == 3
                n = 'r'
            elsif n == '1' && i == 6
                n = 'r'
            elsif n == '1' && i == 1
                n = 'w'
            elsif n == '1' && i == 4
                n = 'w'
            elsif n == '1' && i == 7
                n = 'w'
            elsif n == '1' && i == 2
                n = 'x'
            elsif n == '1' && i == 5
                n = 'x'
            elsif n == '1' && i == 8
                n = 'x'
            else
                n = '-' 
            end
        permission_number_ary[i] = n
        end
        permission = permission_number_ary.join('')
        owner_uid = file_stat.uid
        file_owner = Etc.getpwuid(owner_uid).name
        group_uid = file_stat.gid
        file_group = Etc.getgrgid(group_uid).name

        
        print file_type + permission + ' ' + file_link.to_s.rjust(2,' ') + ' ' + file_owner + ' ' + file_group  + ' ' + file_size.to_s.rjust(7,' ') + ' ' + file_time_mtime_m.to_s.rjust(2,' ') + ' ' + file_time_mtime_d.to_s + ' ' + file_time_mtime_hour.to_s.rjust(2,'0') + ':' + file_time_mtime_min.to_s.rjust(2,'0') + ' ' + item.to_s
        print "\n"
    end
end
print "\n"

