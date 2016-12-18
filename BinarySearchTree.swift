import Foundation

private enum ThroughDownType {
        case min
        case max
}

class BinarySearchTree<T: Comparable>: ExpressibleByArrayLiteral {
    typealias Node = TreeNode<T>
    
    private(set) var root: Node?

    var inorder: [T] {
        return self.generateInorderWalk(node: self.root)
    }

    var minValue: T? {
        return self.throughDown(root: self.root, type: .min)
    }
    
    var maxValue: T? {
        return self.throughDown(root: self.root, type: .max)
    }

    required init(arrayLiteral: T...) {
        for i in arrayLiteral {
            self.insert(i)
        }
    }

    func insert(_ value: T) {
        let newNode = Node(value: value)

        var selectedNode: Node? = nil
        var currentNode = self.root
        while let currentingNode = currentNode {
            selectedNode = currentNode
            
            if newNode < currentingNode {
                currentNode = currentingNode.leftChild
            } else {
                currentNode = currentingNode.rightChild
            }
        }

        guard let selectingNode = selectedNode else {
            self.root = newNode
            return
        }

        newNode.parent = selectingNode

        if newNode < selectingNode {
            selectingNode.leftChild = newNode
        } else {
            selectingNode.rightChild = newNode
        }
    }

    func contains(_ value: T) -> Bool {
        var selectingNode = self.root
        var ret = false
        while let selectedNode = selectingNode {
            if selectedNode.value == value {
                ret = true
                break
            }

            if selectedNode < value {
                selectingNode = selectedNode.rightChild
            } else {
                selectingNode = selectedNode.leftChild
            }
        }

        return ret
    }

    func successor(after value: T) -> T? {
        guard let node = self.search(value) else {
            return nil
        }

        if node.rightChild != nil {
            return self.throughDown(root: node, type: .min)
        }

        return nil
    }
    
    private func generateInorderWalk(node: Node?) -> [T] {
        guard let currentNode = node else {
            return []
        }

        let leftValues = self.generateInorderWalk(node: currentNode.leftChild)
        let rightValues = self.generateInorderWalk(node: currentNode.rightChild)

        return leftValues + [currentNode.value] + rightValues
    }

    private func throughDown(root: Node?, type: ThroughDownType) -> T? {
        var currentNode = root
        switch type {
        case .min:
            while currentNode?.leftChild != nil {
                currentNode = currentNode?.leftChild
            }
        case .max:
            while currentNode?.rightChild != nil {
                currentNode = currentNode?.rightChild
            }
        }

        return currentNode?.value
    }

    private func search(_ value: T) -> Node? {
        var ret = self.root
        while let nodeValue = ret?.value,
              nodeValue != value {
            if value < nodeValue {
                ret = ret?.leftChild
            } else {
                ret = ret?.rightChild
            }
        }

        return ret
    }
}
