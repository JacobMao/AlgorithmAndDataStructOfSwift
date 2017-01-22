struct TreeForInterview {	
	// 98. Validate Binary Search Tree
	// https://leetcode.com/problems/validate-binary-search-tree/
	static func isValidBST(_ root: TreeNode?) -> Bool {
		func validBST(_ root: TreeNode?, min: Int, max: Int) -> Bool {
			guard let rootNode = root else {
				return true
			}
			
			if rootNode.val < min || rootNode.val >= max {
				return false
			}
			
			return validBST(rootNode.left, min: min, max: rootNode.val)
				&& validBST(rootNode.right, min: rootNode.val + 1, max: max)
		}
		
		return validBST(root, min: Int.min, max: Int.max)
	}
	
	// 100. Same Tree
	// https://leetcode.com/problems/same-tree/
	static func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
		guard let pNode = p, let qNode = q else {
			if p == nil && q == nil {
				return true
			} else {
				return false
			}
		}

		let resultOfComparingValue = pNode.val == qNode.val
		let resultOfComparingLeftNode = self.isSameTree(pNode.left, qNode.left)
		let resultOfComparingRightNode = self.isSameTree(pNode.right, qNode.right)

		return resultOfComparingValue && resultOfComparingLeftNode && resultOfComparingRightNode
	}
	
	// 101. Symmetric Tree
	// https://leetcode.com/problems/symmetric-tree/
	static func isSymmetric(root: TreeNode?) -> Bool {
		func compareSubTrees(leftSubTree: TreeNode?, rightSubTree: TreeNode?) -> Bool {
			guard let leftRoot = leftSubTree, let rightRoot = rightSubTree else {
				return leftSubTree == nil && rightSubTree == nil
			}
	
			return leftRoot.val == rightRoot.val
			&& compareSubTrees(leftSubTree: leftRoot.left, rightSubTree: rightRoot.right)
			&& compareSubTrees(leftSubTree: leftRoot.right, rightSubTree: rightRoot.left)
		}
	
		return compareSubTrees(leftSubTree: root?.left, rightSubTree: root?.right)
	}
	
	// 102. Binary Tree Level Order Traversal
	// https://leetcode.com/problems/binary-tree-level-order-traversal/
	static func levelOrder(_ root: TreeNode?) -> [[Int]] {
		guard let rootNode = root else {
			return []
		}

		var ret: [[Int]] = []

		var nodes: [TreeNode?] = []
		nodes.append(rootNode)
		nodes.append(nil)

		var values: [Int] = []
		while !nodes.isEmpty {
			guard let currentNode = nodes.removeFirst() else {
				ret.append(values)

				if !nodes.isEmpty {
					values.removeAll()
					nodes.append(nil)
				}

				continue
			}

			values.append(currentNode.val)
			if currentNode.left != nil {
				nodes.append(currentNode.left)
			}
			if currentNode.right != nil {
				nodes.append(currentNode.right)
			}
		}

		return ret
	}
	
	// 104. Maximum Depth of Binary Tree
	// https://leetcode.com/problems/maximum-depth-of-binary-tree/
	static func maxDepth(_ root: TreeNode?) -> Int {
		guard let rootNode = root else {
			return 0
		}
		
		var queue = [TreeNode]()
		queue.append(rootNode)
		
		var level = 0
		var currentNodeNum = 1
		var nextLevelNodeNum = 0
		while !queue.isEmpty {
			let node = queue.removeFirst()
			
			currentNodeNum -= 1
			
			if let leftNode = node.left {
				queue.append(leftNode)
				nextLevelNodeNum += 1
			}
			
			if let rightNode = node.right {
				queue.append(rightNode)
				nextLevelNodeNum += 1
			}
			
			if currentNodeNum == 0 {
				currentNodeNum = nextLevelNodeNum
				nextLevelNodeNum = 0
				
				level += 1
			}
		}
		
		return level
		
//		guard let rootNode = root else {
//			return 0
//		}
//
//		let lDepth = self.maxDepth(rootNode.left)
//		let rDepth = self.maxDepth(rootNode.right)
//
//		if lDepth > rDepth {
//			return lDepth + 1
//		} else {
//			return rDepth + 1
//		}
	}
	
	// 105. Construct Binary Tree from Preorder and Inorder Traversal
	// https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/
	static func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
		var preorderIndex = preorder.startIndex
		func internalBuildTree(inStart: Array<Int>.Index, inEnd: Array<Int>.Index) -> TreeNode? {
			if inStart > inEnd {
				return nil
			}
			
			let node = TreeNode(preorder[preorderIndex])
			preorderIndex += 1
			
			if inStart == inEnd {
				return node
			}
			
			guard let nodeIndex = (inorder.index { $0 == node.val }) else {
				return nil
			}
			
			node.left = internalBuildTree(inStart: inStart, inEnd: nodeIndex - 1)
			node.right = internalBuildTree(inStart: nodeIndex + 1, inEnd: inEnd)
			
			return node
		}
		
		return internalBuildTree(inStart: inorder.startIndex, inEnd: inorder.endIndex - 1)
	}
	
	// 106. Construct Binary Tree from Inorder and Postorder Traversal
	// https://leetcode.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/
	static func buildTree2(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
		var postorderIndex = postorder.endIndex - 1
		func internalBuildTree(inStart: Array<Int>.Index, inEnd: Array<Int>.Index) -> TreeNode? {
			if inStart > inEnd {
				return nil
			}
			
			let node = TreeNode(postorder[postorderIndex])
			postorderIndex -= 1
			
			if inStart == inEnd {
				return node
			}
			
			guard let nodeIndex = (inorder.index { $0 == node.val }) else {
				return nil
			}
			
			node.right = internalBuildTree(inStart: nodeIndex + 1, inEnd: inEnd)
			node.left = internalBuildTree(inStart: inStart, inEnd: nodeIndex - 1)
			
			return node
		}
		
		return internalBuildTree(inStart: inorder.startIndex, inEnd: inorder.endIndex - 1)
	}
	
	// 107. Binary Tree Level Order Traversal II
	// https://leetcode.com/problems/binary-tree-level-order-traversal-ii/
	static func levelOrderBottom(root: TreeNode?) -> [[Int]] {
		guard let rootNode = root else {
			return []
		}

		var ret: [[Int]] = []
		var values: [Int] = []
		var nodes: [TreeNode?] = []

		nodes.append(rootNode)
		nodes.append(nil)

		while !nodes.isEmpty {
			guard let currentNode = nodes.removeFirst() else {
				ret.append(values)

				if !nodes.isEmpty {
					values.removeAll()
					nodes.append(nil)
				}

				continue
			}

			values.append(currentNode.val)
			if currentNode.left != nil {
				nodes.append(currentNode.left)
			}
			if currentNode.right != nil {
				nodes.append(currentNode.right)
			}
		}

		return ret.reverse()
	}
	
	// 108. Convert Sorted Array to Binary Search Tree
	// https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/
	static func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
		func internalBuilder(leftIndex: Array<Int>.Index, rightIndex: Array<Int>.Index) -> TreeNode? {
			if leftIndex > rightIndex {
				return nil
			}
			
			let newNode = TreeNode(0)
			
			if leftIndex == rightIndex {
				newNode.val = nums[leftIndex]
			} else {
				let indexDis = nums.distance(from: leftIndex, to: rightIndex)
				let midIndex = nums.index(leftIndex, offsetBy: indexDis / 2)
				newNode.val = nums[midIndex]
				newNode.left = internalBuilder(leftIndex: leftIndex, rightIndex: nums.index(before: midIndex))
				newNode.right = internalBuilder(leftIndex: nums.index(after: midIndex), rightIndex: rightIndex)
			}
			
			return newNode
		}
		
		return internalBuilder(leftIndex: nums.startIndex, rightIndex: nums.endIndex - 1)
	}
	
	// 110. Balanced Binary Tree
	// https://leetcode.com/problems/balanced-binary-tree/
	static func isBalanced(_ root: TreeNode?) -> Bool {
		guard let rootNode = root else {
			return true
		}
		
		func treeHeight(_ root: TreeNode?) -> Int {
			guard let rootNode = root else {
				return 0
			}
	
			return 1 + max(treeHeight(rootNode.left), treeHeight(rootNode.right))
		}

		let heightOfLeftSubTree = treeHeight(rootNode.left)
		let heightOfRightSubTree = treeHeight(rootNode.right)

		let checkConditionOfTreeHeight = abs(heightOfLeftSubTree - heightOfRightSubTree) <= 1
		let isLeftSubTreeBalanced = self.isBalanced(rootNode.left)
		let isRightSubTreeBalanced = self.isBalanced(rootNode.right)

		return checkConditionOfTreeHeight && isLeftSubTreeBalanced && isRightSubTreeBalanced
	}
	
	// 111. Minimum Depth of Binary Tree
	// https://leetcode.com/problems/minimum-depth-of-binary-tree/
	static func minDepth(_ root: TreeNode?) -> Int {
		guard let rootNode = root else {
			return 0
		}
		
		if let leftNode = rootNode.left, let rightNode = rootNode.right {
			return min(minDepth(leftNode), minDepth(rightNode)) + 1
		}
		
		return max(minDepth(rootNode.left), minDepth(rootNode.right)) + 1
	}
	
	// 112. Path Sum
	// https://leetcode.com/problems/path-sum/
	static func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
		guard let rootNode = root else {
			return false
		}

		let remainValue = sum - rootNode.val

		if rootNode.left == nil && rootNode.right == nil {
			return remainValue == 0
		}

		return self.hasPathSum(rootNode.left, remainValue)
			|| self.hasPathSum(rootNode.right, remainValue)
	}
	
	// 113. Path Sum II
	// https://leetcode.com/problems/path-sum-ii/
	static func pathSum2(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
		func findPaths(_ root: TreeNode?, sum: Int, path: inout Path, paths: inout Paths) {
			guard let rootNode = root else {
				return
			}
			
			path.append(rootNode.val)
			
			if rootNode.left == nil && rootNode.right == nil && sum == rootNode.val {
				paths.append(path)
				path.removeLast()
				return
			}
			
			findPaths(rootNode.left, sum: sum - rootNode.val, path: &path, paths: &paths)
			findPaths(rootNode.right, sum: sum - rootNode.val, path: &path, paths: &paths)
			
			path.removeLast()
		}
		
		var path = Path()
		var paths = Paths()
		findPaths(root, sum: sum, path: &path, paths: &paths)
		
		return paths
	}
	
	// 114. Flatten Binary Tree to Linked List
	// https://leetcode.com/problems/flatten-binary-tree-to-linked-list/
	static func flatten(_ root: TreeNode?) {
		var currentNode = root
		while let node = currentNode {
			guard let leftNode = node.left else {
				currentNode = node.right
				continue
			}
			
			var prevNode: TreeNode? = leftNode
			while prevNode?.right != nil {
				prevNode = prevNode?.right
			}
			prevNode?.right = node.right
			
			node.right = node.left
			node.left = nil
			
			currentNode = node.right
		}
	}
	
	// 116. Populating Next Right Pointers in Each Node
	// https://leetcode.com/problems/populating-next-right-pointers-in-each-node/
