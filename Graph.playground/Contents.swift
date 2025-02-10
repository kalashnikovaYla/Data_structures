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

// Пример использования
let graph = Graph()
graph.addEdge(from: "A", to: "B", weight: 1)
graph.addEdge(from: "A", to: "C", weight: 4)
graph.addEdge(from: "B", to: "C", weight: 2)
graph.addEdge(from: "B", to: "D", weight: 5)
graph.addEdge(from: "C", to: "D", weight: 1)

let distances = graph.dijkstra(start: "A")
print(distances)
