class DateTime
    attr_accessor :month,:day,:time

    def initialize(month: nil, day: nil, time: nil)
        @month = month
        @day = day
        @time = time
    end

    def vaild_month?
        if self.month > 12 || self.month < 1
            false  
        else
            true
        end
    end

    def valid_day?
        month = self.month
        case month
        when 1
            if self.day > 31 || self.day < 1
                false  
            else
                true
            end
        when 2
            if self.day > 28 || self.day < 1
                false  
            else
                true
            end
        when 3
            if self.day > 31 || self.day < 1
                false  
            else
                true
            end
        when 4
            if self.day > 30 || self.day < 1
                false  
            else
                true
            end
        when 5
            if self.day > 31 || self.day < 1
                false  
            else
                true
            end
        when 6
            if self.day > 30 || self.day < 1
                false  
            else
                true
            end
        when 7
            if self.day > 31 || self.day < 1
                false  
            else
                true
            end
        when 8
            if self.day > 31 || self.day < 1
                false  
            else
                true
            end
        when 9
            if self.day > 30 || self.day < 1
                false  
            else
                true
            end
        when 10
            if self.day > 31 || self.day < 1
                false  
            else
                true
            end
        when 11
            if self.day > 30 || self.day < 1
                false  
            else
                true
            end
        when 12
            if self.day > 31 || self.day < 1
                false  
            else
                true
            end
        end
    end

    def valid_time?
        if self.time > 1440 || self.time < 1
            false
        else 
            true
        end
    end
    
end