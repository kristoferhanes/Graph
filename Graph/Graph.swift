//
//  Graph.swift
//  Graph
//
//  Created by Kristofer Hanes on 2017-12-05.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

public protocol VertexConnecting {
  associatedtype Vertex
  var from: Vertex { get }
  var to: Vertex { get }
}

public protocol Graph {
  associatedtype Edge: VertexConnecting
  func outgoingConnections(for vertex: Edge.Vertex) -> [Edge]?
}

