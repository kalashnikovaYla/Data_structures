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
        while current != nil {
            stack.append(current!)
            current = current?.left
        }
        
        current = stack.removeLast()
        result.append(current!.val)
        current = current?.right
    }
    
    return result
}

// Пример использования:

let root = TreeNode(1)
root.right = TreeNode(2)
root.right?.left = TreeNode(3)

let result = inorderTraversal(root)
print(result) // [1, 3, 2]

public func levelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else { return [] }
    
    var result: [[Int]] = []
    var queue: [TreeNode] = [root]
    
    while !queue.isEmpty {
        var currentLevel: [Int] = []
        let levelSize = queue.count
        
        for _ in 0..<levelSize {
            let node = queue.removeFirst()
            currentLevel.append(node.val)
            
            if let leftNode = node.left {
                queue.append(leftNode)
            }
            
            if let rightNode = node.right {
                queue.append(rightNode)
            }
        }
        
        result.append(currentLevel)
    }
    
    return result
}
