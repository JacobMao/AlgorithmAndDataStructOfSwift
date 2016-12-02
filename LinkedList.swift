//
//  LinkedList.swift
//  AlgorithmAndDataStructOfSwift
//
//  Created by Jacob Mao on 11/17/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

class ListNode<T> {
    let value: T
    fileprivate var next: ListNode<T>?
    fileprivate var pre: ListNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

struct LinkedListIterator<T: Equatable>: IteratorProtocol {
    private let list: LinkedList<T>
    private var currentIndex = 0
    
    init(list: LinkedList<T>) {
        self.list = list
    }

    mutating func next() -> T? {
        if self.currentIndex >= self.list.endIndex {
            return nil
        }

        let ret = self.list[self.currentIndex]
        self.currentIndex += 1

        return ret
    }
}

class LinkedList<T: Equatable>: ExpressibleByArrayLiteral {
    public typealias Node = ListNode<T>
    
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
            lastNode.next = newNode
            newNode.pre = lastNode
            self.tail = newNode
        } else {
            self.tail = newNode
        }
        
        self.nodeCount += 1
    }

    func index(of item: T) -> Int? {
        var node = self.head
        
        var ret = -1
        while node != nil {
            ret += 1
            if node!.value == item {
                break
            }

            node = node!.next
        }

        return ret == -1 ? nil : ret
    }

    func remove(at index: Int) -> T {
        assert(index < self.endIndex && index >= 0)

        var currentIndex = index - 1
        var node = self.head
        while currentIndex >= 0 && node != nil {
            node = node?.next
            currentIndex -= 1
        }

        guard let selectedNode = node else {
            assert(false)
        }
        
        selectedNode.pre?.next = selectedNode.next
        selectedNode.next?.pre = selectedNode.pre

        if index == 0 {
            self.head = selectedNode.next

            if self.count == 1 {
                self.tail = selectedNode.next
            }
        }

        if index == self.endIndex - 1 {
            self.tail = selectedNode.pre
        }

        selectedNode.pre = nil
        selectedNode.next = nil

        return selectedNode.value
    }
}

extension LinkedList: Collection {
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

