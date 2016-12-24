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
        return self.throughDown(root: self.root, type: .min)?.value
    }
    
    var maxValue: T? {
        return self.throughDown(root: self.root, type: .max)?.value
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
        
    func remove(_ value: T) {
        guard let targetNode = self.search(value) else {
            return
        }
            
        if targetNode.leftChild == nil {
            self.transplant(source: targetNode.rightChild, dest: targetNode)
            return
        }
        
        if targetNode.rightChild == nil {
            self.transplant(source: targetNode.leftChild, dest: targetNode)
            return
        }
        
        guard let successorN = self.successorNode(after: targetNode) else {
            return
        }
        
        guard let successorNP = successorN.parent else {
            return
        }
        
        if successorNP != targetNode {
            self.transplant(source: successorN.rightChild, dest: successorN)
            successorN.rightChild = targetNode.rightChild
            targetNode.rightChild?.parent = successorN
        }
        
        self.transplant(source: successorN, dest: targetNode)
        successorN.leftChild = targetNode.leftChild
        successorN.leftChild?.parent = successorN
    }

    func contains(_ value: T) -> Bool {
        return self.search(value) != nil
    }

    func successor(after value: T) -> T? {
        guard let node = self.search(value) else {
            return nil
        }

        return self.successorNode(after: node)?.value
    }
        
    private func generateInorderWalk(node: Node?) -> [T] {
        var ret = [T]()
        var currentNode = node
        var s = Stack<Node>()
        while !s.isEmpty || currentNode != nil {
            if currentNode != nil {
                s.push(currentNode!)
                currentNode = currentNode?.leftChild
            } else {
                guard let popNode = s.pop() else {
                    continue
                }
                
                ret.append(popNode.value)
                
                currentNode = popNode.rightChild
            }
        }
        
        return ret
    }

    private func throughDown(root: Node?, type: ThroughDownType) -> Node? {
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

        return currentNode
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
        
    private func transplant(source: Node?, dest: Node?) {
        defer {
            if source != nil {
                source!.parent = dest?.parent
            }
        }
        
        guard let destNode = dest else {
            return
        }
        
        guard let destP = destNode.parent else {
            self.root = source
            return
        }
        
        if let leftNode = destP.leftChild, leftNode == destNode {
            destP.leftChild = source
            return
        }
        
        destP.rightChild = source
    }
        
    private func successorNode(after node: Node?) -> Node? {
        if node?.rightChild != nil {
            return self.throughDown(root: node, type: .min)
        }
            
        var currentNode: Node? = node
        var parentNode = node?.parent
        while let pNode = parentNode,
              let cNode = currentNode,
              let rNode = pNode.rightChild,
              cNode == rNode {
                currentNode = pNode
                parentNode = pNode.parent
            }

        return parentNode
    }
}
