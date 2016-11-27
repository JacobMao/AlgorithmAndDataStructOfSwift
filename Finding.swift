//
//  Finding.swift
//  AlgorithmAndDataStructOfSwift
//
//  Created by Jacob Mao on 11/11/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

struct Finding {
    func rSelect<T: Comparable>(items: [T], at pos: UInt) -> T {
        assert(!items.isEmpty)

        if items.count == 1 {
            return items[0]
        }

        let partitionRet = self.partition(items)
        let pivotElePos = UInt(partitionRet.1.count)
        if pivotElePos == pos {
            return partitionRet.0
        }

        if pivotElePos > pos {
            return self.rSelect(items: partitionRet.1, at: pos)
        } else {
            return self.rSelect(items: partitionRet.2, at: pos - pivotElePos - 1)
        }
    }
    
    func findMax<T: Comparable>(_ items: [T]) -> T {
        assert(!items.isEmpty)

        return self.rSelect(items: items, at: UInt(items.count - 1))
    }
    
    func findSecondMax<T: Comparable>(_ items: [T]) -> T {
        assert(items.count >= 2)
        
        if items.count == 2 {
            return min(items[0], items[1])
        }
        
        return self.rSelect(items: items, at: UInt(items.count - 2))
    }
    
    /*
     You are a given a unimodal array of n distinct elements, 
     meaning that its entries are in increasing order up until its maximum element, 
     after which its elements are in decreasing order. 
     Give an algorithm to compute the maximum element that runs in O(log n) time.
    */
    func findMaxElementInUnimodalAarray<T: Comparable>(_ items: [T]) -> T {
        assert(!items.isEmpty)
        
        if items.count == 1 {
            return items[0]
        }
        
        if items.count == 2 {
            return items.max()!
        }
        
        let midIndex = items.midIndex
        let midItem = items[midIndex]
        let preItem = items[midIndex - 1]
        let nextItem = items[midIndex + 1]
        if midItem > preItem && midItem > nextItem {
            return midItem
        }
        
        if midItem > nextItem && midItem < preItem {
            return self.findMaxElementInUnimodalAarray([T](items[0..<midIndex]))
        }
        
        
        return self.findMaxElementInUnimodalAarray([T](items[midIndex+1..<items.endIndex]))
    }
    
    private func partition<T: Comparable>(_ items: [T]) -> (T, [T], [T]) {
        var partitionItems = items
        
        let pivotIndex = Int(arc4random() % UInt32((items.count)))
        if pivotIndex != 0 {
            swap(&(partitionItems[partitionItems.startIndex]), &(partitionItems[pivotIndex]))
        }
        
        let pivotEle = partitionItems[partitionItems.startIndex]
        var i = partitionItems.startIndex + 1
        for j in (partitionItems.startIndex + 1)..<partitionItems.endIndex {
            if partitionItems[j] < pivotEle {
                if j != i {
                    swap(&(partitionItems[i]), &(partitionItems[j]))
                }
                
                i += 1
            }
        }
        
        let pivotEleIndex = i - 1
        
        if pivotEleIndex != partitionItems.startIndex {
            swap(&(partitionItems[partitionItems.startIndex]), &(partitionItems[pivotEleIndex]))
        }
        
        let leftItems = partitionItems[partitionItems.startIndex..<pivotEleIndex]
        let rightItems = partitionItems[(pivotEleIndex+1)..<partitionItems.endIndex]
        
        return (partitionItems[pivotEleIndex], [T](leftItems), [T](rightItems))
    }
}
