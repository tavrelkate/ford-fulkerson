# frozen_string_literal: true

require_relative 'algorithm'
require_relative 'node'


node_s1 = FordFulkerson::Node.new('S1') # provider
node_1  = FordFulkerson::Node.new('1')
node_2  = FordFulkerson::Node.new('2')
node_3  = FordFulkerson::Node.new('3')
node_4  = FordFulkerson::Node.new('4')
node_5  = FordFulkerson::Node.new('5')
node_s2 = FordFulkerson::Node.new('S2') # consumer


node_s1.add_edge(node_1, 10)
node_s1.add_edge(node_3, 2)
node_s1.add_edge(node_4, 4)

node_1.add_edge(node_3, 7)
node_1.add_edge(node_2, 7)

node_2.add_edge(node_s2, 8)

node_3.add_edge(node_s2, 2)
node_3.add_edge(node_2, 6)

node_4.add_edge(node_5, 10)

node_5.add_edge(node_s2, 13)


nodes = [
  node_s1, 
  node_1,
  node_2,
  node_3,
  node_4,
  node_5,
  node_s2
]


p FordFulkerson::Algorithm.call(nodes)

