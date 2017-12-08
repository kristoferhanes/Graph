//
//  PriorityQueue.swift
//  Graph
//
//  Created by Kristofer Hanes on 2017-12-07.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

protocol PriorityQueue {
  associatedtype Element
  associatedtype Priority
  mutating func enqueue(element: Element, priority: Priority)
  mutating func dequeueNext() -> Element?
  var peek: Element? { get }
  var isEmpty: Bool { get }
}

struct Heap<Element, Priority: Comparable> {
  private var heap: [(priority: Priority, element: Element)] = []
}

extension Heap: PriorityQueue {
  
  mutating func enqueue(element: Element, priority: Priority) {
    heap.append((priority, element))
    siftUp(from: heap.endIndex - 1)
  }
  
  mutating func dequeueNext() -> Element? {
    guard let result = heap.first?.element else { return nil }
    heap.swapAt(heap.startIndex, heap.endIndex - 1)
    siftDown(from: heap.startIndex)
    return result
  }
  
  var peek: Element? {
    return heap.first?.element
  }
  
  var isEmpty: Bool {
    return heap.isEmpty
  }
  
}

private extension Heap {
  
  mutating func siftUp(from currentIndex: Int) {
    guard let parentIndex = parentIndex(for: currentIndex) else { return }
    guard heap[currentIndex].priority > heap[parentIndex].priority else { return }
    heap.swapAt(currentIndex, parentIndex)
    siftUp(from: parentIndex)
  }
  
  mutating func siftDown(from currentIndex: Int) {
    switch (leftChildIndex(for: currentIndex), rightChildIndex(for: currentIndex)) {
    case let (leftChildIndex?, rightChildIndex?):
      let smallerChildIndex = indexWithSmallerPriority(leftChildIndex, rightChildIndex)
      guard heap[currentIndex].priority > heap[smallerChildIndex].priority else { return }
      heap.swapAt(currentIndex, smallerChildIndex)
      siftDown(from: smallerChildIndex)
    case let (leftChildIndex?, nil):
      guard heap[currentIndex].priority > heap[leftChildIndex].priority else { return }
      heap.swapAt(currentIndex, leftChildIndex)
    case (nil, _):
      break
    }
  }
  
  func indexWithSmallerPriority(_ leftIndex: Int, _ rightIndex: Int) -> Int {
    let left = heap[leftIndex].priority
    let right = heap[rightIndex].priority
    if right < left {
      return rightIndex
    }
    else {
      return leftIndex
    }
  }
  
  func parentIndex(for childIndex: Int) -> Int? {
    guard childIndex > heap.startIndex else { return nil }
    return (childIndex - 1) / 2
  }
  
  func leftChildIndex(for parentIndex: Int) -> Int? {
    let left = parentIndex * 2 + 1
    guard left < heap.endIndex else { return nil }
    return left
  }
  
  func rightChildIndex(for parentIndex: Int) -> Int? {
    let right = parentIndex * 2 + 2
    guard right < heap.endIndex else { return nil }
    return right
  }
  
}



