class Entry < ActiveRecord::Base
    belongs_to :user
    belongs_to :day

    def convert_hour_to_min(time_string)
        time_string = time_string.split(":")
        hour = time_string[0].to_i
        min = time_string[1].to_i
        min_since_midnight = hour*60 + min
    end

    def is_time_valid?(time_int)
        !(time_int > 1440 || time_int < 0)
    end

    def converted_start_time
        hour = self.start_time / 60
        min = self.start_time % 60
        if min == 0
            "#{hour}:00"
        else
            "#{hour}:#{min}"
        end
    end

    def converted_end_time
        hour = self.end_time / 60
        min = self.end_time % 60
        if min == 0
            "#{hour}:00"
        else
            "#{hour}:#{min}"
        end
    end

    # def self.booked_times
    #     Entry.all.map{|entry| [entry.start_time,entry.end_time]}
    # end

    # def is_booked?
    #     if booked_times.find{|range| self.start_time >= range[0] && self.start_time <= range[1]} == nil
    #         false
    #     else
    #         true
    #     end
    # end


end