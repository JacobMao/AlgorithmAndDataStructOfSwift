import Foundation

struct Geometry {
    /* I first calculate the area of each rectangle and then calculate the overlapping area between the two rectangles (if there is one!).
       At the end, we sum up the individual areas and subtract the overlapping area
    */
    func computeArea(_ A: Int, _ B: Int, _ C: Int, _ D: Int, _ E: Int, _ F: Int, _ G: Int, _ H: Int) -> Int {
        let areaOfFirst = self.calculateAreaOf2D(leftX: A, leftY: B, rightX: C, rightY: D)
        let areaOfSecond = self.calculateAreaOf2D(leftX: E, leftY: F, rightX: G, rightY: H)
        let areaOfOverlap = self.calculateOverlapArea(A, B, C, D, E, F, G, H)

        return areaOfFirst + areaOfSecond - areaOfOverlap
    }

    private func calculateAreaOf2D(leftX: Int, leftY: Int, rightX: Int, rightY: Int) -> Int {
        return (rightX - leftX) * (rightY - leftY)
    }

    private func calculateOverlapArea(_ A: Int, _ B: Int, _ C: Int, _ D: Int, _ E: Int, _ F: Int, _ G: Int, _ H: Int) -> Int {
        let maxLeft = max(A, E)
        let minRight = min(C, G)
        let maxBottom = max(B, F)
        let minTop = min(D, H)

        var areaOfOverlap = 0
        let checkingConditions = (maxLeft < minRight) && (maxBottom < minTop)
        if checkingConditions {
            areaOfOverlap = (minRight - maxLeft) * (minTop - maxBottom)
        }

        return areaOfOverlap
    }
}
