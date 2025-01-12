import Foundation


public class Node: CustomStringConvertible, Equatable {
  public var neighbors: [Edge]
  
  public private(set) var label: String
  public var distance: Int?
  public var visited: Bool
  
  public init(_ label: String) {
    self.label = label
    neighbors = []
    visited = false
  }
  
  public var description: String {
    if let distance = distance {
      return "Node(label: \(label), distance: \(distance))"
    }
    return "Node(label: \(label), distance: infinity)"
  }
  
  public var hasDistance: Bool {
    return distance != nil
  }
  
  public func remove(_ edge: Edge) {
    neighbors.remove(at: neighbors.index { $0 === edge }!)
  }
}

public func == (_ lhs: Node, rhs: Node) -> Bool {
  return lhs.label == rhs.label && lhs.neighbors == rhs.neighbors
}


public class Graph: CustomStringConvertible, Equatable {
  public private(set) var nodes: [Node]
  
  public init() {
    self.nodes = []
  }
  
  @discardableResult
  public func addNode(_ label: String) -> Node {
    let node = Node(label)
    nodes.append(node)
    return node
  }
  
  public func addEdge(_ source: Node, neighbor: Node) {
    let edge = Edge(neighbor)
    source.neighbors.append(edge)
  }
  
  public var description: String {
    var description = ""
    
    for node in nodes {
      if !node.neighbors.isEmpty {
        description += "[node: \(node.label) edges: \(node.neighbors.map { $0.neighbor.label})]"
      }
    }
    return description
  }
  
  public func findNodeWithLabel(_ label: String) -> Node {
    return nodes.filter { $0.label == label }.first!
  }
  
  public func duplicate() -> Graph {
    let duplicated = Graph()
    
    for node in nodes {
      duplicated.addNode(node.label)
    }
    
    for node in nodes {
      for edge in node.neighbors {
        let source = duplicated.findNodeWithLabel(node.label)
        let neighbour = duplicated.findNodeWithLabel(edge.neighbor.label)
        duplicated.addEdge(source, neighbor: neighbour)
      }
    }
    
    return duplicated
  }
}

public func == (_ lhs: Graph, rhs: Graph) -> Bool {
  return lhs.nodes == rhs.nodes
}

public class Edge: Equatable {
    public var neighbor: Node
    
    public init(_ neighbor: Node) {
        self.neighbor = neighbor
    }
}

public func == (_ lhs: Edge, rhs: Edge) -> Bool {
    return lhs.neighbor == rhs.neighbor
}


func depthFirstSearch(_ graph: Graph, source: Node) -> [String] {
    var nodesExplored = [source.label]
    source.visited = true
    
    for edge in source.neighbors {
        if !edge.neighbor.visited {
            nodesExplored += depthFirstSearch(graph, source: edge.neighbor)
        }
    }
    return nodesExplored
}

let graph = Graph()

let nodeA = graph.addNode("a")
let nodeB = graph.addNode("b")
let nodeC = graph.addNode("c")
let nodeD = graph.addNode("d")
let nodeE = graph.addNode("e")
let nodeF = graph.addNode("f")
let nodeG = graph.addNode("g")
let nodeH = graph.addNode("h")

graph.addEdge(nodeA, neighbor: nodeB)
graph.addEdge(nodeA, neighbor: nodeC)
graph.addEdge(nodeB, neighbor: nodeD)
graph.addEdge(nodeB, neighbor: nodeE)
graph.addEdge(nodeC, neighbor: nodeF)
graph.addEdge(nodeC, neighbor: nodeG)
graph.addEdge(nodeE, neighbor: nodeH)
graph.addEdge(nodeE, neighbor: nodeF)
graph.addEdge(nodeF, neighbor: nodeG)

let nodesExplored = depthFirstSearch(graph, source: nodeA)
print(nodesExplored)
