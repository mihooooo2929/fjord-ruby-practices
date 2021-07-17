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

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames.each_with_index do |frame, i|
  if frame[0] == 10 # strike
    if i < 10
      point += if frames[i + 1][0] != 10
                 frames[i + 1].sum + 10
               else
                 frames[i + 1][0] + frames[i + 2][0] + 10
               end
    end
  elsif frame.sum == 10 # spare
    point += frames[i + 1][0] + 10 if i < 10
  elsif i < 10
    point += frame.sum
  end
end
puts point
