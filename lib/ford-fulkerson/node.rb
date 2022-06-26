# frozen_string_literal: true
module FordFulkerson
  class Node
    @@total_count_of_nodes ||= 0
    
    def initialize(name = nil) 
      @name      = name
      @id        = set_id
      @edges   ||= Hash.new
      @history ||= Hash.new(false)
    end
    
    attr_reader :id, :name, :edges, :history

    private

    def set_id
      @@total_count_of_nodes += 1
    end
  
    def add_edge(node, value = 0)
      @edges.merge!( { node => value } ) 
    end
  
    def mark_as_visited(history_line)
      @history[history_line] = true
    end
  
    def is_visited?(history_line)
      @history[history_line]
    end
  
    def find_not_visited_node_in_edges(history_line)
      @edges.keys.find { |node| !node.is_visited?(history_line) }
    end
  end
end