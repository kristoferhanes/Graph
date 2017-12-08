//
//  Graph.swift
//  Graph
//
//  Created by Kristofer Hanes on 2017-12-05.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import Prelude

public protocol Graph {
  associatedtype Edge: VertexConnecting
  func outgoingConnections(from vertex: Edge.Vertex) -> [Edge]?
}

public extension Graph where Edge.Vertex: Hashable {
  
  func contains(vertex: Edge.Vertex) -> Bool {
    return outgoingConnections(from: vertex) != nil
  }
  
  func depthFirstPath(from start: Edge.Vertex, to finish: Edge.Vertex) -> [Edge.Vertex]? {
    
    func search(vertex: Edge.Vertex, path: LinkedList<Edge.Vertex>, visited: inout Set<Edge.Vertex>) -> [Edge.Vertex]? {
      if visited.contains(vertex) { return nil }
      if vertex == finish {
        return Array(list: path).reversed()
      }
      visited.insert(vertex)
      for edge in outgoingConnections(from: vertex) ?? [] {
        let newPath = LinkedList.prepending(edge.to, to: path)
        guard let path = search(vertex: edge.to, path: newPath, visited: &visited) else { continue }
        return path
      }
      return nil
    }

    guard contains(vertex: start) else { return nil }
    var visited: Set<Edge.Vertex> = []
    return search(vertex: start, path: LinkedList.prepending(start, to: LinkedList.empty), visited: &visited)
  }
  
  func breadthFirstPath(from start: Edge.Vertex, to finish: Edge.Vertex) -> [Edge.Vertex]? {
    typealias Element = (vertex: Edge.Vertex, path: LinkedList<Edge.Vertex>)
    guard contains(vertex: start) else { return nil }
    var visited: Set<Edge.Vertex> = []
    var queue = DoubleArrayQueue<Element>()
    queue.enqueue((start, LinkedList(start)))
    while let current = queue.dequeue() {
      if visited.contains(current.vertex) { continue }
      if current.vertex == finish {
        return Array(list: current.path).reversed()
      }
      for edge in outgoingConnections(from: current.vertex) ?? [] {
        let newPath = LinkedList.prepending(edge.to, to: current.path)
        queue.enqueue((edge.to, newPath))
      }
      visited.insert(current.vertex)
    }
    return nil
  }
  
}

public extension Graph where Edge: Weighted, Edge.Vertex: Hashable, Edge.Weight == Int {
  
  func shortestPath(from start: Edge.Vertex, to finish: Edge.Vertex) -> [Edge.Vertex]? {
    guard contains(vertex: start) else { return nil }
    typealias Element = (vertex: Edge.Vertex, path: LinkedList<Edge.Vertex>)
    var visited: Set<Edge.Vertex> = []
    var costForVertex = [start:0]
    var priorityQueue = Heap<Element, Int>()
    priorityQueue.enqueue(element: (start, LinkedList(start)), priority: 0)
    while let current = priorityQueue.dequeueNext() {
      if visited.contains(current.vertex) { continue }
      guard current.vertex != finish else {
        return Array(list: current.path).reversed()
      }
      for edge in outgoingConnections(from: current.vertex) ?? [] {
        if visited.contains(edge.to) { continue }
        guard let vertexCost = curried(+) <^> costForVertex[current.vertex] <*> .pure(edge.weight) else { continue }
        let newPath = LinkedList.prepending(edge.to, to: current.path)
        costForVertex[edge.to] = vertexCost
        priorityQueue.enqueue(element: (edge.to, newPath), priority: vertexCost)
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
