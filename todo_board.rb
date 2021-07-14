require_relative "list"

class TodoBoard
    def initialize()
        @list = Hash.new
    end

    def get_command
        print "\nEnter a command: "
        cmd, label, *args = gets.chomp.split(" ")

        case cmd
        when 'mklist'
            @list[label] = List.new(label)
        when 'ls'
            puts "-------------------------------------------------"
            puts "|                     Label                     |"
            puts "-------------------------------------------------"
            @list.keys.each {|label| puts "|#{label.upcase.center(47)}|"}
            puts "-------------------------------------------------"
        when 'showall'
            @list.each_value(&:print)
        when 'mktodo'
            @list[label].add_item(*args)
        when 'up'
            if args.length == 1
                @list[label].up(args[0].to_i)
            else
                @list[label].up(args[0].to_i, args[1].to_i)
            end
        when 'down'
            if args.length == 1
                @list[label].down(args[0].to_i)
            else
                @list[label].down(args[0].to_i, args[1].to_i)
            end        
        when 'swap'
            @list[label].swap(args[0].to_i, args[1].to_i)
        when 'sort'
            @list[label].sort_by_date!
        when 'priority'
            @list[label].print_priority
        when 'print'
            if args.length == 0
                @list[label].print
            else
                @list[label].print_full_item(args[0].to_i)
            end
        when 'toggle'
            @list[label].toggle_item(args[0].to_i)
        when 'rm'
            @list[label].remove_item(args[0].to_i)
        when 'purge'
            @list[label].purge
        when 'quit'
            return false
        else
            print "Sorry, that command is not recognized."
        end
        true
    end

    def run
        while true
            return if !get_command
        end
    end
end

TodoBoard.new.run