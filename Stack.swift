//
//  Stack.swift
//  AlgorithmAndDataStructOfSwift
//
//  Created by Jacob Mao on 11/5/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

struct Stack<T> {
    fileprivate var items = [T]()
    
    var size: UInt {
        return UInt(self.items.count)
    }
    
    var isEmpty: Bool {
        return self.items.isEmpty
    }
    
    mutating func push(_ item: T) {
        self.items.append(item)
    }
    
    mutating func pop() -> T? {
        return self.items.popLast()
    }

    func top() -> T? {
        return self.items.last
    }
}

extension Stack: CustomDebugStringConvertible {
    var debugDescription: String {
        return self.items.reversed().debugDescription;
    }
}



