//
//  Finding.swift
//  AlgorithmAndDataStructOfSwift
//
//  Created by Jacob Mao on 11/11/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

struct Finding {
    func findMax<T: Comparable>(_ items: [T]) -> T {
        assert(!items.isEmpty)
        
        if items.count == 2 {
            return max(items[0], items[1])
        }
        
        func findingProcess(sliecedItems: ArraySlice<T>) -> T {
            if sliecedItems.count == 1 {
                return sliecedItems[sliecedItems.startIndex]
            }
            
            let leftItems = sliecedItems[sliecedItems.startIndex..<sliecedItems.midIndex]
            let rightItems = sliecedItems[sliecedItems.midIndex..<sliecedItems.endIndex]
            
            let max1 = findingProcess(sliecedItems: leftItems)
            let max2 = findingProcess(sliecedItems: rightItems)
            
            return max(max1, max2)
        }

        return findingProcess(sliecedItems: items[0..<items.count])
    }
    
    func findSecondMax<T: Comparable>(_ items: [T]) -> T {
        assert(!items.isEmpty)
        
        if items.count == 2 {
            return min(items[0], items[1])
        }
        
        var retItems = self.findingMaxProcess(comparedItems: items)
        retItems = self.findingMaxProcess(comparedItems: [T](retItems.dropFirst()))
        
        return retItems[0]
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
    
    
    private func findingMaxProcess<T: Comparable>(comparedItems: [T]) -> [T] {
        if comparedItems.count == 1 {
            return comparedItems
        }
        
        let leftItems = comparedItems[0..<comparedItems.midIndex]
        let rightItems = comparedItems[comparedItems.midIndex..<comparedItems.count]
        
        var comparedRet1 = self.findingMaxProcess(comparedItems: [T](leftItems))
        var comparedRet2 = self.findingMaxProcess(comparedItems: [T](rightItems))
        if comparedRet1[0] > comparedRet2[0] {
            comparedRet1.append(comparedRet2[0])
            return comparedRet1
        } else {
            comparedRet2.append(comparedRet1[0])
            return comparedRet2
        }
    }
}
