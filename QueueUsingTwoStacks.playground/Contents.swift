import Foundation

class QueueUsingTwoStacks<T> {
    private var inputStack: [T] = []
    private var outputStack: [T] = []

     
    func enqueue(_ element: T) {
        inputStack.append(element)
    }

    func dequeue() -> T? {
        if outputStack.isEmpty {
            while !inputStack.isEmpty {
                outputStack.append(inputStack.removeLast())
            }
        }
         
        return outputStack.isEmpty ? nil : outputStack.removeLast()
    }

     
    func isEmpty() -> Bool {
        return inputStack.isEmpty && outputStack.isEmpty
    }

     
    func size() -> Int {
        return inputStack.count + outputStack.count
    }
}
