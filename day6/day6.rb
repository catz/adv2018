# https://codegolf.stackexchange.com/questions/11035/find-the-convex-hull-of-a-set-of-2d-points
C=->q{r=[]
  f=m=q.sort[0]
  t=-0.5
  (_,_,t,*f=q.map{|x,y|a=x-f[0]
  b=y-f[1]
  [0==(d=a*a+b*b)?9:(-t+e=Math.atan2(b,a)/Math::PI)%2,-d,e,x,y]}.sort[0]
  r<<=f)while
  !r[1]||f!=m
  r
}

def distance p1, p2, q1, q2
  (p1-q1).abs + (p2-q2).abs
end

def max_area sample
  sample_names = (?A..?z).to_a

  sample_data = sample.each_with_index.inject({}) {|r, (dot, i)|
    r[dot] = sample_names[i]; r
  }

  top = sample.min_by{|x| x[1]}[1]
  bottom = sample.max_by{|x| x[1]}[1]

  left = sample.min_by{|x| x[0]}[0]
  right = sample.max_by{|x| x[0]}[0]

  area = {}
  area.default = 1

  internal_points = sample - C[sample]
  internal_points_names = sample_data.select{|k,v| internal_points.include? k}.values


  (0..bottom+1).each do |y|
    line = (0..right+1).map do |x|
      name = sample_data[[x, y]]

      closest_distances = sample_data.map{|(p1, p2), name| [distance(p1, p2, x, y), name]}
      min_distances = closest_distances.min_by{|d| d[0]}
      min_distance = min_distances[0]
      count_distances = closest_distances.count{|d| d[0] == min_distance}

      if name
        name
      else
        if count_distances > 1
          '.'
        else
          name = min_distances[1]
          area[name]+=1 if internal_points_names.include? name

          name.downcase
        end
      end
    end.join()
    # puts line # visualization
  end

  area.max_by{|x| x[1]}[1]
end

sample = [[1, 1], [1, 6], [8, 3],[3, 4],[5, 5],[8, 9]]

# aaaaa.cccc
# aAaaa.cccc
# aaaddecccc
# aadddeccCc
# ..dDdeeccc
# bb.deEeecc
# bBb.eeee..
# bbb.eeefff
# bbb.eeffff
# bbb.ffffFf

puts 17 == max_area(sample)

def within_range sample, threshold
  points = []

  top = sample.min_by{|x| x[1]}[1]
  bottom = sample.max_by{|x| x[1]}[1]

  left = sample.min_by{|x| x[0]}[0]
  right = sample.max_by{|x| x[0]}[0]

  (top+1..bottom-1).each do |y|
    (left+1..right-1).each do |x|
      sum = 0
      sample.each do |p1, p2|
        sum+= distance(x,y,p1,p2)
      end
      next if sum >= threshold
      points << [x,y]
    end
  end
  points.length
end

puts 16 == within_range(sample, 32)

data = [66, 204],[55, 226],[231, 196],[69, 211],[69, 335],[133, 146],[321, 136],[220, 229],[148, 138],[42, 319],[304, 181],[101, 329],[72, 244],[242, 117],[83, 237],[169, 225],[311, 212],[348, 330],[233, 268],[99, 301],[142, 293],[239, 288],[200, 216],[44, 215],[353, 289],[54, 73],[73, 317],[55, 216],[305, 134],[343, 233],[227, 75],[139, 285],[264, 179],[349, 263],[48, 116],[223, 60],[247, 148],[320, 232],[60, 230],[292, 78],[247, 342],[59, 326],[333, 210],[186, 291],[218, 146],[205, 246],[124, 204],[76, 121],[333, 137],[117, 68]

puts 3647 == max_area(data)

puts 41605 == within_range(data, 10000)