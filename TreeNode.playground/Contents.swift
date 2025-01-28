import UIKit

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
    public init(_ val: Int, left: TreeNode?, right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
    // Проверяем, являются ли оба узла nil.
    if p == nil && q == nil {
        return true
    }
    
    // Проверяем, являются ли оба узла непустыми.
    guard let p = p, let q = q else {
        return false
    }
    
    // Проверяем значения узлов.
    if p.val != q.val {
        return false
    }
    
    // Рекурсивно вызываем функцию для проверки левых и правых поддеревьев.
    return isSameTree(p.left, q.left) && isSameTree(p.right, q.right)
}

func inorderTraversal(_ root: TreeNode?) -> [Int] {
    var result: [Int] = []
    var stack: [TreeNode] = []
    var current = root
    
    while current != nil || !stack.isEmpty {
        
        //Добавляем root и все левые узлы
        while current != nil {
            stack.append(current!)
            current = current?.left
        }
       
        ///Берем последний элемент из стека
        current = stack.removeLast()
        result.append(current!.val) //добавляем его значение
        current = current?.right // и переходим на правый
    }
    
    return result
}
//MARK: - РУТ всегда будет отщелкиваться последним

// Пример использования:

let root = TreeNode(1)
root.right = TreeNode(2)
root.right?.left = TreeNode(3)
root.right?.right = TreeNode(4)
root.right?.right?.left = TreeNode(5)
root.right?.right?.left?.right = TreeNode(6)


let result = inorderTraversal(root)
print(result) 

public func levelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else { return [] }
    
    var result: [[Int]] = []
    var queue: [TreeNode] = [root]
    
    while !queue.isEmpty {
        var currentLevel: [Int] = []
        let levelSize = queue.count
        
        
        for i in 0..<levelSize {
            let node = queue.removeFirst()
            currentLevel.append(node.val)
            
            if let leftNode = node.left {
                queue.append(leftNode)///тут то queue - мы добавляем данные на след итерацию
            }
            
            if let rightNode = node.right {
                queue.append(rightNode)///тут то queue - мы добавляем данные на след итерацию
            }
        }
        
        result.append(currentLevel)
    }
    
    return result
}


print(levelOrder(root)) // [[1], [2], [3, 4], [5], [6]]

///104: Maximum Depth binary tree
///Given the root of a binary tree, return its maximum depth. A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

func maxDepth(_ root: TreeNode?) -> Int {
    
    guard let node = root else {
        return 0
    }
    
    let leftDepth = maxDepth(node.left)
    let rightDepth = maxDepth(node.right)
    
    return max(leftDepth, rightDepth) + 1
}


class BinarySearchTree {
    var root: TreeNode?

    
    func insert(value: Int) {
        let newNode = TreeNode(value)
        if let rootNode = root {
            insertRecursively(node: rootNode, newNode: newNode)
        } else {
            root = newNode
        }
    }
    
    private func insertRecursively(node: TreeNode, newNode: TreeNode) {
        if newNode.val < node.val {
            if let leftNode = node.left {
                insertRecursively(node: leftNode, newNode: newNode)
            } else {
                node.left = newNode
            }
        } else {
            if let rightNode = node.right {
                insertRecursively(node: rightNode, newNode: newNode)
            } else {
                node.right = newNode
            }
        }
    }
    
    func printTree() {
        printTreeRecursively(node: root)
    }
    
    private func printTreeRecursively(node: TreeNode?) {
        guard let node = node else { return }
        printTreeRecursively(node: node.left)
        print(node.val)
        printTreeRecursively(node: node.right)
    }

    func delete(_ key: Int) {
        root = deleteRec(root, key)
    }

    private func deleteRec(_ node: TreeNode?, _ key: Int) -> TreeNode? {
        guard let node = node else {
            return nil
        }

        if key < node.val {
            node.left = deleteRec(node.left, key)
        } else if key > node.val {
            node.right = deleteRec(node.right, key)
        } else {
            // Удаление узла
            if node.left == nil {
                return node.right
            } else if node.right == nil {
                return node.left
            }
            
            // Узел с двумя потомками: получить inorder преемника (минимальный узел в правом поддереве)
            node.val = minValueNode(node.right!).val
            node.right = deleteRec(node.right, node.val)
        }
        
        return node
    }
    
    private func minValueNode(_ node: TreeNode) -> TreeNode {
        var current = node
        while let left = current.left {
            current = left
        }
        return current
    }
}


func isValidBST(root: TreeNode?) -> Bool {
    return isBSTHelper(node: root, min: nil, max: nil)
}

func isBSTHelper(node: TreeNode?, min: Int?, max: Int?) -> Bool {
     
    guard let node = node else {
        return true
    }
  
    if let min = min, node.val <= min {
        return false
    }
    if let max = max, node.val >= max {
        return false
    }
 
    return isBSTHelper(node: node.left, min: min, max: node.val) &&
           isBSTHelper(node: node.right, min: node.val, max: max)
}


func isValidBST(_ root: TreeNode?) -> Bool {
    var stack: [TreeNode] = []
    var currentNode = root
    var previousValue: Int? = nil
    
    while !stack.isEmpty || currentNode != nil {
         
        while currentNode != nil {
            stack.append(currentNode!)
            currentNode = currentNode?.left
        }
        
        currentNode = stack.removeLast()
        
        
        if let prev = previousValue, currentNode!.val <= prev {
            return false
        }
        
        previousValue = currentNode!.val
        currentNode = currentNode?.right
    }
    
    return true
}


//MARK: 101 Symmetric tree
func isSymmetric(_ root: TreeNode?) -> Bool {
    return symmetric(left: root?.left, right: root?.right)
}

func symmetric(left: TreeNode?, right: TreeNode?) -> Bool {
    if left == nil && right == nil {
        return true
    }
    
    if left == nil || right == nil {
        return false
    }
    
    return left?.val == right?.val && symmetric(left: left?.left, right: right?.right) && symmetric(left: left?.right, right: right?.left)
}


func isSymmetric(root: TreeNode?) -> Bool {
    guard let root = root else { return true }
    
    var queue: [(TreeNode?, TreeNode?)] = [(root.left, root.right)]

    while !queue.isEmpty {
        let (left, right) = queue.removeFirst()
        
        if left == nil && right == nil {
            continue
        }
        
        if left == nil || right == nil {
            return false
        }
       
        
        if left!.val != right!.val {
            return false
        }
         
        queue.append((left!.left, right!.right))
        queue.append((left!.right, right!.left))
    }

    return true
}
