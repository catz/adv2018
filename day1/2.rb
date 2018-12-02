require 'set'

r = {}
r.default = 0

a = []

File.open("data.txt").each do |line|
  a << line.to_i
end

i = a.cycle.each
x = 0

loop do
  v = i.next
  x += v
  r[x] +=1
  if r[x] > 1
    puts x
    break
  end
end


