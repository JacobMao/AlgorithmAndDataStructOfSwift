import Foundation

// For leetcode.com


//  Definition for a binary tree node.
public class LeetTreeNode {
    public var val: Int
    public var left: LeetTreeNode?
    public var right: LeetTreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}
 

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

    // https://leetcode.com/problems/hamming-distance/
    static func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var dist = 0
        var val = x ^ y

        while val != 0 {
            dist += 1
            val &= val - 1
        }

        return dist
    }

    // https://leetcode.com/problems/assign-cookies/
    static func assignCookies(_ g: [Int], _ s: [Int]) -> Int {
        let sortedG = g.sorted()
        let sortedS = s.sorted()

        var gIndex = sortedG.startIndex
        var sIndex = sortedS.startIndex
        while gIndex < sortedG.endIndex && sIndex < sortedS.endIndex {
            if sortedG[gIndex] <= sortedS[sIndex] {
                gIndex += 1
            }

            sIndex += 1
        }

        return gIndex
    }

    // https://leetcode.com/problems/minimum-moves-to-equal-array-elements/
    static func minMoves(_ nums: [Int]) -> Int {
        let sum = nums.reduce(0){ $0 + $1 }

        return sum - nums.min()! * nums.count
    }

    // https://leetcode.com/problems/ransom-note/
    static func ransomNote(_ ransomNote: String, _ magazine: String) -> Bool {
        var countDict = [Character : Int]()
        for c in magazine.characters {
            if let currentCount = countDict[c] {
                countDict[c] = currentCount + 1
            } else {
                countDict[c] = 1
            }
        }

        for c in ransomNote.characters {
            guard let currentCount = countDict[c],
                  currentCount > 0 else {
                return false
            }

            countDict[c] = currentCount - 1
        }

        return true
    }

    // https://leetcode.com/problems/sum-of-left-leaves/
    static func sumOfLeftLeaves(_ root: LeetTreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        func recurSum(_ root: LeetTreeNode?, _ isLeft: Bool) -> Int {
            let leftNode = root?.left
            let rightNode = root?.right
            if leftNode == nil && rightNode == nil {
                if isLeft {
                    return root?.val ?? 0
                } else {
                    return 0
                }
            }

            let leftSum = recurSum(root?.left, true)
            let rightSum = recurSum(root?.right, false)

            return leftSum + rightSum
        }

        return recurSum(root, false)
    }

    // https://leetcode.com/problems/longest-palindrome/
    static func longestPalindrome(_ s: String) -> Int {
        var characterSet = Set<Character>()
        var count = 0
        s.characters.forEach {
            if characterSet.contains($0) {
                characterSet.remove($0)
                count += 1
            } else {
                characterSet.insert($0)
            }
        }
        
        count *= 2
        
        return characterSet.isEmpty ? count : count + 1
    }
    
    // https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/
    static func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        var myNums = nums
        
        let numRange = 0..<myNums.count
        for i in numRange {
            let value = abs(myNums[i]) - 1
            if myNums[value] > 0 {
                myNums[value] = -myNums[value]
            }
        }
        
        var ret = [Int]()
        for i in numRange {
            if myNums[i] > 0 {
                ret.append(i + 1)
            }
        }
        
        return ret
    }
    
    // https://leetcode.com/problems/binary-watch/
    static func readBinaryWatch(_ num: Int) -> [String] {
        if num <= 0 {
            return ["0:00"]
        }
        
        var ret = [String]()
        
        for h in 0..<12 {
            let tempValue = h << 6
            for m in 0..<60 {
                var combinedValue = tempValue + m
                var oneCount = 0
                while combinedValue != 0 {
                    if combinedValue & 1 == 1 {
                        oneCount += 1
                    }
                    
                    combinedValue = combinedValue >> 1
                }
                
                if oneCount != num {
                    continue
                }
                
                let timeStr = "\(h)\(m < 10 ? ":0" : ":")\(m)"
                ret.append(timeStr)
            }
        }
        
        return ret
    }
    
    // https://leetcode.com/problems/number-of-boomerangs/
    static func numberOfBoomerangs(_ points: [[Int]]) -> Int {
        if points.count < 3 {
            return 0
        }
        
        return 0
    }
}
