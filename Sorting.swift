import Foundation

struct Sorting {
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
}

let s = Sorting()

let a = [3,6,8,4,24,6,8,7,4,3,8,7]
let b = s.insertionSort(items: a)

print(b)
