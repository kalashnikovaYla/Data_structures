
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

func printLinkedList(head: ListNode?) {
    var output = ""
    var currentNode = head
    while currentNode != nil {
        output += String(currentNode?.val ?? 0)
        currentNode = currentNode?.next
    }
    print(output)
}

let second = ListNode(1)
let first = ListNode(1, second)
let head = ListNode(0, first)
printLinkedList(head: head)
//011

deleteDuplicates(head: head)
printLinkedList(head: head)
//01
