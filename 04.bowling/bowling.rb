score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  elsif s == 'S' #spare
    shots << 10
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
      if frames[i + 1][0] != 10
        point += frames[i + 1].sum + 10
      else
        point += frames[i + 1][0] + frames[i + 2][0] + 10
      end
    end
  elsif frame.sum == 10 # spare
    if i < 10
      point += frames[i + 1][0] + 10
    end
  else
    if i < 10
      point += frame.sum
    end
  end
end
puts point