//	void connect(TreeLinkNode *root) {
//		if (root == nullptr) {
//			return;
//		}
//		
//		TreeLinkNode *currentLeftNode = root;
//		TreeLinkNode *currentNode = nullptr;
//		while (currentLeftNode->left != nullptr) {
//			currentNode = currentLeftNode;
//			while (currentNode != nullptr) {
//				currentNode->left->next = currentNode->right;
//				
//				if (currentNode->next != nullptr) {
//					currentNode->right->next = currentNode->next->left;
//				}
//				
//				currentNode = currentNode->next;
//			}
//			
//			currentLeftNode = currentLeftNode->left;
//		}
//	}

	// 129. Sum Root to Leaf Numbers
	// https://leetcode.com/problems/sum-root-to-leaf-numbers/
	static func sumNumbers(_ root: TreeNode?) -> Int {
		guard let rootNode = root else {
			return 0
		}
		
		var ret = 0
		var stack = [StackItem]()
		stack.append((rootNode, rootNode.val))
		while !stack.isEmpty {
			let topItem = stack.removeLast()
			
			if topItem.0.left == nil && topItem.0.right == nil {
				ret += topItem.1
			}
			
			if let rightNode = topItem.0.right {
				stack.append((rightNode, topItem.1 * 10 + rightNode.val))
			}
			
			if let leftNode = topItem.0.left {
				stack.append((leftNode, topItem.1 * 10 + leftNode.val))
			}
		}
		
		return ret
	}
	
	// 144. Binary Tree Preorder Traversal
	// https://leetcode.com/problems/binary-tree-preorder-traversal/
	static func preorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil {
			return []
		}
		
		var ret = [Int]()
		var stack = [TreeNode?]()
		var currentNode = root
		while true {
			while let node = currentNode {
				ret.append(node.val)
				stack.append(node)
				currentNode = currentNode?.left
			}
			
			if stack.isEmpty {
				break
			}
			
			let topNode = (stack.removeLast())!
			currentNode = topNode.right
		}
		
		return ret
    }

	// 145. Binary Tree Postorder Traversal
	static 
	
	// 235. Lowest Common Ancestor of a Binary Search Tree
	// https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/
//	TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
//		if (root == nullptr || p == nullptr || q == nullptr) {
//			return root;
//		}
//		
//		if (p->val < root->val && q->val < root->val) {
//			return lowestCommonAncestor(root->left, p, q);
//		}
//		
//		if (p->val > root->val && q->val > root->val) {
//			return lowestCommonAncestor(root->right, p, q);
//		}
//		
//		return root;
//	}
	
	// 236. Lowest Common Ancestor of a Binary Tree
	// https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/
//	TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
//		if (root == nullptr || root == p || root == q) {
//			return root;
//		}
//		
//		TreeNode *left = lowestCommonAncestor(root->left, p, q);
//		TreeNode *right = lowestCommonAncestor(root->right, p, q);
//		
//		if (left != nullptr && right != nullptr) {
//			return root;
//		}
//		
//		return left != nullptr ? left : right;
//	}
}