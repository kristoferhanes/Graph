//
//  WeightedEdge.swift
//  Graph
//
//  Created by Kristofer Hanes on 2017-12-08.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

struct WeightedEdge<Vertex, Weight>: VertexConnecting, Weighted {
  var from: Vertex
  var to: Vertex
  var weight: Weight
}
