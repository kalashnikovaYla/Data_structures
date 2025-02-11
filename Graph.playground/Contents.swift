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


let graph = Graph()
graph.addEdge(from: "A", to: "B", weight: 1)
graph.addEdge(from: "A", to: "C", weight: 4)
graph.addEdge(from: "B", to: "C", weight: 2)
graph.addEdge(from: "B", to: "D", weight: 5)
graph.addEdge(from: "C", to: "D", weight: 1)

let distances = graph.dijkstra(start: "A")
print(distances)


 
///207. Course Schedule
///There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.
///For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
///Return true if you can finish all courses. Otherwise, return false.


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
 
class Solution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        var graph = [Int:[Int]](), inDegrees = [Int](), sources = [Int]()
        //Init
        for i in 0..<numCourses {
            graph[i] = [Int]()
            inDegrees.append(0)
        }
        //Fill
        for p in prerequisites {
            let par = p[1], c = p[0]
            graph[par]!.append(c)
            inDegrees[c] += 1
        }

        //Get sources
        for i in 0..<inDegrees.count {
            if inDegrees[i] == 0 { sources.append(i) }
        }
        var count = 0
        while sources.count > 0 {
            let top = sources.removeLast()
            count += 1
            for n in graph[top]! {
                inDegrees[n] -= 1
                if inDegrees[n] == 0 { sources.append(n) }
            }
        }
        return count == numCourses
    }
}
