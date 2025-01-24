
public class ListNode {
    public var val: Int
    public var next: ListNode?
    
    public init() {
        self.val = 0
        self.next = nil
    }
    
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
}


//MARK: LinkedList
class LinkedList {
    var head: ListNode?
    
    // Добавить элемент в конец списка
    func append(_ value: Int) {
        let newNode = ListNode(value)
        if head == nil {
            head = newNode
            return
        }
        var current = head
        while current?.next != nil {
            current = current?.next
        }
        current?.next = newNode
    }
    
    // Вставка элемента по индексу
    func insert(at index: Int, value: Int) {
        let newNode = ListNode(value)
        
        // Если индекс 0, добавляем в начало
        if index == 0 {
            newNode.next = head
            head = newNode
            return
        }
        
        var current = head
        var currentIndex = 0
        
        // Проходим по списку до нужного индекса
        while current != nil && currentIndex < index - 1 {
            current = current?.next
            currentIndex += 1
        }
        
        // Если текущий узел не nil, вставляем новый узел
        if current != nil {
            newNode.next = current?.next
            current?.next = newNode
        } else {
            // Если индекс больше длины списка, можем добавить в конец
            print("Index out of bounds. Adding at the end.")
            current?.next = newNode
        }
    }
    
    // Удалить элемент по значению
    func remove(_ value: Int) {
        guard head != nil else { return }
        
        // Если нужно удалить первый элемент (голову)
        if head?.val == value {
            head = head?.next
            return
        }
        
        var current = head
        while current?.next != nil {
            if current?.next?.val == value {
                current?.next = current?.next?.next
                return
            }
            current = current?.next
        }
    }
    
    // Удалить элемент по индексу
    public func delete(at index: Int) {
        guard head != nil else { return }
        
        // Если индекс 0, удаляем голову
        if index == 0 {
            head = head?.next
            return
        }
        
        var current = head
        var currentIndex = 0
        
        // Проходим по списку до нужного индекса
        while current != nil && currentIndex < index - 1 {
            current = current?.next
            currentIndex += 1
        }
        
        // Если текущий узел не nil и следующий элемент не nil, удаляем следующий элемент
        if current != nil && current?.next != nil {
            current?.next = current?.next?.next
        } else {
            print("Index out of bounds.")
        }
    }

    
    func reverseLinkedList(_ head: ListNode?) -> ListNode? {
        var prev: ListNode? = nil
        var current = head
        
        while current != nil {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        return prev
    }
    
    func printLinkedList(head: ListNode?) {
        var output = ""
        var currentNode = head
        while currentNode != nil {
            output += String(currentNode?.val ?? 0)
            currentNode = currentNode?.next
        }
        print(output)
    }
}


//MARK: Задачи с отсортированными list node
func mergeTwoList(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    if list1 == nil {
        return list2
    }
    
    if list2 == nil {
        return list1
    }

    if list1!.val < list2!.val {
        list1?.next = mergeTwoLists(list1?.next, list2)
        return list1
    } else {
        list2?.next = mergeTwoLists(list1, list2?.next)
        return list2
    }
}

 
func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    var dummy = ListNode(0)
    var current: ListNode? = dummy
    var l1 = list1
    var l2 = list2
    
    while l1 != nil && l2 != nil {
        if (l1?.val ?? 0) < (l2?.val ?? 0) {
            current?.next = l1
            l1 = l1?.next
            current = current?.next
        } else {
            current?.next = l2
            l2 = l2?.next
            current = current?.next
        }
    }
    
    if l1 != nil {
        current?.next = l1
    }
    if l2 != nil {
        current?.next = l2
    }
    return dummy.next
}
 

//MARK: Delete duplicates

///Given the head of a sorted linked list, delete all duplicates such that each element appears only once. Return the linked list sorted as well.
//Input: head = [1,1,2]
//Output: [1,2]
func deleteDuplicates(head: ListNode?) -> ListNode? {
    var currentNode = head
    while currentNode != nil && currentNode?.next != nil {
        if currentNode?.val == currentNode?.next?.val {
            currentNode?.next = currentNode?.next?.next
        } else {
            currentNode = currentNode?.next
        }
    }
    return head
}

