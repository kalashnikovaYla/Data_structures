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

func postOrderTraversal(node: TreeNode?) -> [Int] {

    guard let node = node else { return [] }
    
    
    let leftValues = postOrderTraversal(node: node.left)
    let rightValues = postOrderTraversal(node: node.right)
    
    return leftValues + rightValues + [node.val]
}


func preorderTraversal(root: TreeNode?) -> [Int] {
    var result = [Int]()
    var stack = [TreeNode]()
    
    if let root = root {
        stack.append(root)
    }
    
    while !stack.isEmpty {
        let node = stack.removeLast()
        result.append(node.val)
        
        
        if let right = node.right {
            stack.append(right)
        }
        if let left = node.left {
            stack.append(left)
        }
    }
    
    return result
    
}

func preorderTraversal(_ root: TreeNode?) -> [Int] {
    var result: [Int] = []
    dfs(root)
    
    func dfs(_ node: TreeNode?) {
        guard let node = node else { return }
        
        result.append(node.val)
        dfs(node.left)
        dfs(node.right)
    }
    
    return result
}

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


func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    if nums.isEmpty {
        return nil
    }
    let middle = nums.count / 2
    let dummy = TreeNode(nums[middle])
    let left = Array(nums[0..<middle])
    dummy.left = sortedArrayToBST(left)
    let right = Array(nums[(middle + 1)..<nums.count])
    dummy.right = sortedArrayToBST(right)
    return dummy
}

sortedArrayToBST([-10, 4,5,8])


func sortedArrayToBST(nums: [Int]) -> TreeNode? {
    // Используем стек для итеративного подхода
    var stack: [(Int, Int)] = [] // храним пары (левый индекс, правый индекс)
    var root: TreeNode?
    
    // Инициализируем стек с полными границами массива
    stack.append((0, nums.count - 1))

    while !stack.isEmpty {
        let (left, right) = stack.removeLast()

        // Когда левый индекс больше правого, ничего не добавляем
        if left > right {
            continue
        }

        // Находим средний индекс
        let mid = (left + right) / 2
        // Создаем новый узел дерева с элементом среднего индекса
        let node = TreeNode(nums[mid])
        
        // Если это первый узел, то он корень дерева
        if root == nil {
            root = node
        } else {
            // Вставляем новый узел в дерево
            var current: TreeNode? = root
            while true {
                if nums[mid] < current!.val {
                    if current!.left == nil {
                        current!.left = node
                        break
                    } else {
                        current = current!.left
                    }
                } else {
                    if current!.right == nil {
                        current!.right = node
                        break
                    } else {
                        current = current!.right
                    }
                }
            }
        }

        // Добавляем новые границы для левой и правой части
        stack.append((left, mid - 1)) // Левый подмассив
        stack.append((mid + 1, right)) // Правый подмассив
    }

    return root
}


func rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {
    var current = root
    var stack: [TreeNode] = []
    var sum = 0
    while !stack.isEmpty || current != nil {
        while current != nil {
            stack.append(current!)
            current = current?.left
        }
        
        current = stack.popLast()
        if let val = current?.val, val >= low && val <= high {
            sum += val
        }
        current = current?.right
    }
    return sum
}
 
func rangeSumBST(root: TreeNode?, _ low: Int, _ high: Int) -> Int {
    guard let root = root else { return 0 }
    
    var sum = 0
    
    if root.val >= low && root.val <= high {
        sum += root.val
    }
    
    if root.val > low {
        sum += rangeSumBST(root.left, low, high)
    }
    
    if root.val < high {
        sum += rangeSumBST(root.right, low, high)
    }
    
    return sum
}

func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
    guard let root = root else { return false }
    
    var queue: [(node: TreeNode, parent: TreeNode?)] = [(root, nil)]
    var foundX: (parent: TreeNode?, depth: Int)? = nil
    var foundY: (parent: TreeNode?, depth: Int)? = nil
    
    var depth = 0
    while !queue.isEmpty {
        var size = queue.count
        for _ in 0..<size {
            let (node, parent) = queue.removeFirst()
            
            if node.val == x {
                foundX = (parent, depth)
            }
            if node.val == y {
                foundY = (parent, depth)
            }
            
            if foundX != nil && foundY != nil {
                break
            }
            
            if let left = node.left {
                queue.append((left, node))
            }
            if let right = node.right {
                queue.append((right, node))
            }
        }
        
        if foundX != nil && foundY != nil {
            break
        }
        depth += 1
    }
    
    if let xData = foundX, let yData = foundY {
        return xData.parent !== yData.parent && xData.depth == yData.depth
    }
    
    return false
}


