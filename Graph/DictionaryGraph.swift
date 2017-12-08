//
//  DictionaryGraph.swift
//  Graph
//
//  Created by Kristofer Hanes on 2017-12-08.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

struct DictionaryGraph<Edge: VertexConnecting> where Edge.Vertex: Hashable {
  var connections: [Edge.Vertex:[Edge]] = [:]
}

extension DictionaryGraph: Graph {
 
  func outgoingConnections(from vertex: Edge.Vertex) -> [Edge]? {
    return connections[vertex]
  }
  
}
