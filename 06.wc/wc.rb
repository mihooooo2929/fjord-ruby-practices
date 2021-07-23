# frozen_string_literal: true

require 'optparse'

arg = ARGV[0]
options = ARGV.getopts('l')
number_of_line = File.read(arg).count("\n")
words_ary = File.read(arg).split(/\s+/)
number_of_words = words_ary.count
number_of_letter = words_ary.join.size
ary = [number_of_line, number_of_words, number_of_letter, arg]

number_of_line, number_of_words, number_of_letter, arg = ary.map do |a|
  a.to_s.rjust(8, ' ')
end

def print_joined_string_args(strings_ary)
  print strings_ary.join
end

strings_ary = if options['l']
                [number_of_line, arg]
              else
                [number_of_line, number_of_words, number_of_letter, arg]
              end

print_joined_string_args(strings_ary)
print "\n"
