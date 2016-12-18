import Foundation

enum HeapType {
    case max
    case min
}

protocol HeapItemProtocol : Comparable {
    associatedtype KeyType: Equatable

    var key : KeyType { get }
}

struct Heap<T: HeapItemProtocol> {
    private typealias CmpFunc = (T, T) -> Bool
    
    private var nodes: [T]
    private let nodeCmp: CmpFunc 

    private var lastNode: Int {
        return self.size / 2 - 1
    }
    
    var size: Int {
        return self.nodes.count
    }
    
    init(type: HeapType) {
        self.init(type: type, datas: [T]())
    }

    init(type: HeapType, datas: [T]) {
        switch (type) {
        case .min:
            self.nodeCmp = {
                $0 < $1
            }
        case .max:
            self.nodeCmp = {
                $0 > $1
            }
        }
        
        self.nodes = datas

        if datas.count > 1 {
            for i in stride(from: self.lastNode, through: 0, by: -1) {
                self.heapify(root: i)
            }
        }
    }

    mutating func insert(_ data: T) {
        self.nodes.append(data)
        if self.nodes.count <= 1 {
            return
        }

        self.swim(node: self.nodes.endIndex - 1)
    }

    mutating func extract() -> T? {
        if self.nodes.isEmpty {
            return nil
        }

        if self.nodes.count == 1 {
            return self.nodes.removeFirst()
        }

        swap(&(self.nodes[self.nodes.startIndex]), &(self.nodes[self.nodes.endIndex - 1]))
        
        let rootItem = self.nodes.removeLast()

        self.heapify(root: self.nodes.startIndex)
        
        return rootItem        
    }

    mutating func remove(nodeKey: T.KeyType) -> T?{
        if self.nodes.isEmpty {
            return nil
        }

        let nodeIndex = self.indexOf(nodeKey: nodeKey)
        if nodeIndex == -1 {
            return nil
        }

        if nodeIndex != self.nodes.endIndex - 1 {
            swap(&(self.nodes[nodeIndex]), &(self.nodes[self.nodes.endIndex - 1]))
        }
        
        let removedItem  = self.nodes.removeLast()

        self.heapify(root: nodeIndex)

        return removedItem
    }

    mutating func indexOf(nodeKey: T.KeyType) -> Int {
        var ret = -1

        for (i, n) in self.nodes.enumerated() {
            if n.key != nodeKey {
                continue
            }

            ret = i
            break
        }
        
        return ret
    }

    private func parent(nodeIndex: Int) -> Int {
        return max((nodeIndex - 1) / 2, 0)
    }

    private func leftChild(nodeIndex: Int) -> Int {
        return nodeIndex * 2 + 1
    }

    private func rightChild(nodeIndex: Int) -> Int {
        return nodeIndex * 2 + 2
    }

    private mutating func heapify(root: Int) {
        let leftIndex = self.leftChild(nodeIndex: root)
        let rightIndex = self.rightChild(nodeIndex: root)
        var largestNodeIndex = root

        if leftIndex < self.size && self.nodeCmp(self.nodes[leftIndex], self.nodes[largestNodeIndex]) {
            largestNodeIndex = leftIndex
        }

        if rightIndex < self.size && self.nodeCmp(self.nodes[rightIndex], self.nodes[largestNodeIndex]) {
            largestNodeIndex = rightIndex
        }

        if largestNodeIndex == root {
            return
        }

        swap(&(self.nodes[root]), &(self.nodes[largestNodeIndex]))

        self.heapify(root: largestNodeIndex)
    }

    private mutating func swim(node: Int) {
        if node <= 0 {
            return
        }

        let parentIndex = self.parent(nodeIndex: node)
        if !self.nodeCmp(self.nodes[node], self.nodes[parentIndex]) {
            return
        }

        swap(&(self.nodes[parentIndex]), &(self.nodes[node]))

        self.swim(node: parentIndex)
    }
}
