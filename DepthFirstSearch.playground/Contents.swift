
import Foundation

class Graph {
    var adjacencyList: [Int: [Int]] = [:]
    
    func addEdge(_ u: Int, _ v: Int) {
        adjacencyList[u, default: []].append(v)
        adjacencyList[v, default: []].append(u)
    }
    
    func bfs(start: Int) {
        var visited = Set<Int>()
        var queue: [Int] = [start]
        
        visited.insert(start)
        
        while !queue.isEmpty {
            let vertex = queue.removeFirst()
            print(vertex)
            
            for neighbor in adjacencyList[vertex, default: []] {
                if !visited.contains(neighbor) {
                    visited.insert(neighbor)
                    queue.append(neighbor)
                }
            }
        }
    }
    
    func dfs(start: Int) {
        var visited = Set<Int>()
        dfsUtil(vertex: start, visited: &visited)
    }
       
    private func dfsUtil(vertex: Int, visited: inout Set<Int>) {
        visited.insert(vertex)
        print(vertex)
        
        for neighbor in adjacencyList[vertex, default: []] {
            if !visited.contains(neighbor) {
                dfsUtil(vertex: neighbor, visited: &visited)
            }
        }
    }

}


let graph = Graph()
graph.addEdge(1, 2)
graph.addEdge(1, 3)
graph.addEdge(2, 4)
graph.addEdge(3, 5)

print("Обход в ширину (BFS):")

graph.bfs(start: 1)
