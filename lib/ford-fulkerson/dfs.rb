# frozen_string_literal: true

module FordFulkerson
  module DFS
    class << self
      def build_routes(nodes)
        return [] if nodes.empty?

        routes = Array.new
        @current_stack = Array.new
        @existing_routes = Hash.new
        @provider, @consumer = nodes.first, nodes.last
        @current_stack << @current_node = @provider

        loop do
          not_viseted_node = unvisited_neighbor

          return routes if current_node_producer? && !not_viseted_node

          if not_viseted_node
            not_viseted_node.mark_as_viseted(history_line_identifier)

            @current_stack << @current_node = not_viseted_node
          else
            routes << build_route if current_node_consumer?

            @current_stack.pop
            @current_node = @current_stack.last
          end
        end
      end

      private

      def unvisited_neighbor
        @current_node.find_not_viseted_node_in_edges(history_line_identifier)
      end

      def build_route
        @current_stack.each_cons(2).inject([]) do |route, cons|
          from_edge, edge_to = cons.first,  cons.last

          value = from_edge.edges[edge_to]

  
          route << (
            find_existing_route(from_edge, edge_to) ||
            create_new_edge(from_edge, edge_to, value)
          )
        end
      end

      def current_node_consumer?
        @current_node == @consumer
      end

      def current_node_producer?
        @current_node == @provider
      end

      def find_existing_route(from_edge, edge_to)
        identifier = route_identifier(from_edge, edge_to)

        @existing_routes[identifier]
      end

      def history_line_identifier
        @current_stack.map(&:id)
      end

      def create_new_edge(from_edge, edge_to, value)
        route_node_from = Node.new('route')
        route_node_to   = Node.new('route')

        route_node_from.add_edge(route_node_to, value)

        identifier = route_identifier(from_edge, edge_to)

        @existing_routes[identifier] = route_node_from
      end

      def route_identifier(from_edge, edge_to)
        "#{from_edge.id}-#{edge_to.id}"
      end
    end
  end
end
