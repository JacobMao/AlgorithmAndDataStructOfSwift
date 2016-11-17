//
//  ArrayExtension.swift
//  AlgorithmAndDataStructOfSwift
//
//  Created by Jacob Mao on 11/11/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation

extension Array {
    var midIndex: Int {
        if self.count <= 1 {
            return 0
        }
        
        return Int(floor(Double(self.count - 1) / 2.0))
    }
}

extension ArraySlice {
    var midIndex: Int {
        return self.startIndex + Int(ceil(Double(self.endIndex - self.startIndex) / 2.0))
    }
}
