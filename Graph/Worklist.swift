//
//  Worklist.swift
//  Graph
//
//  Created by Kristofer Hanes on 2017-12-05.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

protocol Worklist {
  associatedtype Element
  mutating func insert(_ newElement: Element)
  mutating func next() -> Element?
}
