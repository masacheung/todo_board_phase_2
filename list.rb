require_relative "item"

class List
    attr_reader :label

    def initialize(label)
        @label = label
        @items = []
    end

    def label=(new_label)
        @label = new_label
    end

    def add_item(title, deadline, *description)
        data = deadline.split('-')
        if data[0].length != 4
            raise "deadline is not valid"
            return false
        elsif data[1].to_i < 1 || data[1].to_i > 12
            raise "deadline is not valid"
            return false
        elsif data[2].to_i < 1 || data[2].to_i > 31
            raise "deadline is not valid"
            return false
        end

        @items << Item.new(title, deadline, description)
        return true

    end

    def size
        @items.length
    end

    def valid_index?(index)
        return false if index >= @items.length
        
        true
    end

    def swap(index_1, index_2)
        return false if !valid_index?(index_1) || !valid_index?(index_2)
        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        return true
    end

    def [](index)
        return nil if !valid_index?(index)
        
        @items[index]
    end

    def priority
        @items[0]
    end

    def print
        puts "-------------------------------------------------"
        la = @label.upcase
        puts la.center(49)
        puts "-------------------------------------------------"
        puts "Index   | Item                | Deadline  | Done "
        puts "-------------------------------------------------"
        @items.each.with_index do |item, i|
            if item.done == true
                t = "✓"
            else
                t = "X"
            end
            puts "#{i.to_s.ljust(8)}| #{item.title.ljust(20)}| #{item.deadline} | [#{t}] "
        end
        puts "-------------------------------------------------"
    end

    def print_full_item(index)
        puts "-------------------------------------------------"
        if @items[index].done == true
            t = "✓"
        else
            t = "X"
        end
        puts "#{@items[index].title.ljust(30)}| #{@items[index].deadline} | [#{t}]"
        puts @items[index].description
        puts "-------------------------------------------------"
    end

    def print_priority
        print_full_item(0)
    end

    def up(index, amount=1)
        return false if !valid_index?(index)
        while amount > 0 && index != 0
            swap(index,index-1)
            index -= 1
            amount -= 1
        end
        true
    end

    def down(index, amount=1)
        return false if !valid_index?(index)
        while amount > 0 && index != size - 1
            swap(index, index+1)
            index += 1
            amount -=1
        end
        true
    end

    def sort_by_date!
        @items.sort_by! {|item| item.deadline}
    end

    def toggle_item(index)
        @items[index].toggle
    end

    def remove_item(index)
        @items.delete_at(index)
    end

    def purge
        @items = @items.select {|item| !item.done}
    end
end