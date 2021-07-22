# frozen_string_literal: true

NUMBER_OF_FRAMES = 10
STRIKE = 10
SPARE = 10

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

frames.each_with_index do |frame, i|
  next unless i < NUMBER_OF_FRAMES

  point += if frame[0] == STRIKE
             if frames[i + 1][0] == STRIKE
               frames[i + 1][0] + frames[i + 2][0] + STRIKE
             else
               frames[i + 1].sum + STRIKE
             end
           elsif frame.sum == SPARE
             frames[i + 1][0] + SPARE
           else
             frame.sum
           end
end
puts point
