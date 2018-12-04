
require "day4/version"
require 'date'

module Day4
  EVENT_WAKE = :wake
  EVENT_SLEEP = :sleep

  def Day4.guard filename
    current_guard = nil

    guards = File.open(File.expand_path("../../data/#{filename}", __FILE__)).map {|line|
      dt = DateTime.strptime(line.strip, "[%Y-%m-%d %H:%M")

      event = if line.include?("Guard")
        line.match(/#(\d+)/)[1].to_i
      elsif line.include?("wakes")
        EVENT_WAKE
      elsif line.include?("falls")
        EVENT_SLEEP
      else
        raise "Unknown duty: " + line
      end

      {dt: dt, event: event}
    }.sort_by{|e| e[:dt]}.inject({}) {|result, e|
      if e[:event].is_a? Integer
        current_guard = e[:event]
      else
        result[current_guard] ||= []
        result[current_guard] << e[:dt]
      end
      result
    }.map{|guard, events|
      events_sliced = events.each_slice(2)
      sleep_time = events_sliced.map{|sleep, wake|
        ((wake - sleep) * 24 * 60).to_i
      }.reduce(0, &:+)

      times_sleep = events_sliced.to_a.map{
        |e| e[0].minute .. e[1].minute-1
      }.inject({}) {
        |r, range| range.to_a.each{|d| r[d] ||=0; r[d]+=1}; r
      }

      time_intersection = times_sleep.max_by{
        |k, v| v
      }[0]

      sleep_minute = times_sleep.max_by{
        |k, v| v
      }

      [guard, sleep_time, time_intersection, sleep_minute]
    }

    strategy1 = guards.sort_by{|duty| -1 * duty[1]}
    strategy2 = guards.sort_by{|duty| -1 * duty[3][1]}

    [strategy1[0][0] * strategy1[0][2], strategy2[0][0] * strategy2[0][3][0]]
  end

  def Day4.guard_sample
    Day4.guard "sample.txt"
  end

  def Day4.guard_data
    Day4.guard "data.txt"
  end
end
