import UIKit

 

class Graph {
    var adjacencyList: [String: [(String, Int)]] = [:]
    
    func addEdge(from: String, to: String, weight: Int) {
        adjacencyList[from, default: []].append((to, weight))
        adjacencyList[to, default: []].append((from, weight))
    }
    
    func dijkstra(start: String) -> [String: Int] {
        var distances = [String: Int]()
        var priorityQueue = [(node: String, distance: Int)]()
        
       
        for vertex in adjacencyList.keys {
            distances[vertex] = Int.max
        }
        distances[start] = 0
        priorityQueue.append((start, 0))
        
        while !priorityQueue.isEmpty {
            
            priorityQueue.sort {
                $0.distance < $1.distance
            }
            let (currentNode, currentDistance) = priorityQueue.removeFirst()

             
            if currentDistance > distances[currentNode]! {
                continue
            }
            
            if let neighbors = adjacencyList[currentNode] {
                for (neighbor, weight) in neighbors {
                    let distance = currentDistance + weight
                    if distance < distances[neighbor]! {
                        distances[neighbor] = distance
                        priorityQueue.append((neighbor, distance))
                    }
                }
            }
        }
        
        return distances
    }
}


/*
 let graphs = Graph()
 graphs.addEdge(from: "A", to: "B", weight: 1)
 graphs.addEdge(from: "A", to: "C", weight: 4)
 graphs.addEdge(from: "B", to: "C", weight: 2)
 graphs.addEdge(from: "B", to: "D", weight: 5)
 graphs.addEdge(from: "C", to: "D", weight: 1)

 let distances = graphs.dijkstra(start: "A")
 */
//print(distances)


 
///207. Course Schedule
///There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.
///For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
///Return true if you can finish all courses. Otherwise, return false.

private func dfs(_ course: Int, _ visited: inout [Int], _ graph: [[Int]]) -> Bool {
    if visited[course] == 1 {
        return false
    }
    
    if visited[course] == 2 {
        return true
    }
    
    visited[course] = 1
    
    for neighbor in graph[course] {
        if !dfs(neighbor, &visited, graph) {
            return false
        }
    }
    
    visited[course] = 2
    return true
}

func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
    var graph = Array(repeating: [Int](), count: numCourses)
    var visited = Array(repeating: 0, count: numCourses)
    
    for prereq in prerequisites {
        let course = prereq[0]
        let preCourse = prereq[1]
        graph[preCourse].append(course)
    }
     
    
    for course in 0..<numCourses {
        if !dfs(course, &visited, graph) {
            return false
        }
    }
    
    return true
}

canFinish(2, [[0,1], [1,0]])
    

 
 
/*
 There is an undirected star graph consisting of n nodes labeled from 1 to n. A star graph is a graph where there is one center node and exactly n - 1 edges that connect the center node with every other node.

 You are given a 2D integer array edges where each edges[i] = [ui, vi] indicates that there is an edge between the nodes ui and vi. Return the center of the given star graph.
 */

func findCenter(_ edges: [[Int]]) -> Int {
    var degreeCount = [Int: Int]()
    
    for edge in edges {
        let u = edge[0]
        let v = edge[1]
        
         
        degreeCount[u, default: 0] += 1
        degreeCount[v, default: 0] += 1
    }
     
    let n = edges.count + 1
    for (vertex, count) in degreeCount {
        if count == n - 1 {
            return vertex
        }
    }
     
    return 0
}


/*
 There is a bi-directional graph with n vertices, where each vertex is labeled from 0 to n - 1 (inclusive). The edges in the graph are represented as a 2D integer array edges, where each edges[i] = [ui, vi] denotes a bi-directional edge between vertex ui and vertex vi. Every vertex pair is connected by at most one edge, and no vertex has an edge to itself.

 You want to determine if there is a valid path that exists from vertex source to vertex destination.

 Given edges and the integers n, source, and destination, return true if there is a valid path from source to destination, or false otherwise.
 */
 
