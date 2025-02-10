
import Foundation

class Graph {
    var adjacencyList: [Int: [Int]] = [:]
    
    func addEdge(_ u: Int, _ v: Int) {
        adjacencyList[u, default: []].append(v)
        adjacencyList[v, default: []].append(u)
    }
    
    func bfs(start: Int) -> [Int] {
        var visited = Set<Int>()
        var queue: [Int] = [start]
        var res: [Int] = []
        
        visited.insert(start)
        
        while !queue.isEmpty {
            let vertex = queue.removeFirst()
            res.append(vertex)
            
            for neighbor in adjacencyList[vertex, default: []] {
                if !visited.contains(neighbor) {
                    visited.insert(neighbor)
                    queue.append(neighbor)
                }
            }
        }
        return res
    }
    
    func dfs(start: Int) -> [Int] {
        var visited = Set<Int>()
        var result = [Int]()
        dfsUtil(vertex: start, visited: &visited, result: &result)
        
        return result
    }

    private func dfsUtil(vertex: Int, visited: inout Set<Int>, result: inout [Int]) {
        visited.insert(vertex)
        result.append(vertex)

        for neighbor in adjacencyList[vertex, default: []] {
            if !visited.contains(neighbor) {
                dfsUtil(vertex: neighbor, visited: &visited, result: &result)
            }
        }
    }
}


let graph = Graph()
graph.addEdge(1, 2)
graph.addEdge(1, 3)
graph.addEdge(2, 4)
graph.addEdge(3, 5)

 
print(graph.bfs(start: 1))
