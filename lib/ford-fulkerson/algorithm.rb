# frozen_string_literal: true
require_relative 'dfs.rb'

module FordFulkerson
  module Algorithm
    class << self
      def call(edges)
        routes = DFS.build_routes(edges)

        until routes.empty?
          result = routes.each_with_index.inject(result ||= 0) do |result, route_and_index| 
            route, index = route_and_index.first, route_and_index.last

            routes.delete_at(index) if route_has_any_zero_value?(route)
           
            min_value = find_min_route_value(route)
            reduce_route_by_value(route, min_value)
            result += min_value
          end
        end

        return result
      end

      private

      def route_has_any_zero_value?(route)
        route.any? { |r| r.edges.values.first.zero? }
      end

      def reduce_route_by_value(route, value)
        route.map { |r|  r.edges.each{ |k, v|  r.edges[k] = (v - value) } }
      end

      def find_min_route_value(route)
        route.map { |r| r.edges.values }.flatten.min
      end
    end
  end
end
