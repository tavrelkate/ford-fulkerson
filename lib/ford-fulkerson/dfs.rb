# frozen_string_literal: true

module FordFulkerson
  module DFS
    class << self
      def build_routes(nodes)
        return [] if nodes.empty?

        @provider = nodes.first
        @consumer = nodes.last

        @routes          = []
        @existing_routes = {}
        @current_stack   = []

        @current_stack << @current_node = @provider

        run_building_routes
      end

      attr_reader :routes, :existing_routes, :current_stack,
                  :provider, :consumer, :current_node

      private

      def run_building_routes
        loop do
          not_visited_node = unvisited_neighbor_node

          # It's situation when we were in all nodes and returned back to first node
          # (#provider) :-> we have no nodes to go since all neighbor nodes are viseted
          return @routes if current_node_producer? && !not_visited_node

          if not_visited_node
            # Go deeper to #not_visited_node
            not_visited_node.mark_as_visited(history_line_identifier)

            @current_stack << @current_node = not_visited_node
          else
            # Build route since we are in #node_consumer
            @routes << build_route if current_node_consumer?

            # Go back; Path is already exist
            @current_stack.pop
            @current_node = @current_stack.last
          end
        end
      end

      # Finding not visited neighbor node with current history_line_identifier.
      # We use history_line_identifier because we can came in the same node from
      # two different nodes (or more..).
      # The idea is to dont mark as visited for both at the same time if we were only form one of them
      def unvisited_neighbor_node
        @current_node.find_not_visited_node_in_edges(history_line_identifier)
      end

      def build_route
        @current_stack.each_cons(2).inject([]) do |route, cons|
          from_node = cons.first
          node_to = cons.last

          value = from_node.edges[node_to]

          # Dont dulicate existing routes! Read why: FordFulkerson::Algorithm:19
          route << (
            find_existing_route(from_node, node_to) ||
            create_new_edge(from_node, node_to, value)
          )
        end
      end

      def current_node_consumer?
        @current_node == @consumer
      end

      def current_node_producer?
        @current_node == @provider
      end

      def find_existing_route(from_node, node_to)
        identifier = route_identifier(from_node, node_to)

        @existing_routes[identifier]
      end

      def history_line_identifier
        @current_stack.map(&:id)
      end

      def create_new_edge(from_node, node_to, value)
        route_node_from = Node.new
        route_node_to   = Node.new

        route_node_from.add_edge(route_node_to, value)

        identifier = route_identifier(from_node, node_to)

        @existing_routes[identifier] = route_node_from
      end

      def route_identifier(from_node, node_to)
        "#{from_node.id}-#{node_to.id}"
      end
    end
  end
end
