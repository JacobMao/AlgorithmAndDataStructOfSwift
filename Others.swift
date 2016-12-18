import Foundation

// For leetcode.com

struct OtherProblems {
    static func fizzBuzz(_ n: Int) -> [String] {
        var ret = [String]()
        
        for i in 1...n {
            if i % 15 == 0 {
                ret.append("FizzBuzz")
                continue
            }

            if i % 3 == 0 {
                ret.append("Fizz")
                continue
            }

            if i % 5 == 0 {
                ret.append("Buzz")
                continue
            }

            ret.append(String(i))
        }

        return ret
    }

    static func reverseString(_ s: String) -> String {
        var ret = s

        if ret.characters.count <= 1 {
            return ret
        }
        
        var leftIndex = ret.startIndex
        var rightIndex = ret.index(before: ret.endIndex)
        while rightIndex > leftIndex {
            let leftStr = String(ret[leftIndex])
            let rightStr = String(ret[rightIndex])
            ret.replaceSubrange(leftIndex...leftIndex, with: rightStr)
            ret.replaceSubrange(rightIndex...rightIndex, with: leftStr)

            leftIndex = ret.index(after: leftIndex)
            rightIndex = ret.index(before: rightIndex)
        }

        return ret
    }

    static func islandPerimeter(_ grid: [[Int]]) -> Int {
        var islands = 0
        var neighbours = 0

        let rowSize = grid.count
        for i in 0..<rowSize {
            let colSize = grid[i].count
            for j in 0..<colSize {
                if grid[i][j] == 0 {
                    continue
                }

                islands += 1

                if i < rowSize - 1 {
                    if grid[i+1][j] == 1 {
                        neighbours += 1
                    }
                }

                if j < colSize - 1 {
                    if grid[i][j+1] == 1 {
                        neighbours += 1
                    }
                }
            }
        }

        return 4 * islands - 2 * neighbours
    }

    static func singleNumber(_ nums: [Int]) -> Int {
        var ret: Int = 0
        for i in nums {
            ret = ret ^ i
        }

        return ret
    }

    static func getSum(_ a: Int, _ b: Int) -> Int {
        var sum = a
        var carry = b
        while carry != 0 {
            let tmp = sum

            sum = tmp ^ carry
            carry = (tmp & carry) << 1
        }

        return sum
    }

    // https://leetcode.com/problems/intersection-of-two-arrays/
    static func intersectionArrays(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let s1 = Set(nums1)
        let s2 = Set(nums2)

        return Array(s1.intersection(s2))
    }

    // https://leetcode.com/problems/first-unique-character-in-a-string/
    static func firstUniqChar(_ s: String) -> Int {
        var countingDict = [Character : Int]()
        for c in s.characters {
            if let currentCount = countingDict[c] {
                countingDict[c] = currentCount + 1
            } else {
                countingDict[c] = 1
            }
        }

        var retIndex = 0
        let chaSize = s.characters.count
        for c in s.characters {
            if countingDict[c]! == 1 {
                return retIndex
            }

            retIndex += 1
        }

        return -1
    }
}
