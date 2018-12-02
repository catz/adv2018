x = 0
File.open("data.txt").each do |line|
  x+= line.to_i
end
puts x