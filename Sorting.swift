import Foundation

struct Sorting {
    static func isSorted<T: Comparable>(items: [T]) -> Bool {
        let sortedItems = items.sorted { (item1, item2) -> Bool in
            return item1 < item2
        }
        
        return sortedItems == items
    }
    
    func selectionSort<T: Comparable>(items: [T]) -> [T] {
        if items.count <= 1 {
            return items
        }
        
        var tempArray = items
        for index in 0..<tempArray.count {
            if index + 1 >= tempArray.count {
                break
            }
            
            var min = index
            for innerIndex in (index+1)..<tempArray.count {
                if tempArray[innerIndex] < tempArray[min] {
                    min = innerIndex
                }
            }
            
            if index == min {
                continue
            }
            
            swap(&(tempArray[index]), &(tempArray[min]))
        }
        
        return tempArray
    }
    
    func insertionSort<T: Comparable>(items: [T]) -> [T] {
        if items.count <= 1 {
            return items
        }
        
        var tempArray = items
        for index in 1..<tempArray.count {
            let reversedIndex = (1...index).reversed()
            for innerIndex in reversedIndex {
                if tempArray[innerIndex] < tempArray[innerIndex-1] {
                    swap(&(tempArray[innerIndex]), &(tempArray[innerIndex-1]))
                }
            }
        }
        
        return tempArray
    }

    func shellSort<T: Comparable>(items: [T]) -> [T] {
        if items.count <= 1 {
            return items
        }

        var h = 1
        while h < (items.count / 3) {
            h = 3 * h + 1
        }

        var tempArray = items
        while h >= 1 {
            for index in h..<tempArray.count {
                let strideSteps = stride(from: index, through: h, by: -h)
                for innerIndex in strideSteps {
                    if tempArray[innerIndex] < tempArray[innerIndex-h] {
                        swap(&(tempArray[innerIndex]), &(tempArray[innerIndex-h]))
                    }
                }
            }

            h = h / 3
        }


        return tempArray
    }
    
    func mergeSort<T: Comparable>(items: inout [T]) {
        func mergeProcedure(l: Int, m: Int, r: Int) {
            if items[m] <= items[m+1] {
                return
            }
            
            var leftIndex = l
            var rightIndex = m + 1
            
            let subItems = items[l..<r+1]
            
            func setLeftItemProcedure(_ i: Int) {
                items[i] = subItems[leftIndex]
                leftIndex += 1
            }
            
            func setRightItemProcedure(_ i: Int) {
                items[i] = subItems[rightIndex]
                rightIndex += 1
            }
            
            for i in l...r {
                if leftIndex > m {
                    setRightItemProcedure(i)
                    continue
                }
                
                if rightIndex > r {
                    setLeftItemProcedure(i)
                    continue
                }
                
                if subItems[leftIndex] <= subItems[rightIndex] {
                    setLeftItemProcedure(i)
                } else {
                    setRightItemProcedure(i)
                }
            }
        }
        
        func sort(lo: Int, hi: Int) {
            if hi <= lo {
                return
            }
            
            let mid = lo + (hi - lo) / 2
            sort(lo: lo, hi: mid)
            sort(lo: mid+1, hi: hi)
            mergeProcedure(l: lo, m: mid, r: hi)
        }
        
        sort(lo: 0, hi: items.endIndex - 1)
    }
    
    func quickSort<T: Comparable>(items: [T]) -> [T] {
        if items.count <= 1 {
            return items
        }
        
        typealias PartitionRet = (T, [T], [T])
        
        func partition(items: [T]) -> PartitionRet {
            var partitionItems = items
            
//            let pivotIndex = Int(arc4random() % UInt32((items.count)))
//            if pivotIndex != 0 {
//                swap(&(partitionItems[0]), &(partitionItems[pivotIndex]))
//            }
            
            var i = partitionItems.startIndex + 1
            
            let number1 = partitionItems[0]
            let number2 = partitionItems[partitionItems.midIndex]
            let number3 = partitionItems[partitionItems.endIndex - 1]
            let middleNumber = [number1, number2, number3].sorted()[1]
            let middleNumberIndex = partitionItems.index(of: middleNumber)!
            if middleNumberIndex != partitionItems.startIndex {
                swap(&(partitionItems[partitionItems.startIndex]), &(partitionItems[middleNumberIndex]))
            }
            
            let pivotEle = partitionItems[partitionItems.startIndex]
            
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
        
        let partitionRet = partition(items: items)
        let leftSortedItems = quickSort(items: partitionRet.1)
        let rightSortedItems = quickSort(items: partitionRet.2)
        
        var ret = [T]()
        ret += leftSortedItems
        ret.append(partitionRet.0)
        ret += rightSortedItems
        
        return ret
    }

    func heapSort<T: HeapItemProtocol>(items: [T]) -> [T] {
        var ret = [T]()

        var heap = Heap(type: .min, datas: items)
        while let nextItem = heap.extract() {
            ret.append(nextItem)
        }

        return ret
    }

    // each element in items and key must be positive
    func countingSort(items: [Int], key: Int32) -> [Int] {
        assert(key > 0)

        var ret = [Int](repeating: 0, count: items.count)
        
        var auxArray = [Int](repeating: 0, count: Int(key))
        auxArray.append(0)

        for i in items {
            auxArray[i] += 1
        }

        for i in 0..<auxArray.count {
            if i == 0 {
                continue
            }

            auxArray[i] += auxArray[i-1]
        }

        for i in items.reversed() {
            ret[auxArray[i] - 1] = i
            auxArray[i] -= 1
        }
        
        
        return ret
    }

    // MARK: Private
}
