import Foundation

struct Geometry {
    /* I first calculate the area of each rectangle and then calculate the overlapping area between the two rectangles (if there is one!).
       At the end, we sum up the individual areas and subtract the overlapping area
    */
    func computeArea(_ A: Int, _ B: Int, _ C: Int, _ D: Int, _ E: Int, _ F: Int, _ G: Int, _ H: Int) -> Int {
        let maxLeft = max(A, E)
        let minRight = min(C, G)
        let maxBottom = max(B, F)
        let minTop = min(D, H)

        var areaOfOverlap = 0
        let checkingConditions = (maxLeft < minRight) && (maxBottom < minTop)
        if checkingConditions {
            areaOfOverlap = (minRight - maxLeft) * (minTop - maxBottom)
        }

        let areaOfFirst = (C - A) * (D - B)
        let areaOfSecond = (G - E) * (H - F)
        let ret = areaOfFirst + areaOfSecond - areaOfOverlap
        if ret < 0 {
            return 0
        }
        
        return ret
    }
}
