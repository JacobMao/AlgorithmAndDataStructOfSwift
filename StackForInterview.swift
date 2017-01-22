struct StackForInterview {
	// 20. Valid Parentheses
	// https://leetcode.com/problems/valid-parentheses/
	static func isValid(_ s: String) -> Bool {
		let parenthesisDict: [Character:Character] = [ ")" : "(",
													   "]" : "[",
													   "}" : "{"]
		
		var stack = Array<Character>()
		var sIndex = s.startIndex
		while sIndex != s.endIndex {
			let c = s[sIndex]
			switch c {
			case "(", "[", "{":
				stack.append(c)
			case ")", "]", "}":
				if stack.isEmpty {
					return false
				}
				
				guard let matchCharacter = parenthesisDict[c] else {
					return false
				}
				
				let top = stack.removeLast()
				if top != matchCharacter {
					return false
				}
			default:
				return false
			}
			
			sIndex = s.index(after: sIndex)
		}
		
		return stack.isEmpty
	}
	
	// 42. Trapping Rain Water
	// https://leetcode.com/problems/trapping-rain-water/
//	static func trap(_ height: [Int]) -> Int {
//		
//	}
	
	// 71. Simplify Path
	// https://leetcode.com/problems/simplify-path/
	static func simplifyPath(_ path: String) -> String {
		if path.isEmpty {
			return ""
		}
		
		var stack = [String]()
		let splitedStrings = path.characters.split(separator: "/").map(String.init)
		for subString in splitedStrings {
			switch subString {
				case "/", ".":
					continue
				case "..":
					if stack.isEmpty {
						continue
					}
					
					stack.removeLast()
				default:
					stack.append(subString)
			}
		}
		
		if stack.isEmpty {
			return "/"
		}
		
		let ret = stack.reduce("") {
			return $0 + "/" + $1
		}
		
		return ret
	}
	
	// 84. Largest Rectangle in Histogram
	// https://leetcode.com/problems/largest-rectangle-in-histogram/
	static func largestRectangleArea(_ heights: [Int]) -> Int {
		typealias StackItem = Array<Int>.Index
				
		var maxArea = 0
		var stack = [StackItem]()
		for i in 0...heights.count {
			let currentHeight = i < heights.count ? heights[i] : Int.min
			guard let topItemIndex = stack.last, currentHeight <= heights[topItemIndex] else {
				stack.append(i)
				continue
			}
			
			while let topIndex = stack.last, heights[topIndex] > currentHeight {
				stack.removeLast()
				
				let spin = stack.isEmpty ? i : (i - stack[stack.endIndex - 1] - 1)
				let area = heights[topIndex] * spin
				maxArea = max(maxArea, area)
			}
			
			stack.append(i)
		}
		
		return maxArea
	}
	
	// 94. Binary Tree Inorder Traversal
	// https://leetcode.com/problems/binary-tree-inorder-traversal/
	static func inorderTraversal(_ root: LeetTreeNode?) -> [Int] {
		if root == nil {
			return []
		}
		
		var ret = [Int]()
		var stack = [LeetTreeNode?]()
		var currentNode = root
		while true {
			while let node = currentNode {
				stack.append(node)
				currentNode = currentNode?.left
			}
			
			if stack.isEmpty {
				break
			}
			
			let topNode = (stack.removeLast())!
			ret.append(topNode.val)
			currentNode = topNode.right
		}
		
		return ret
	}
	
	// 103. Binary Tree Zigzag Level Order Traversal
	// https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/
	static func zigzagLevelOrder(_ root: LeetTreeNode?) -> [[Int]] {
		var ret = [[Int]]()
		
		var nodeArray = [root].flatMap { $0 }
		var isReverse = false
		while !nodeArray.isEmpty {
			var nextLevelNodes = [LeetTreeNode?]()
			var levelValue = [Int]()
			levelValue.reserveCapacity(nodeArray.count)
			for n in nodeArray {
				levelValue.append(n.val)
				nextLevelNodes.append(n.left)
				nextLevelNodes.append(n.right)
			}
			
			if isReverse {
				ret.append(levelValue.reversed())
			} else {
				ret.append(levelValue)
			}
			
			isReverse = !isReverse
			
			nodeArray = nextLevelNodes.flatMap { $0 }
		}
		
		return ret
	}
	
	// 144. Binary Tree Preorder Traversal
	// https://leetcode.com/problems/binary-tree-preorder-traversal/
	static func preorderTraversal(_ root: LeetTreeNode?) -> [Int] {
		if root == nil {
			return []
		}
		
		var ret = [Int]()
		var stack = [LeetTreeNode?]()
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
	// https://leetcode.com/problems/binary-tree-postorder-traversal/
	static func postorderTraversal(_ root: LeetTreeNode?) -> [Int] {
		var ret = [Int]()
		var stack = [LeetTreeNode?]()
		var currentNode = root
		var lastVisitedNode: LeetTreeNode?
		while !stack.isEmpty || currentNode != nil {
			if let node = currentNode {
				stack.append(node)
				currentNode = currentNode?.left
			} else {
				let topNode = stack[stack.endIndex - 1]!
				if let topRightNode = topNode.right {
					guard let lastestNode = lastVisitedNode, lastestNode === topRightNode else {
						currentNode = topRightNode
						continue
					}
					
					ret.append(topNode.val)
					lastVisitedNode = stack.removeLast()
				} else {
					ret.append(topNode.val)
					lastVisitedNode = stack.removeLast()
				}
			}
		}
		
		return ret
	}
	
	// 150. Evaluate Reverse Polish Notation
	// https://leetcode.com/problems/evaluate-reverse-polish-notation/
	static func evalRPN(_ tokens: [String]) -> Int {
		var stack = [Int]()
		for t in tokens {
			switch t {
				case "+", "-", "*", "/":
					guard let operand2 = stack.popLast() else {
						return 0
					}
					
					guard let operand1 = stack.popLast() else {
						return 0
					}
					
					var result = 0
					switch t {
						case "+":
							result = operand1 + operand2
						case "-":
							result = operand1 - operand2
						case "*":
							result = operand1 * operand2
						case "/":
							result = operand1 / operand2
						default:
							return 0
					}
					
					stack.append(result)
				default:
					stack.append(Int(t)!)
			}
		}
		
		return stack.last ?? 0
	}
	
	// 155. Min Stack
	// https://leetcode.com/problems/min-stack/
//	class MinStack {
//		public:
//			/** initialize your data structure here. */
//			MinStack() {
//				this->m_currentMin = INT_MAX;
//			}
//			
//			void push(int x) {
//				if (x <= this->m_currentMin) {
//					this->m_stack.push_back(this->m_currentMin);
//					this->m_currentMin = x;
//				}
//				
//				this->m_stack.push_back(x);
//			}
//			
//			void pop() {
//				if (this->top() == this->m_currentMin) {
//					this->m_stack.pop_back();
//					this->m_currentMin = this->top();
//					this->m_stack.pop_back();
//				} else {
//					this->m_stack.pop_back();
//				}
//			}
//			
//			int top() {
//				return this->m_stack.back();
//			}
//			
//			int getMin() {
//				return this->m_currentMin;
//			}
//		private:
//			std::vector<int> m_stack;
//			int m_currentMin;
//		};

	// 224. Basic Calculator
	// https://leetcode.com/problems/basic-calculator/
	static func calculate(_ s: String) -> Int {
		var operatorStack = [Character]()
		var operandStack = [Int]()
		var sIndex = s.startIndex
		var numStartIndex: String.Index?
		
		let extractNumClosure = {(to: String.Index) in
			if let numSIndex = numStartIndex {
				operandStack.append(Int(s[numSIndex..<sIndex])!)
				numStartIndex = nil
			}
		}
		
		let evaluateExpression = {(op: Character) in
			if op != "+" && op != "-" {
				return
			}
			
			
			let operand2 = operandStack.removeLast()
			let operand1 = operandStack.removeLast()
			if op == "+" {
				operandStack.append(operand1 + operand2)
			} else {
				operandStack.append(operand1 - operand2)
			}
		}
		
		while sIndex != s.endIndex {
			let c = s[sIndex]
			switch c {
			case "(":
				operatorStack.append(c)
				
				extractNumClosure(sIndex)
			case ")":
				extractNumClosure(sIndex)
				
				while true {
					guard let prevOperator = operatorStack.last else {
						break
					}
					
					operatorStack.removeLast()
					if prevOperator == "(" {
						break
					}
					
					evaluateExpression(prevOperator)
				}
			case "+", "-":
				extractNumClosure(sIndex)
				
				guard let prevOperator = operatorStack.last, prevOperator != "(" else {
					operatorStack.append(c)
					break
				}
				
				evaluateExpression(prevOperator)
				
				operatorStack.removeLast()
				operatorStack.append(c)
			case " ":
			   extractNumClosure(sIndex)
			default:
				if numStartIndex == nil {
					numStartIndex = sIndex
				}
			}
			
			sIndex = s.index(after: sIndex)
		}
		
		extractNumClosure(s.endIndex)
	
		while let op = operatorStack.last, operandStack.count >= 2 {
			evaluateExpression(op)
			
			operatorStack.removeLast()
		}
		
		return operandStack[0]
	}

	// 225. Implement Stack using Queues
	// https://leetcode.com/problems/implement-stack-using-queues/
//	class Stack {
//		public:
//			// Push element x onto stack.
//			void push(int x) {
//				if (this->m_q1.empty()) {
//					this->m_q2.push(x);
//				} else {
//					this->m_q1.push(x);
//				}
//			}
//
//			// Removes the element on top of the stack.
//			void pop() {
//				if (this->empty()) {
//					return;
//				}
//				
//				if (this->m_q1.empty()) {
//					int queueSize = this->m_q2.size();
//					for (int i = 0; i < queueSize - 1; ++i) {
//						this->m_q1.push(this->m_q2.front());
//						this->m_q2.pop();
//					}
//					this->m_q2.pop();
//				} else {
//					int queueSize = this->m_q1.size();
//					for (int i = 0; i < queueSize - 1; ++i) {
//						this->m_q2.push(this->m_q1.front());
//						this->m_q1.pop();
//					}
//					this->m_q1.pop();
//				}
//			}
//
//			// Get the top element.
//			int top() {
//				if (this->m_q1.empty()) {
//					return this->m_q2.back();
//				} else {
//					return this->m_q1.back();
//				}
//			}
//
//			// Return whether the stack is empty.
//			bool empty() {
//				return this->m_q1.empty() && this->m_q2.empty();
//			}
//		private:
//			std::queue<int> m_q1;
//			std::queue<int> m_q2;
//		};

	// 331. Verify Preorder Serialization of a Binary Tree
	// https://leetcode.com/problems/verify-preorder-serialization-of-a-binary-tree/
	static func isValidSerialization(_ preorder: String) -> Bool {
		var stack = [String]()
		let splitedStrings = preorder.characters.split(separator: ",").map(String.init)
		for s in splitedStrings {
			switch s {
				case "#":
					while let topString = stack.last, topString == "#" && !stack.isEmpty {
						stack.removeLast()
						
						if stack.isEmpty {
							return false
						}
						
						stack.removeLast()
					}
						
					stack.append(s)
				default:
					stack.append(s)
			}
		}
		
		return stack.count == 1 && stack[0] == "#"
	}
	
	// 385. Mini Parser
	// https://leetcode.com/problems/mini-parser/
	static func deserialize(_ s: String) -> NestedInteger {
		if s[s.startIndex] != "[" {
			let ret = NestedInteger()
			ret.setInteger(Int(s)!)
			return ret
		}
		
		var ret: NestedInteger?
		var stack = [String]()
		let splitedStrings = s.characters.split(separator: ",").map(String.init)
		for s in splitedStrings {
			var sIndex = s.startIndex
			var numStartIndex = sIndex
			var isFlagNum = false
			while true {
				let c = s[sIndex]
				switch c {
					case "[":
						stack.append(String(c))
					case "]":
						let numStr = s[numStartIndex..<sIndex]
						if let _ = Int(numStr) else {
							stack.append(numStr)
						}
						
						
					default:
						if !isFlagNum {
							numStartIndex = sIndex
							isFlagNum = true
						}
				}
				
				sIndex = s.index(after: sIndex)
			}
		}
	}

	// 456. 132 Pattern
	// https://leetcode.com/problems/132-pattern/
	static func find132pattern(_ nums: [Int]) -> Bool {
		var stack = [Int]()
		var s3 = Int.min
		for n in nums.lazy.reversed() {
			if n < s3 {
				return true
			}
			
			while let topNum = stack.last, n > topNum {
				s3 = topNum
				stack.removeLast()
			}
			
			stack.append(n)
		}
		
		return false
	}
}
