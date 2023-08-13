
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
