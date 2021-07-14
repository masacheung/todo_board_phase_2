class Item
    attr_reader :title, :deadline, :description, :done

    def initialize(title, deadline, description)
        @title = title
        
        data = deadline.split('-')
        if data[0].length != 4
            raise "deadline is not valid"
            return
        elsif data[1].to_i < 1 || data[1].to_i > 12
            raise "deadline is not valid"
            return
        elsif data[2].to_i < 1 || data[2].to_i > 31
            raise "deadline is not valid"
            return
        end
        @deadline = deadline
        @description = description
        @done = false
    end

    def title=(new_title)
        @title = new_title
    end

    def deadline=(new_deadline)
        data = new_deadline.split('-')
        if data[0].length != 4
            raise "deadline is not valid"
            return
        elsif data[1].to_i < 1 || data[1].to_i > 12
            raise "deadline is not valid"
            return
        elsif data[2].to_i < 1 || data[2].to_i > 31
            raise "deadline is not valid"
            return
        end
        @deadline = new_deadline
    end

    def description=(new_description)
        @description = new_description
    end

    def toggle
        @done = !@done
    end
end