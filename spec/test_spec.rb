# frozen_string_literal: true

require 'spec_helper'

describe FordFulkerson::Algorithm do
  subject { described_class.call(edges) }

  context 'Default example' do
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

    let(:edges) do
      nodes = [
        node_s1,
        node_1,
        node_2,
        node_3,
        node_4,
        node_5,
        node_s2
      ]
    end

    let(:valid_result) { 14 }

    it 'Returns valid result' do
      expect(subject).to eql(valid_result)
    end
  end

  context '2 example' do
    node_0 =  FordFulkerson::Node.new('0') # provider
    node_1  = FordFulkerson::Node.new('1')
    node_2  = FordFulkerson::Node.new('2')
    node_3  = FordFulkerson::Node.new('3')
    node_4  = FordFulkerson::Node.new('4')
    node_5  = FordFulkerson::Node.new('5') # consumer

    node_0.add_edge(node_1, 7)
    node_0.add_edge(node_2, 8)
    node_1.add_edge(node_2, 2)
    node_1.add_edge(node_3, 5)
    node_2.add_edge(node_4, 10)
    node_3.add_edge(node_4, 2)
    node_3.add_edge(node_5, 3)
    node_4.add_edge(node_5, 12)

    let(:valid_result) { 15 }

    let(:edges) do
      [
        node_0,
        node_1,
        node_2,
        node_3,
        node_4,
        node_5
      ]
    end

    it 'Returns valid result' do
      expect(subject).to eql(valid_result)
    end
  end

  context 'Simple example' do
    node_s1_1 = FordFulkerson::Node.new('S1') # provider
    node_1_1  = FordFulkerson::Node.new('1')
    node_2_1  = FordFulkerson::Node.new('2')
    node_s2_1 = FordFulkerson::Node.new('S2') # consumer

    node_s1_1.add_edge(node_1_1, 10)
    node_1_1.add_edge(node_s2_1, 10)
    node_s1_1.add_edge(node_2_1, 10)
    node_2_1.add_edge(node_s2_1, 10)

    let(:edges) do
      [
        node_s1_1,
        node_1_1,
        node_2_1,
        node_s2_1
      ]
    end

    let(:valid_result) { 20 }

    it 'Returns valid result' do
      expect(subject).to eql(valid_result)
    end
  end
end
