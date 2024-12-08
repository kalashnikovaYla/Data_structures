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
            
            print(i) //0 0 0 1 0 0
            
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
