class Role < ActiveRecord::Base
    has_many :auditions

    def actors
        self.auditions.map do |audition|
            audition.actor
        end
    end

    def locations
        self.auditions.pluck(:location)
    end
    
    def lead
        got_hired = self.auditions.find(&:hired)
        # got_hired = self.audition.find_by(hired: true)
        if (got_hired)
            return got_hired
        else
            return 'no actor has been hired for this role'
        end
    end

    def understudy
        filtered_auditions = self.auditions.filter do |audition|
            audition.hired
        end

        if (filtered_auditions.length > 1)
            return filtered_auditions.second
        else
            return 'no actor has been hired for understudy for this role'
        end
    end
end