//
//  main.swift
//  AlgorithmAndDataStructOfSwift
//
//  Created by Jacob Mao on 11/1/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

//let f = Finding()

let filePath = Bundle.main.path(forResource: "MinCut", ofType: "txt")
assert(filePath != nil)

let g = Graph()

let fileContent = try! String(contentsOfFile: filePath!)
let datas = fileContent.components(separatedBy: .newlines).filter { $0.characters.count > 0}
for data in datas {
    let vertexInfo = data.components(separatedBy: "\t").filter{ $0.characters.count > 0 }
    let v = vertexInfo[vertexInfo.startIndex]
    let adjVertices = vertexInfo[(vertexInfo.startIndex + 1)..<vertexInfo.endIndex]
    for adjV in adjVertices {
        g.connectVertexes(v1: v, v2: adjV)
    }
}

var aaa = [UInt]()

for _ in 0..<50 {
    aaa.append(g.minimumCut())
}

print(aaa)
print(aaa.min()!)

//var testNumbers = fileContent.characters.split(separator: "\r\n").map{ String($0) }.map{ Int($0)! }

// let f = Finding()

// let startTime = Int(Date().timeIntervalSince1970 * 1000)
// let findingPos = UInt(testNumbers.count - 100)
// let findingRet = f.rSelect(items: testNumbers, at: findingPos)
// let endTime = Int(Date().timeIntervalSince1970 * 1000)
// print("algorithm consumed \(endTime - startTime) milliseconds")


// let sortedArray = testNumbers.sorted { $0 < $1 }
// assert(findingRet == sortedArray[sortedArray.endIndex - 100])

//assert(Sorting.isSorted(items: sortingRet))
