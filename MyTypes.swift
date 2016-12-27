import Foundation

class TreeNode<T: Comparable> {
    let value: T
    var parent: TreeNode<T>?
    var leftChild: TreeNode<T>?
    var rightChild: TreeNode<T>?

    init(value: T) {
        self.value = value
    }
}

extension TreeNode {
    static func == (left: TreeNode, right: TreeNode) -> Bool {
        return left == right.value
    }

    static func != (left: TreeNode, right: TreeNode) -> Bool {
        return !(left == right)
    }

    static func < (left: TreeNode, right: TreeNode) -> Bool {
        return left < right.value
    }

    static func > (left: TreeNode, right: TreeNode) -> Bool {
        return left > right.value
    }

    static func == (left: TreeNode, right: T) -> Bool {
        return left.value == right
    }

    static func != (left: TreeNode, right: T) -> Bool {
        return !(left == right)
    }

    static func < (left: TreeNode, right: T) -> Bool {
        return left.value < right
    }

    static func > (left: TreeNode, right: T) -> Bool {
        return left.value > right
    }
}

class SinglyListNode<T: Comparable> {
    let value: T
    private(set) var next: SinglyListNode<T>?
    
    init(value: T) {
        self.value = value
    }
    
    func updateNextNode(_ node: SinglyListNode<T>?) {
        self.next = node
    }
}

class DoublyListNode<T: Comparable> : SinglyListNode<T> {
    private(set) var prev: DoublyListNode<T>?
    
    func updatePrevNode(_ node: DoublyListNode<T>?) {
        self.prev = node
    }
}

