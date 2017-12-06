//
//  Queue.swift
//  Graph
//
//  Created by Kristofer Hanes on 2017-12-05.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

protocol Queue {
  associatedtype Element
  mutating func enqueue(_ newElement: Element)
  mutating func dequeue() -> Element?
  var peek: Element? { get }
  var isEmpty: Bool { get }
}

struct DoubleArrayQueue<Element> {
  private var inward: [Element] = []
  private var outward: [Element] = []
}

extension DoubleArrayQueue: Queue {
  mutating func enqueue(_ newElement: Element) {
    inward.append(newElement)
  }
  
  mutating func dequeue() -> Element? {
    shift()
    return outward.popLast()
  }
  
  var peek: Element? {
    return outward.last ?? inward.first
  }
  
  var isEmpty: Bool {
    return outward.isEmpty && inward.isEmpty
  }
  
  private mutating func shift() {
    guard outward.isEmpty else { return }
    outward = inward.reversed()
    inward.removeAll()
  }
}
