import Foundation

struct GraphVertex<T: Equatable> {
    let value: T

    init(value: T) {
        self.value = value
    }
}

struct GraphSuperVertex<T: Equatable> {
    let vertexes: [T]
    
    init(vertexes: [T]) {
        self.vertexes = vertexes
    }

    func containsVertex(value: T) -> Bool {
        return self.vertexes.contains { $0 == value }
    }
}

struct GraphEdge<T: Equatable> {
    let vertex1: GraphVertex<T>
    let vertex2: GraphVertex<T>

    init(v1: GraphVertex<T>, v2: GraphVertex<T>) {
        self.vertex1 = v1
        self.vertex2 = v2
    }
}

class Graph {
    private(set) var vNum: UInt = 0
    private(set) var eNum: UInt = 0
    fileprivate var adjDict = [String: [String]]()

    func connectVertexes(v1: String, v2: String) {
        if var vertexes = self.adjDict[v1] {
            vertexes.append(v2)
            self.adjDict[v1] = vertexes
        } else {
            self.vNum += 1
            self.adjDict[v1] = [v2]
        }

        self.eNum += 1
    }

    func minimumCut() -> UInt {
        var currentAdj = self.adjDict
        var currentEdgeNumber = self.eNum
        
        func contract() -> UInt {
            if currentAdj.count <= 2 {
                return currentEdgeNumber
            }

            var edgeIndex = Int((arc4random() % UInt32(currentEdgeNumber)) + 1)
            var adjV: String?
            var selectedV: String?
            for (v, adjVs) in currentAdj {
                if edgeIndex > adjVs.count {
                    edgeIndex -= adjVs.count
                    continue
                }

                selectedV = v
                adjV = adjVs[edgeIndex - 1]
                break
            }

            guard let endVer = adjV,
                  let selectedVer = selectedV,
                  let adjVsOfEndVer = currentAdj.removeValue(forKey: endVer),
                  let adjVsOfSelectedVer = currentAdj[selectedVer] else {
                return 0
            }

            let combinedEdges = (adjVsOfEndVer + adjVsOfSelectedVer).filter {
                $0 != endVer && $0 != selectedVer
            }

            var nextGraph = [String: [String]]()
            var nextEdgeNumber: UInt = 0
            for (v, adjVs) in currentAdj {
                if v == selectedVer {
                    continue
                }

                let modifiedAdjVs = adjVs.map {
                    return $0 == endVer ? selectedVer : $0
                }

                nextGraph[v] = modifiedAdjVs
                nextEdgeNumber += UInt(modifiedAdjVs.count)
            }

            nextGraph[selectedVer] = combinedEdges
            nextEdgeNumber += UInt(combinedEdges.count)
            
            currentAdj = nextGraph
            currentEdgeNumber = nextEdgeNumber
            
            return contract()
        }
        
        return contract() / 2
    }
}

extension Graph: CustomStringConvertible {
    var description: String {
        var s = "\(self.vNum) vertices, \(self.eNum) edges\n"

        let vertexes = self.adjDict.keys.sorted { $0 < $1 }
        for v in vertexes {
            s += "\(v): "
            let adjVertexes = self.adjDict[v]!
            for adjV in adjVertexes {
                s += "\(adjV) "
            }

            s += "\n"
        }
        
        return s
    }
}
