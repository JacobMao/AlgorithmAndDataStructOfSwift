//
//  LinkedList.swift
//  AlgorithmAndDataStructOfSwift
//
//  Created by Jacob Mao on 11/17/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

struct LinkedListIterator<T: Comparable>: IteratorProtocol {
    private let list: SinglyLinkedList<T>
    private var nextNode: SinglyListNode<T>?
    
    init(list: SinglyLinkedList<T>) {
        self.list = list
        self.nextNode = self.list.first
    }

    mutating func next() -> T? {
        guard let currentNode = self.nextNode else {
            return nil
        }

        self.nextNode = currentNode.next

        return currentNode.value
    }
}

class SinglyLinkedList<T: Comparable>: ExpressibleByArrayLiteral {
    public typealias Node = SinglyListNode<T>
    
    fileprivate var nodeCount: UInt = 0
    fileprivate var head: Node?
    fileprivate var tail: Node?

    required init(arrayLiteral: T...) {
        for item in arrayLiteral {
            self.append(item)
        }
    }
    
    func append(_ item: T) {
        let newNode = Node(value: item)
        
        if self.head == nil {
            self.head = newNode
        }

        if let lastNode = self.tail {
            lastNode.updateNextNode(newNode)
//            newNode.pre = lastNode
            self.tail = newNode
        } else {
            self.tail = newNode
        }
        
        self.nodeCount += 1
    }
    
    func insertToHead(_ item: T) {
        let newNode = Node(value: item)
        
        guard let headNode = self.head else {
            self.head = newNode
            return
        }
        
        newNode.updateNextNode(headNode)
        self.head = newNode
        self.nodeCount += 1
    }

    func index(of item: T) -> Int? {
        guard let searchResult = self.findElement(of: item) else {
            return nil
        }
        
        return searchResult.0
    }

    func remove(at index: Int) -> T {
        assert(index < self.endIndex && index >= 0)

        defer {
            if self.nodeCount == 1 {
                self.tail = self.head
            }
            
            if self.isEmpty {
                self.tail = nil
            }
        }

        if index == 0 {
            let ret = self.head!.value
            self.head = self.head?.next
            self.nodeCount -= 1
            
            return ret
        }

        guard let prevNode = self.findElement(at: index - 1) else {
            assert(false)
        }
        
        let ret = prevNode.next!.value
        
        prevNode.updateNextNode(prevNode.next?.next)
        
        if index == self.endIndex - 1 {
            self.tail = prevNode
        }

        self.nodeCount -= 1

        return ret
    }
    
    func remove(_ item: T) -> Bool {
        guard let headNode = self.head else {
            return false
        }
        
        if headNode.value == item {
            self.head = self.head?.next
            return true
        }
        
        var node = self.head
        while let currentNode = node {
            if let valueOfNextNode = currentNode.next?.value, valueOfNextNode == item {
                currentNode.updateNextNode(currentNode.next?.next)
                
                return true
            }

            node = currentNode.next
        }

        return false
    }
    
    func removeFirst() -> T {
        return self.remove(at: 0)
    }
    
    func removeLast() -> T {
        return self.remove(at: self.endIndex - 1)
    }
    
    func removeAll() {
        self.head = nil
        self.tail = nil
        self.nodeCount = 0
    }
    
    private func findElement(of item: T) -> (Int, Node)? {
        var nodeIndex = 0
        var node = self.head
        while let currentNode = node {
            if currentNode.value == item {
                return (nodeIndex, currentNode)
            }

            nodeIndex += 1
            node = currentNode.next
        }

        return nil
    }
    
    private func findElement(at position: Int) -> Node? {
        guard position < self.endIndex && position >= 0 else {
            return nil
        }

        var node = self.head
        var currentPos = position - 1
        while node != nil && currentPos >= 0 {
            currentPos -= 1
            node = node!.next
        }

        return node
    }
}

extension SinglyLinkedList: Collection {
    var isEmpty: Bool {
        return self.nodeCount == 0
    }

    var startIndex: Int {
        return 0
    }

    var endIndex: Int {
        return Int(self.nodeCount)
    }

    var first: Node? {
        return self.head
    }

    var count: Int {
        return Int(self.nodeCount)
    }
    
    subscript(position: Int) -> T {
        assert(position < self.endIndex && position >= 0)

        var node = self.head
        var currentPos = position - 1
        while node != nil && currentPos >= 0 {
            currentPos -= 1
            node = node!.next
        }

        return node!.value
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }

    func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator(list: self)
    }
}

