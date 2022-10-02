The Ford–Fulkerson method or Ford–Fulkerson algorithm (FFA) is a greedy algorithm that computes the maximum flow in a flow network. It is sometimes called a "method" instead of an "algorithm" as the approach to finding augmenting paths in a residual graph is not fully specified[1] or it is specified in several implementations with different running times.[2] It was published in 1956 by L. R. Ford Jr. and D. R. Fulkerson.[3] The name "Ford–Fulkerson" is often also used for the Edmonds–Karp algorithm, which is a fully defined implementation of the Ford–Fulkerson method.

The idea behind the algorithm is as follows: as long as there is a path from the source (start node) to the sink (end node), with available capacity on all edges in the path, we send flow along one of the paths. Then we find another path, and so on. A path with available capacity is called an augmenting path.






![alt text](https://i0.wp.com/algorithms.tutorialhorizon.com/files/2018/12/Max-Flow-Graph.png?resize=643%2C429)

## Basic Usage

First of all you should define `nodes`:

    node_0  = FordFulkerson::Node.new('0') # provider
    node_1  = FordFulkerson::Node.new('1')
    node_2  = FordFulkerson::Node.new('2')
    node_3  = FordFulkerson::Node.new('3')
    node_4  = FordFulkerson::Node.new('4')
    node_5  = FordFulkerson::Node.new('5') # consumer

Then we'll add edges to this nodes. The `FordFulkerson::Node` `add_edge` takes exactly two arguments: an object of `FordFulkerson::Node` (node), and a value of edge between nodes

    node_0.add_edge(node_1, 7)
    node_0.add_edge(node_2, 8)

    node_1.add_edge(node_2, 2)
    node_1.add_edge(node_3, 5)

    node_2.add_edge(node_4, 10)

    node_3.add_edge(node_4, 2)
    node_3.add_edge(node_5, 3)

    node_4.add_edge(node_5, 12)


Once we finished creating nodes we have to add it inside one array obj. NOTE: put #provider-node as first element and #consumer-node as last one:

      nodes = [
        node_0, # provider
        node_1,
        node_2,
        node_3,
        node_4,
        node_5  # consumer
      ]

AND RUN ALGORITHM:

     FordFulkerson::Algorithm.call(nodes) # output: 15

    



  
  


