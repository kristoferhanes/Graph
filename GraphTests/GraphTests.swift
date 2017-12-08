//
//  GraphTests.swift
//  GraphTests
//
//  Created by Kristofer Hanes on 2017-12-05.
//  Copyright © 2017 Kristofer Hanes. All rights reserved.
//

import XCTest
@testable import Graph

class GraphTests: XCTestCase {
  
  let graph = DictionaryGraph<WeightedEdge<String, Int>>(connections:
    [ "a" :
      [ WeightedEdge(from: "a", to: "b", weight: 4)
      , WeightedEdge(from: "a", to: "c", weight: 2)
      ]
    , "b" :
      [ WeightedEdge(from: "b", to: "a", weight: 4)
      , WeightedEdge(from: "b", to: "c", weight: 1)
      , WeightedEdge(from: "b", to: "d", weight: 5)
      ]
    , "c" :
      [ WeightedEdge(from: "c", to: "a", weight: 2)
      , WeightedEdge(from: "c", to: "b", weight: 1)
      , WeightedEdge(from: "c", to: "d", weight: 8)
      , WeightedEdge(from: "c", to: "e", weight: 10)
      ]
    , "d" :
      [ WeightedEdge(from: "d", to: "b", weight: 5)
      , WeightedEdge(from: "d", to: "c", weight: 8)
      , WeightedEdge(from: "d", to: "e", weight: 2)
      , WeightedEdge(from: "d", to: "z", weight: 6)
      ]
    , "e" :
      [ WeightedEdge(from: "e", to: "c", weight: 10)
      , WeightedEdge(from: "e", to: "d", weight: 2)
      , WeightedEdge(from: "e", to: "z", weight: 3)
      ]
    , "z" :
      [ WeightedEdge(from: "z", to: "d", weight: 6)
      , WeightedEdge(from: "z", to: "e", weight: 3)
      ]
    ])
  
  func testShortestPath() {
    XCTAssertNil(graph.shortestPath(from: "non-existing node", to: "non-existing node"))
    XCTAssertNil(graph.shortestPath(from: "non-existing node", to: "z"))
    XCTAssertNil(graph.shortestPath(from: "a", to: "non-existing node"))
    XCTAssertEqual(graph.shortestPath(from: "a", to: "z") ?? [], ["a", "c", "b", "d", "e", "z"])
    XCTAssertEqual(graph.shortestPath(from: "z", to: "a") ?? [], ["z", "e", "d", "b", "c", "a"])
    XCTAssertEqual(graph.shortestPath(from: "a", to: "b") ?? [], ["a", "c", "b"])
  }
  
}
