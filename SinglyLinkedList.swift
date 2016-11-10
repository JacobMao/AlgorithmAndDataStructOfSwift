//
//  SinglyLinkedList.swift
//  AlgorithmAndDataStructOfSwift
//
//  Created by Jacob Mao on 11/9/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

class SinglyListNode<T: Equatable> {
    let value: T
    var next: SinglyListNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

class SinglyLinkedList<T: Equatable> {
    private(set) var count: UInt = 0
    fileprivate var head: SinglyListNode<T>?
    fileprivate var tail: SinglyListNode<T>?
    
    var isEmpty: Bool {
        return count == 0
    }
    
    func addItem(_ item: T) {
        let newNode = SinglyListNode(value: item)
        
        if self.head == nil {
            self.head = newNode
        }
        
        if self.tail != nil {
            self.tail!.next = newNode
            self.tail = newNode
        } else {
            self.tail = newNode
        }
        
        self.count += 1
    }
    
    func dropFirstItem() -> SinglyListNode<T>? {
        guard let headNode = self.head else {
            return nil
        }
        
        self.head = headNode.next
        if self.head == nil {
            self.tail = nil
        }
        
        self.count -= 1
        
        return headNode
    }
}

