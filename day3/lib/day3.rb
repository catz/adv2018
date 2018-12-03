require "day3/version"

module Day3
  def Day3.draw filename
    r = {}
    r.default = nil

    uniq_ids = []
    File.open(File.expand_path("../../data/#{filename}", __FILE__)).each do |line|
      m = line.match(/(\d+)\s@\s(\d+),(\d+):\s+(\d+)x(\d+)/)
      id = m[1].to_i; left = m[2].to_i; top = m[3].to_i; wide = m[4].to_i; tall = m[5].to_i
      uniq_ids << id

      (0..tall-1).each do |y|
        (0..wide-1).each do |x|
          key = [x + left, y + top]
          if r[key]
            uniq_ids = uniq_ids - [r[key]] - [id]
            r[key] = "X"
          end
          r[key] = id unless r[key]
        end
      end
    end

    keys = r.keys
    max_x = keys.map{|k| k.first}.max
    max_y = keys.map{|k| k[1]}.max

    overlap = 0
    out = ""
    (0..max_y+2).each do |y|
      l = []
      (0..max_x+2).each do |x|
        v = r[[x, y]]
        if v
          l << v
        end

        if v == "X"
          overlap+=1
        end

        l << "." unless v
      end
      # out += l.join() + "\n"
    end

    # File.open(File.expand_path("../../data/#{filename}.out", __FILE__), 'w') { |file| file.write(out) }
    [overlap, uniq_ids.first]
  end

  def Day3.draw_sample
    Day3.draw "sample.txt"
  end

  def Day3.draw_data
    Day3.draw "data.txt"
  end

end
