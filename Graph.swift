import Foundation

struct GraphVertex<T: Equatable> {
    let value: T
    private(set) var dTimestamp = 0
    private(set) var fTimestamp = 0

    init(value: T) {
        self.value = value
    }

    mutating func updateDTS(_ dts: Int) {
        self.dTimestamp = dts
    }

    mutating func updateFTS(_ fts: Int) {
        self.fTimestamp = fts
    }
}

class Graph<T: Hashable & Comparable> {
    typealias AdjDict = [T: [T]]
    typealias VertexDict = [T : GraphVertex<T>]
    
    private(set) var vNum: UInt = 0
    private(set) var eNum: UInt = 0
    fileprivate var myAdjDict = AdjDict()
    private var vertices = VertexDict()

    func connectVertexes(v1: T, v2: T) {
        if self.vertices[v1] == nil {
            self.vertices[v1] = GraphVertex(value: v1)
            self.vNum += 1
        }

        if self.vertices[v2] == nil {
            self.vertices[v2] = GraphVertex(value: v2)
            self.vNum += 1
        }

        self.updateEdge(v1: v1, v2: v2, to: &self.myAdjDict)

        self.eNum += 1
    }

    func minimumCut() -> UInt {
        var currentAdj = self.myAdjDict
        var currentEdgeNumber = self.eNum
        
        func contract() -> UInt {
            if currentAdj.count <= 2 {
                return currentEdgeNumber
            }

            var edgeIndex = Int((arc4random() % UInt32(currentEdgeNumber)) + 1)
            var adjV: T?
            var selectedV: T?
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

            var nextGraph = [T: [T]]()
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

    func scc() -> [[T]]{
        var ts = 0
        
        for node in self.vertices.keys {
            if self.isExplored(node: node) {
                continue
            }

            
            let _ = self.dfsVisit(nodeValue: node,
                                     adjDict: self.myAdjDict,
                                     currentTimestamp: &ts)
        }

        var reversedEdges = AdjDict()
        for (v, adjVs) in self.myAdjDict {
            for headNode in adjVs {
                self.updateEdge(v1: headNode, v2: v, to: &reversedEdges)
            }
        }

        let orderedNodes = self.vertices.values.sorted { $0.fTimestamp > $1.fTimestamp }
        for k in self.vertices.keys {
            self.vertices[k]!.updateDTS(0)
            self.vertices[k]!.updateFTS(0)
        }

        var ret = [[T]]()
        ts = 0
        for node in orderedNodes {
            if self.isExplored(node: node.value) {
                continue
            }
            
            
            let path = self.dfsVisit(nodeValue: node.value,
                                     adjDict: reversedEdges,
                                     currentTimestamp: &ts)

            ret.append(path)
        }

        return ret
    }

    private func updateEdge(v1: T, v2: T, to adjDict: inout AdjDict) {
        if adjDict[v1] != nil {
            adjDict[v1]!.append(v2)
        } else {
            adjDict[v1] = [v2]
        }
    }

    private func dfsVisit(nodeValue: T,
                          adjDict: AdjDict,
                          currentTimestamp: inout Int) -> [T] {
        assert(self.vertices[nodeValue] != nil)

        var ret = [T]()
        
        var s = Stack<T>()
        s.push(nodeValue)
        while let currentNode = s.top() {
            if !self.isExplored(node: currentNode) {
                currentTimestamp += 1
                self.vertices[currentNode]!.updateDTS(currentTimestamp)
            }

            guard let edges = adjDict[currentNode] else {
                currentTimestamp += 1
                self.vertices[currentNode]!.updateFTS(currentTimestamp)

                let _ = s.pop()
                ret.append(currentNode)
                
                continue
            }

            var isFinished = true
            for headNode in edges {
                if self.isExplored(node: headNode) {
                    continue
                }

                s.push(headNode)
                isFinished = false
                break
            }

            if isFinished {
                currentTimestamp += 1
                self.vertices[currentNode]!.updateFTS(currentTimestamp)

                let _ = s.pop()
                ret.append(currentNode)
            }
        }

        return ret.reversed()
    }

    private func isExplored(node: T) -> Bool {
        guard let v = self.vertices[node] else {
            return false
        }

        return v.dTimestamp > 0
    }
}

extension Graph: CustomStringConvertible {
    var description: String {
        var s = "\(self.vNum) vertices, \(self.eNum) edges\n"

        let vertexes = self.myAdjDict.keys.sorted { $0 < $1 }
        for v in vertexes {
            s += "\(v): "
            let adjVertexes = self.myAdjDict[v]!
            for adjV in adjVertexes {
                s += "\(adjV) "
            }

            s += "\n"
        }
        
        return s
    }
}
