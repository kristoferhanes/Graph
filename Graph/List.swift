//
//  List.swift
//  Graph
//
//  Created by Kristofer Hanes on 2017-12-05.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

protocol List {
  associatedtype Element
  static var empty: Self { get }
  static func connected(_ newElement: Element, _ list: Self) -> Self
  func list<T>(empty: () -> T, connected: (Element, Self) -> T) -> T
}

extension List {
  
  var decomposed: (first: Element, remaining: Self)? {
    return list(
      empty: {
        nil
    },
      connected: { first, remaining in
        (first, remaining)
    })
  }
  
}

extension Array {
  
  init<L>(list: L) where L: List, L.Element == Element {
    var result: [Element] = []
    var list = list
    while let (element, remaining) = list.decomposed {
      result.append(element)
      list = remaining
    }
    self = result
  }
  
}

struct LinkedList<Element> {
  private var head: Node
}

extension LinkedList {
  
  enum Node {
    case empty
    indirect case connected(Element, Node)
  }
  
}

extension LinkedList: List {

  static var empty: LinkedList {
    return LinkedList(head: Node.empty)
  }

  static func connected(_ newElement: Element, _ list: LinkedList) -> LinkedList {
    return LinkedList(head: Node.connected(newElement, list.head))
  }

  func list<T>(empty: () -> T, connected: (Element, LinkedList) -> T) -> T {
    switch head {
    case .empty:
      return empty()
    case let .connected(element, remaining):
      return connected(element, LinkedList(head: remaining))
    }
  }

}

