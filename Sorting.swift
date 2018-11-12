import Foundation

struct Sorting {
    static func isSorted<T: Comparable>(items: [T]) -> Bool {
        let sortedItems = items.sorted { (item1, item2) -> Bool in
            return item1 < item2
        }
        
        return sortedItems == items
    }
    
    /*
     选择排序
     所有情况都是O(n^2)

     这是一个不稳定的排序算法
     */
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
    
    /*
     插入排序
     best case: O(n)，所有数据已经是升序的
     worst case: O(n^2)，所有数据都是逆序的
     average case: O(n^2)

     这是一个稳定的排序算法
     */
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

    /*
     shell排序
     average case: O(n^1.25)

     这是一个不稳定的排序算法
     */
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
    
    /*
     归并排序
     average case: O(nlognn)

     这是一个稳定的排序算法
     */
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

    // MARK: Private
}
