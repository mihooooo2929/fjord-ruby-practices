# frozen_string_literal: true

require 'optparse'
require 'etc'

MAX_COLUMN = 3

options = ARGV.getopts('alr')
options_a = options['a']
options_l = options['l']
options_r = options['r']

items = if options_a == true && options_l == true && options_r == true
          Dir.entries('.').reverse
        elsif options_a == true && options_l == true && options_r == false
          Dir.entries('.').sort
        elsif options_a == true && options_r == true && options_l == false
          Dir.entries('.').reverse
        elsif options_l == true && options_r == true && options_a == false
          Dir.glob('*').reverse
        elsif options_a == true && options_l == false && options_r == false
          Dir.entries('.').sort
        elsif options_l == true && options_a == false && options_r == false
          Dir.glob('*').sort
        elsif options_r == true && options_a == false && options_l == false
          Dir.glob('*').reverse
        else
          Dir.glob('*')
        end

window_length = `tput cols`.to_i
max_item_string_length = 0

items.each do |item|
  max_item_string_length = item.to_s.length if max_item_string_length <= item.to_s.length
end

number_of_columns = window_length / (max_item_string_length + 1)
number_of_columns = MAX_COLUMN if number_of_columns > MAX_COLUMN

def calculate_reminder(items, number_of_columns, options_l)
  remainder_n = items.length % number_of_columns
  while remainder_n != 0 && options_l != true
    items.push('')
    remainder_n = items.length % number_of_columns
  end
end

calculate_reminder(items, number_of_columns, options_l)

if options_l == true
  items_length = 0
  while items_length < items.length
    item = items[items_length]
    file_stat = File.stat(File.absolute_path(item.to_s))
    permission_number_ary = ((file_stat.mode.to_s(2).to_i / 1) % 1_000_000_000).to_s.split('')
    file_type = file_stat.ftype
    case file_type
    when 'directory'
      file_type = 'd'
    when 'file'
      file_type = '-'
    when 'link'
      file_type - 'l'
    end
    file_size = file_stat.size
    file_time_mtime = file_stat.mtime
    mtime_m_string = file_time_mtime.month.to_s.rjust(2, ' ')
    mtime_d_string = file_time_mtime.day
    mtime_h_string = file_time_mtime.hour.to_s.rjust(2, '0')
    mtime_min_string = file_time_mtime.min.to_s.rjust(2, '0')
    file_time_mtime = "#{mtime_m_string} #{mtime_d_string} #{mtime_h_string}:#{mtime_min_string}"
    file_link = file_stat.nlink
    permission_number_ary.each_with_index do |n, i|
      n = if n == '1' 
            if (i == 6 || 3 || 0)
              'r'
            elsif (i == 7 || 4 || 1)
              'w'
            elsif (i == 8 || 5 || 2)
              'x'
            end
          else
            '-'
          end
      permission_number_ary[i] = n
    end
    permission = permission_number_ary.join('')
    owner_uid = file_stat.uid
    owner = Etc.getpwuid(owner_uid).name
    group_uid = file_stat.gid
    group = Etc.getgrgid(group_uid).name
    link_st = file_link.to_s.rjust(2, ' ')
    size_st = file_size.to_s.rjust(8, ' ')
    print "#{file_type}#{permission} #{link_st} #{owner} #{group} #{size_st} #{file_time_mtime} #{item}"
    print "\n"
    items_length += 1
  end
else
  number_of_rows = (items.length / number_of_columns.to_i).to_i
  transposed_items = items.each_slice(number_of_rows).to_a.transpose
  this_item_x = 0
  transposed_items_ary = []

  def print_new_line(transposed_items_ary, this_item_x, number_of_columns)
    transposed_items_ary.each_with_index do |_, i|
      print "\n" if (i % (number_of_columns * this_item_x)).zero?
    end
  end

  while this_item_x < transposed_items.length
    this_item_y = 0
    while this_item_y < number_of_columns
      print transposed_items[this_item_x][this_item_y].ljust(max_item_string_length.to_i + 1, ' ')
      transposed_items_ary << transposed_items[this_item_x][this_item_y]
      this_item_y += 1
    end
    this_item_x += 1
    print_new_line(transposed_items_ary, this_item_x, number_of_columns)
  end
end
