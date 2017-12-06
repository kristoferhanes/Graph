//
//  Graph.swift
//  Graph
//
//  Created by Kristofer Hanes on 2017-12-05.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

public protocol Graph {
  associatedtype Edge: VertexConnecting
  func outgoingConnections(from vertex: Edge.Vertex) -> [Edge]?
}

extension Graph where Edge.Vertex: Hashable {
  
  func depthFirstPath(from start: Edge.Vertex, to finish: Edge.Vertex) -> [Edge.Vertex]? {
    
    func search(vertex: Edge.Vertex, path: LinkedList<Edge.Vertex>, visited: inout Set<Edge.Vertex>) -> [Edge.Vertex]? {
      if visited.contains(vertex) { return nil }
      if vertex == finish {
        return Array(list: path).reversed()
      }
      visited.insert(vertex)
      for edge in outgoingConnections(from: vertex) ?? [] {
        let newPath = LinkedList.connected(edge.to, path)
        guard let path = search(vertex: edge.to, path: newPath, visited: &visited) else { continue }
        return path
      }
      return nil
    }

    var visited: Set<Edge.Vertex> = []
    return search(vertex: start, path: LinkedList.connected(start, LinkedList.empty), visited: &visited)
  }
  
  func breadthFirstPath(from start: Edge.Vertex, to finish: Edge.Vertex) -> [Edge.Vertex]? {
    var visited: Set<Edge.Vertex> = []
    var queue = DoubleArrayQueue<(vertex: Edge.Vertex, path: LinkedList<Edge.Vertex>)>()
    queue.enqueue((start, LinkedList.connected(start, LinkedList.empty)))
    while let current = queue.dequeue() {
      if visited.contains(current.vertex) { continue }
      if current.vertex == finish {
        return Array(list: current.path).reversed()
      }
      for edge in outgoingConnections(from: current.vertex) ?? [] {
        let newPath = LinkedList.connected(edge.to, current.path)
        queue.enqueue((edge.to, newPath))
      }
      visited.insert(current.vertex)
    }
    return nil
  }
  
}

public protocol VertexConnecting {
  associatedtype Vertex
  var from: Vertex { get }
  var to: Vertex { get }
}

public protocol Weighted {
  associatedtype Weight
  var weight: Weight { get }
}
