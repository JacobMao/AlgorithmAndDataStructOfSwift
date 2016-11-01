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

    // MARK: Private
}

let s = Sorting()

let a = [3,6,8,4,24,6,8,7,4,3,8,7]
let b = s.shellSort(items: a)

print(b)
