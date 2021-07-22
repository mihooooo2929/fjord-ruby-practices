# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  case s
  when 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

point = 0
number_of_frame = 10
strike = 10
spare = 10
frames.each_with_index do |frame, i|
  next unless i < number_of_frame

  point += if frame[0] == strike
             if frames[i + 1][0] == 10
               frames[i + 1][0] + frames[i + 2][0] + 10
             else
               frames[i + 1].sum + 10
             end
           elsif frame.sum == spare
             frames[i + 1][0] + 10
           else
             frame.sum
           end
end
puts point
