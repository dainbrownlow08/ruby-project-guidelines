class Entry < ActiveRecord::Base
    belongs_to :user
    belongs_to :day

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

end