//
//  main.swift
//  AlgorithmAndDataStructOfSwift
//
//  Created by Jacob Mao on 11/1/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

let filePath = Bundle.main.path(forResource: "numbers", ofType: "txt")
assert(filePath != nil)

let fileContent = try! String(contentsOfFile: filePath!)
var testNumbers = fileContent.characters.split(separator: ",").map{ String($0) }.map{ Int($0)! }

//let a = [1,2,3,4,5,6,7,8,9]
//var h = Heap(type: .min, datas: a)
//h.insert(100)

let s = Sorting()

let startTime = Int(Date().timeIntervalSince1970 * 1000)
let sortingRet = s.heapSort(items: testNumbers)
let endTime = Int(Date().timeIntervalSince1970 * 1000)
print("algorithm consumed \(endTime - startTime) milliseconds")


//let sortedArray = testNumbers.sorted { $0 < $1 }
//assert(findingRet == sortedArray[sortedArray.endIndex - 100])

assert(Sorting.isSorted(items: sortingRet))