func minDepth(_ root: TreeNode?) -> Int {
    guard let root = root else {return 0}
    var minDepth = 1
    var queue: [TreeNode] = [root]
    while !queue.isEmpty {
        for i in 0..<queue.count {
            let el = queue.removeFirst()
            if el.left == nil && el.right == nil {
                return minDepth
            }
            if let l = el.left {
                queue.append(l)
            }
            if let r = el.right {
                queue.append(r)
            }
        }
        minDepth += 1
    }
    return minDepth
}


func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
    guard let node = root else {
        return false
    }
    
    let newTargetSum = targetSum - node.val
    
    if node.left == nil && node.right == nil {
        return newTargetSum == 0
    }
    
    return hasPathSum(node.left, newTargetSum) || hasPathSum(node.right, newTargetSum)
}



func hasPathSum(root: TreeNode?, _ targetSum: Int) -> Bool {
    guard let root = root else {
        return targetSum == 0
    }

    var stack: [(TreeNode, Int)] = []
    stack.append((root, targetSum - root.val))

    while !stack.isEmpty {
        let (node, currentSum) = stack.removeLast()
        
        if node.left == nil && node.right == nil {
            if currentSum == 0 {
                return true
            }
        }
        
        if let right = node.right {
            stack.append((right, currentSum - right.val))
        }
        
        if let left = node.left {
            stack.append((left, currentSum - left.val))
        }
    }
    
    return false
}


func getMinimumDifference(_ root: TreeNode?) -> Int {
    var values = [Int]()
    inorderTraversal(root, &values)
    
    var minDiff = Int.max
    
    for i in 1..<values.count {
        let diff = values[i] - values[i - 1]
        minDiff = min(minDiff, diff)
    }
    
    return minDiff
}
private func inorderTraversal(_ node: TreeNode?, _ values: inout [Int]) {
    guard let node = node else { return }
    
    inorderTraversal(node.left, &values)
    values.append(node.val)
    inorderTraversal(node.right, &values)
}

private func dfs(_ node: TreeNode?, currentValue: Int) -> Int {
    guard let node = node else {
        return 0
    }
    let newValue = (currentValue << 1) | node.val

    if node.left == nil && node.right == nil {
        return newValue
    }
    return dfs(node.left, currentValue: newValue) + dfs(node.right, currentValue: newValue)
}

func sumRootToLeaf(_ root: TreeNode?) -> Int {
    return dfs(root, currentValue: 0)
}



let root = TreeNode(4)
root.left = TreeNode(3)
root.right = TreeNode(8)
root.right?.right = TreeNode(9)
root.right?.left = TreeNode(7)
root.left?.left = TreeNode(1)
root.left?.right = TreeNode(2)
root.left?.left?.left = TreeNode(0)
let result = postOrderTraversal(node: root)
//print(result)


func isBalanced(_ root: TreeNode?) -> Bool {
    
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        
        
        if abs(maxDepth(root: root.left) - maxDepth(root: root.right)) > 1 {
            return false
        } else {
            return isBalanced(root.left) && isBalanced(root.right)
        }
    }
    
    return isBalanced(root)
}

func maxDepth(root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    return 1 + max(maxDepth(root.left), maxDepth(root.right))
}


func isBalanced(root: TreeNode?) -> Bool {
    return checkHeight(root) != -1
}

private func checkHeight(_ node: TreeNode?) -> Int {
    guard let node = node else {
        return 0
    }
    
    let leftHeight = checkHeight(node.left)
    if leftHeight == -1 {
        return -1
    }

    let rightHeight = checkHeight(node.right)
    if rightHeight == -1 {
        return -1
    }

    if abs(leftHeight - rightHeight) > 1 {
        return -1
    }

    return max(leftHeight, rightHeight) + 1
}

