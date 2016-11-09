//
//  Counting.swift
//  AlgorithmAndDataStructOfSwift
//
//  Created by Jacob Mao on 11/7/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

struct Counting {
    func inversivePairs<T: Comparable>(items: [T]) -> UInt {
        typealias PairsResult = (UInt, [T])
        
        func mergeAndCount(leftItems: [T], rightItems: [T]) -> PairsResult {
            if leftItems.isEmpty {
                return (0, rightItems)
            }
            
            if rightItems.isEmpty {
                return (0, leftItems)
            }
            
            var leftIndex = 0
            var rightIndex = 0
            let outputCount = leftItems.count + rightItems.count
            var outputItems = [T]()
            outputItems.reserveCapacity(outputCount)
            
            var pairsCount = 0
            for _ in 0..<outputCount {
                if leftIndex >= leftItems.count {
                    outputItems.append(contentsOf: rightItems[rightIndex..<rightItems.count])
                    break
                }
                
                if rightIndex >= rightItems.count {
                    outputItems.append(contentsOf: leftItems[leftIndex..<leftItems.count])
                    break
                }
                
                if leftItems[leftIndex] <= rightItems[rightIndex] {
                    outputItems.append(leftItems[leftIndex])
                    leftIndex += 1
                } else {
                    outputItems.append(rightItems[rightIndex])
                    rightIndex += 1
                    
                    pairsCount += leftItems.count - leftIndex
                }
            }
            
            return (UInt(pairsCount), outputItems)
        }
        
        func findPairs(_ items: [T]) -> PairsResult {
            if items.count <= 1 {
                return (0, items)
            }
            
            let mid = Int(ceil(Double(items.count) / 2.0))
            let leftItems = items[0..<mid]
            let rightItems = items[mid..<items.count]
            
            let leftRet = findPairs([T](leftItems))
            let rightRet = findPairs([T](rightItems))
            let ret = mergeAndCount(leftItems: leftRet.1, rightItems: rightRet.1)
            
            return (leftRet.0 + rightRet.0 + ret.0, ret.1)
        }
        
        return findPairs(items).0
    }
}
