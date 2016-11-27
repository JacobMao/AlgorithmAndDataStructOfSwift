//
//  PriorityQueue.swift
//  AlgorithmAndDataStructOfSwift
//
//  Created by Jacob Mao on 11/18/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

enum PriorityQueueType {
    case max
    case min
}

class PriorityQueue<T: Comparable> {
    private let queyeType: PriorityQueueType
    private var items: [T] = [T]()
    
    var isEmpty: Bool {
//        self.items.
        return false
    }

    var size: UInt {
        return 0
    }
    
    var firstItem: T? {
        return nil
    }
    
    init(queyeType: PriorityQueueType) {
        self.queyeType = queyeType
    }
    
    func insert(_ item: T) {
        
    }
    
    func removeFirstItem() -> T? {
        return nil
    }
}