func validPath(n: Int, edges: [[Int]], source: Int, destination: Int) -> Bool {
     
    var graph = [Int: [Int]]()
     
    for edge in edges {
        let u = edge[0]
        let v = edge[1]
        
        graph[u, default: []].append(v)
        graph[v, default: []].append(u)
    }
    
    if source == destination {
        return true
    }
    
    var queue: [Int] = [source]
    var visited = Set<Int>()
    visited.insert(source)
    
    while !queue.isEmpty {
        let current = queue.removeFirst()
        
         
        for neighbor in graph[current] ?? [] {
            if !visited.contains(neighbor) {
                 
                if neighbor == destination {
                    return true
                }
                
                
                visited.insert(neighbor)
                queue.append(neighbor)
            }
        }
    }
    return false
}

 
let n = 5
let edges = [[0, 1], [0, 2], [1, 2], [1, 3], [2, 4]]
let source = 0
let destination = 4
let result = validPath(n: n, edges: edges, source: source, destination: destination)

print(result)


class Solution {
    func validPath(_ n: Int, _ edges: [[Int]], _ source: Int, _ destination: Int) -> Bool {
        guard n > 2 else {
            return source == destination
        }
        var adjList = Dictionary<Int, Array<Int>>()
        for edge in edges {
            let a = edge[0]
            let b = edge[1]
            adjList[a, default: []].append(b)
            adjList[b, default: []].append(a)
        }

        var visited = Set<Int>()
        var stack = Array<Int>()
        stack.append(source)
        visited.insert(source)
        while let node = stack.popLast() {
            for next in adjList[node, default: []] {
                if next == destination {
                    return true
                }
                let (inserted, _) = visited.insert(next)
                if inserted {
                    stack.append(next)
                }
            }
        }
        return false
    }
}


/*
 There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi]indicates that you must take course bi first if you want to take course ai.
  • For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
 Return the ordering of courses you should take to finish all courses. If there are many valid answers, return any of them. If it is impossible to finish all courses, return an empty array.
 */
func findOrder(numCourses: Int, prerequisites: [[Int]]) -> [Int] {
    var graph = Array(repeating: [Int](), count: numCourses)

    var inDegrees = Array(repeating: 0, count: numCourses)

    for prereq in prerequisites {
        let course = prereq[0]
        let preCourse = prereq[1]
        graph[preCourse].append(course)
        inDegrees[course] += 1
    }

    var queue: [Int] = []
    for i in 0..<numCourses {
        if inDegrees[i] == 0 {
            queue.append(i)
        }
    }

    var order: [Int] = []

    while !queue.isEmpty {
        let course = queue.removeFirst()
        order.append(course)
        
        // Reduce the in-degree of neighboring nodes
        for neighbor in graph[course] {
            inDegrees[neighbor] -= 1
            // If in-degree is zero, add to queue
            if inDegrees[neighbor] == 0 {
                queue.append(neighbor)
            }
        }
    }

    
    return order.count == numCourses ? order : []
}

// Example usage:
let numCourses = 4
let prerequisites = [[0, 1], [0, 2], [1, 3], [2, 3]]
let order = findOrder(numCourses: numCourses, prerequisites: prerequisites)
print(order)



 
public class Node {
    public var val: Int
    public var neighbors: [Node?]
    public init(_ val: Int) {
        self.val = val
        self.neighbors = []
    }
}
 

 
func cloneGraph(_ node: Node?) -> Node? {
    guard let node = node else {
        return nil
    }
    
    var clonedNodes: [Int: Node] = [:]
    
     
    func clone(_ node: Node) -> Node {
        if let cloned = clonedNodes[node.val] {
            return cloned
        }
        
        let clonedNode = Node(node.val)
        clonedNodes[node.val] = clonedNode
        

        for neighbor in node.neighbors {
            if let neighbor = neighbor {
                clonedNode.neighbors.append(clone(neighbor))
            }
        }
        
        return clonedNode
    }
    
    return clone(node)
}


