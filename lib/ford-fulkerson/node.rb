# frozen_string_literal: true
module FordFulkerson
  class Node
    attr_reader :id, :name, :edges, :history
  
    @@total_count_of_nodes ||= 0
  
    def initialize(name = nil) 
      @name      = name
      @id        = set_id
      @edges   ||= Hash.new
      @history ||= Hash.new(false)
    end

    def set_id
      @@total_count_of_nodes += 1
    end
  
    def add_edge(node, value = 0)
      @edges.merge!( { node => value } ) 
    end
  
    def mark_as_viseted(history_line)
      @history[history_line] = true
    end
  
    def is_viseted?(history_line)
      @history[history_line]
    end
  
    def find_not_viseted_node_in_edges(history_line)
      @edges.keys.find { |node| !node.is_viseted?(history_line) }
    end
  end
end