//MARK: Palindrome
func isPalindrome(_ head: ListNode?) -> Bool {
    var values = [UInt8]()
    var current = head
    
    while let node = current {
        values.append(UInt8(node.val))
        current = node.next
    }
    var left = 0
    var right = values.count - 1
    while left < right {
        if values[left] != values[right] {
            return false
        }
        left += 1
        right -= 1
    }
    
    return true
}

func isPalindrome(head: ListNode?) -> Bool {
    guard let head else { return true }
    
    var linkedListVals = [Int]()
    
    var currentNode: ListNode? = head
    
    while currentNode != nil {
        if let val = currentNode?.val {
            linkedListVals.append(val)
        }
        
        currentNode = currentNode?.next
    }
    
    return linkedListVals == linkedListVals.reversed()
}

func hasCycle(_ head: ListNode?) -> Bool {
    var slow = head
    var fast = head

    while fast != nil && fast?.next != nil {
        // Ходим на 1 шаг
        slow = slow?.next
        // Ходим на 2 шага
        fast = fast?.next?.next
        // Если встретились, значит есть цикл
        if slow === fast {
            return true
        }
    }
    // Если fast дошел до конца, значит цикла нет
    return false
}


func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
    if headA == nil || headB == nil {
        return nil
    }
    
    var pointerA: ListNode? = headA
    var pointerB: ListNode? = headB
    
    
    while pointerA !== pointerB {
        if pointerA == nil {
            pointerA = headB
        } else {
            pointerA = pointerA?.next
        }
        
        if pointerB == nil {
            pointerB = headA 
        } else {
            pointerB = pointerB?.next
        }
    }
    
    return pointerA
}


func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
    let dummy = ListNode(0)
    dummy.next = head
    
    var current: ListNode? = dummy
    
    while current?.next != nil {
        if current?.next?.val == val {
            current?.next = current?.next?.next
        } else {
            current = current?.next
        }
    }
    
    return dummy.next
}

func getDecimalValue(_ head: ListNode?) -> Int {
    var result = 0
    var head = head
    
    while head != nil {
        result = result * 2 + head!.val
        head = head?.next
    }
    
    return result
}


func fromIntToDecimal(nums: [Int]) -> Int {
    var decimal = 0
    var base = 1
    
    for digit in nums {
        if digit != 0 && digit != 1 {
            return 0
        }
    }
    
    for digit in nums.reversed() {
        if digit == 1 {
            decimal += base
        }
        base *= 2
    }
    
    return decimal
}

func getDecimal(_ head: ListNode?) -> Int {
    var decimal = 0
    var base = 1
    var head = head
    var queue: [Int] = []
    
    
    while head != nil {
        queue.append(head!.val)
        head = head?.next
    }
    
    for digit in queue.reversed() {
        if digit == 1 {
            decimal += base
        }
        base *= 2
    }
    
    return decimal
}

//MARK: 148 Sort list - Given the head of a linked list, return the list after sorting it in ascending order.


func sortList(_ head: ListNode?) -> ListNode? {
    if head == nil {
        return nil
    }
    
    var curr = head
    
    var array: [Int] = []
    while curr != nil {
        array.append(curr!.val)
        curr = curr?.next
    }
    let sortedQueue = quicksort(array)
    
    var dummy: ListNode? = ListNode(0)
    var result = dummy
    for i in sortedQueue {
        dummy?.next = ListNode(i)
        dummy = dummy?.next
    }
    return result?.next
}

func quicksort<T: Comparable>(_ array: [T]) -> [T] {
    
    guard array.count > 1 else {
        return array
    }
 
    let pivot = array[array.count / 2]
 
    let less = array.filter { $0 < pivot }
    let equal = array.filter { $0 == pivot }
    let greater = array.filter { $0 > pivot }

    return quicksort(less) + equal + quicksort(greater)
}


let third = ListNode(3)
let second = ListNode(2, third)
let first = ListNode(4, second)

sortList(first)
