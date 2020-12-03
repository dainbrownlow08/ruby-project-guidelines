class Day < ActiveRecord::Base
    has_many :entries
    has_many :users, through: :entries

    def date
        "#{self.month}/#{self.day}"
    end
end