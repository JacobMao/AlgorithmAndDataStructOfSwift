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
            
            var i = partitionItems.startIndex + 1
            var j = partitionItems.endIndex - 1
            let pivotEle = partitionItems[partitionItems.startIndex]
            while true {
                while partitionItems[i] < pivotEle {
                    i += 1
                    
                    if i == partitionItems.endIndex {
                        break
                    }
                }
                
                while partitionItems[j] >= pivotEle {
                    j -= 1
                    
                    if j == partitionItems.startIndex {
                        break
                    }
                }
                
                if i >= j {
                    break
                }
                
                swap(&(partitionItems[i]), &(partitionItems[j]))
            }
            
            if j != partitionItems.startIndex {
                swap(&(partitionItems[partitionItems.startIndex]), &(partitionItems[j]))
            }
            
            let leftItems = partitionItems[partitionItems.startIndex..<j]
            let rightItems = partitionItems[(j+1)..<partitionItems.endIndex]
            
            return (partitionItems[j], [T](leftItems), [T](rightItems))
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

    // MARK: Private
}
