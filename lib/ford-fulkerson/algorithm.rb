# frozen_string_literal: true
require_relative 'dfs.rb'

module FordFulkerson
  module Algorithm
    class << self
      def call(nodes)
        routes = DFS.build_routes(nodes)

        until routes.empty?
          result = routes.each_with_index.inject(result ||= 0) do |result, route_and_index| 
            @route, index = route_and_index.first, route_and_index.last

            # If route has 0 value it cant provide traffic so it's useless
            routes.delete_at(index) if route_has_any_zero_value?
           
            min_value = find_min_route_value

            # Reducing route by value affects others routes
            # if they have the same edges in it;
            # This common edges will be reduced for all routes.
            # ( It's one edge object in all routes )
            reduce_route_by_value(min_value)
            result += min_value
          end
        end

        return result
      end

      attr_reader :route

      private

      def route_has_any_zero_value?
        route.any? { |r| r.edges.values.first.zero? }
      end

      def reduce_route_by_value(value)
        route.map { |r|  r.edges.each{ |k, v|  r.edges[k] = (v - value) } }
      end

      def find_min_route_value
        route.map { |r| r.edges.values }.flatten.min
      end
    end
  end
end
