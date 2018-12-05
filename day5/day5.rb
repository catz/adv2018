initial_polymer = 'dabAcCaCBAcCcaDA'

def colide? c1, c2
  c1 != c2 && c1.casecmp?(c2)
end

def final_polimer s
  i = 0
  l = s.length
  n = ""
  colide = false
  while i < l do
    if colide?(s[i], s[i+1])
      colide = true
      i += 2
    else
      n << s[i]
      i+=1
    end
  end
  colide ? final_polimer(n) : n
end

def better_reaction s
  uniq_units = s.downcase.split(//).uniq
  reactions = {}

  uniq_units.map{|unit|
    new_polymer = s.gsub(Regexp.new("#{unit}", true), '')
    reactions[unit] = final_polimer(new_polymer).length
  }
  reactions.min_by{|k, v| v}
end

p 'dabCBAcaDA' == final_polimer(initial_polymer)
p 4 == better_reaction(initial_polymer)[1]

polymer = File.read("polymer.txt").chomp
p 11108 == final_polimer(polymer).length
p 5094 == better_reaction(polymer)[1]
