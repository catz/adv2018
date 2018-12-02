require "day2/version"
require 'levenshtein'

module Day2
  def Day2.checksum filename
    s = []
    File.open(File.expand_path("../../data/#{filename}", __FILE__)).each do |line|
      r = {}
      r.default = 0
      a = line.strip.split(//)
      a.each {|e| r[e] += 1}
      l = r.values.uniq.sort - [1]
      s << l unless l.empty?
    end
    s.flatten.inject({}) {|memo, n|
      memo[n] ||= 0
      memo[n] +=1
      memo
    }.values.reduce(1, :*)
  end

  def Day2.sample
    Day2.checksum "sample.txt"
  end

  def Day2.data
    Day2.checksum "data.txt"
  end

  def Day2.levenshtein_distance(s1, s2)
    ::Levenshtein.distance s1, s2
  end

  def Day2.common filename
    lines = []
    File.open(File.expand_path("../../data/#{filename}", __FILE__)).each do |line|
      lines << line.strip
    end

    s = nil
    for line1 in lines
      for line2 in lines
        if Day2.levenshtein_distance(line1, line2) == 1
          puts "#{line1}\n#{line2}"
          s =  line1.split(//).zip(line2.split(//)).reject{|x| x[0]!=x[1]}.map{|x| x.first}.join()
          break
        end
      end
      break if s
    end
    puts s
    s
  end

  def Day2.common_sample
    Day2.common "sample2.txt"
  end

  def Day2.common_data
    Day2.common "data.txt"
  end
end
