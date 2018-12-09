def max_score players, max_marble
  s  = [0]

  i = 1
  pos = s.length
  player = 1

  score = {}
  score.default = 0

  while i <= max_marble do
    if i % 23 == 0
      score[player] += i
      new_pos = pos - 7
      pos = new_pos < 0 ? (s.length - new_pos.abs) : new_pos
      v = s.delete_at(pos)
      score[player] += v
    else
      pos = (pos + 2) > s.length ? 1 : pos + 2
      s.insert(pos, i)
    end

    player = player+1 > players ? 1 : player + 1
    i+=1
  end
  score.max_by{|x| x[1]}[1]
end

p 32 == max_score(9, 25)
p 8317 == max_score(10, 1618)
p 146373 == max_score(13, 7999)
p 2764 == max_score(17, 1104)
p 54718 == max_score(21, 6111)
p 37305 == max_score(30, 5807)
p 404611 == max_score(431, 70950)