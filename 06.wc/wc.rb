# frozen_string_literal: true

require 'optparse'

arg = ARGV[0]
options = ARGV.getopts('l')
number_of_line = File.read(arg).count("\n")
words_ary = File.read(arg).split(/\s+/)
number_of_words = words_ary.count
number_of_letter = words_ary.join.size
ary = [arg, number_of_line, number_of_words, number_of_letter]
arg, number_of_line, number_of_words, number_of_letter = ary.map do |a|
  a.to_s.rjust(8, ' ')
end

def join_all(string_a, string_b, string_c, string_d)
  string_a + string_b + string_c + string_d
end

print join_all(number_of_line, number_of_words, number_of_letter, arg)
print "\n"
