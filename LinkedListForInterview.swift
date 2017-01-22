struct LinkedListForInterview {
	// 2. Add Two Numbers
	// https://leetcode.com/problems/add-two-numbers/
	static func addTwoNumbers(_ l1: LeetListNode?, _ l2: LeetListNode?) -> LeetListNode? {
		var ret: LeetListNode? = nil
		var currentRetNode: LeetListNode?
		var isCarry = false
		var currentNode1 = l1
		var currentNode2 = l2
		while currentNode1 != nil || currentNode2 != nil {
			let node = LeetListNode(0)
			
			let number1 = currentNode1?.val ?? 0
			let number2 = currentNode2?.val ?? 0
			let sum = number1 + number2 + (isCarry ? 1 : 0)
			if sum >= 10 {
				node.val = sum % 10
				isCarry = true
			} else {
				node.val = sum
				isCarry = false
			}
			
			if ret == nil {
				ret = node
				currentRetNode = node
			} else {
				currentRetNode?.next = node
				currentRetNode = node
			}
			
			currentNode1 = currentNode1?.next
			currentNode2 = currentNode2?.next
		}
		
		if isCarry {
			let node = LeetListNode(1)
			currentRetNode?.next = node
		}
		
		return ret
	}
	
	// 19. Remove Nth Node From End of List
	// https://leetcode.com/problems/remove-nth-node-from-end-of-list/
	static func removeNthFromEnd(_ head: LeetListNode?, _ n: Int) -> LeetListNode? {
		let sentinel = LeetListNode(-1)
		sentinel.next = head
		
        var slowP: LeetListNode? = sentinel
        var fastP: LeetListNode? = sentinel
		for _ in 0..<n {
			fastP = fastP?.next
		}
		
		while fastP?.next != nil {
			slowP = slowP?.next
			fastP = fastP?.next
		}
		
		slowP?.next = slowP?.next?.next
		
		return sentinel.next
	}
	
	// 21. Merge Two Sorted Lists
	// https://leetcode.com/problems/merge-two-sorted-lists/
	static func mergeTwoLists(_ l1: LeetListNode?, _ l2: LeetListNode?) -> LeetListNode? {
		var currentl1Head = l1
		var currentl2Head = l2
		var head: LeetListNode? = nil
		var currentNode: LeetListNode? = nil
		
		while let l1Value = currentl1Head?.val,
			  let l2Value = currentl2Head?.val {
				if l1Value <= l2Value {
					currentNode?.next = currentl1Head
					currentNode = currentl1Head
					
					currentl1Head = currentl1Head?.next
				} else {
					currentNode?.next = currentl2Head
					currentNode = currentl2Head
					
					currentl2Head = currentl2Head?.next
				}
				
				if head == nil {
					head = currentNode
				}
		}
		
		if currentl1Head != nil {
			currentNode?.next = currentl1Head
			currentNode = currentl1Head
		}

		if currentl2Head != nil {
			currentNode?.next = currentl2Head
			currentNode = currentl2Head
		}
		
		if head == nil {
		    head = currentNode
		}

		return head
	}
	
	// 23. Merge k Sorted Lists
	// https://leetcode.com/problems/merge-k-sorted-lists/
	static func mergeKLists(_ lists: [LeetListNode?]) -> ListNode? {
		if lists.count < 2 {
			return lists.first ?? nil
		}
		
		let leftSlice = lists[0..<(lists.count / 2)]
		let rightSlice = lists[(lists.count / 2)..<lists.endIndex]
		
		let leftSortedList = mergeKLists([LeetListNode?](leftSlice))
		let rightSortedList = mergeKLists([LeetListNode?](rightSlice))
		
		if leftSortedList == nil {
			return rightSortedList
		}
		
		if rightSortedList == nil {
			return leftSortedList
		}
		
		return mergeTwoLists(leftSortedList, rightSortedList)
	}
	
	// 24. Swap Nodes in Pairs
	// https://leetcode.com/problems/swap-nodes-in-pairs/
	static func swapPairs(_ head: LeetListNode?) -> LeetListNode? {
//		guard let headNode = head, headNode.next != nil else {
//			return head
//		}
//
//		let secondNode = headNode.next
//		let thirdNode = secondNode?.next
//
//		secondNode?.next = headNode
//		headNode.next = self.swapPairs(thirdNode)
//
//		return secondNode

		var newListHead: LeetListNode?
		var tempNode: LeetListNode?
		var currentNode = head
		while let node = currentNode, let nextNode = node.next {
			tempNode?.next?.next = nextNode
			
			tempNode = nextNode
			node.next = tempNode?.next
			tempNode?.next = node
			
			if newListHead == nil {
				newListHead = tempNode
			}
			
			currentNode = node.next
		}
		
		return newListHead ?? head
	}
	
	// 25. Reverse Nodes in k-Group
	// https://leetcode.com/problems/reverse-nodes-in-k-group/
	static func reverseKGroup(_ head: LeetListNode?, _ k: Int) -> LeetListNode? {
		if k < 2 {
			return head
		}
		
		func hasEnoughNodes(_ head: LeetListNode?, _ count: Int) -> Bool {
			var ret = 0;
			var currentNode = head
			while currentNode != nil && ret < count {
				ret += 1
				currentNode = currentNode?.next
			}
			
			return ret == count
		}
		
		func getNextNode(_ head: LeetListNode?, from: Int) -> LeetListNode? {
			var i = 0;
			var currentNode = head
			while currentNode != nil && i < from {
				i += 1
				currentNode = currentNode?.next
			}
			
			return currentNode
		}
		
		if !hasEnoughNodes(head, k) {
			return head
		}
		
		let newHead = getNextNode(head, from: k - 1)
		
		var startNode = head
		var prevNode: LeetListNode?
		var tempNode: LeetListNode?
		while startNode != nil && hasEnoughNodes(startNode, k) {
			tempNode = getNextNode(startNode, from: k)
			var groupHead = startNode
			
			var nextNode: LeetListNode?
			for _ in 0..<k {
				nextNode = startNode?.next
				startNode?.next = tempNode
				tempNode = startNode
				startNode = nextNode
			}
			
			prevNode?.next = tempNode
			prevNode = groupHead
		}
		
		return newHead
	}
	
	// 61. Rotate List
	// https://leetcode.com/problems/rotate-list/
	static func rotateRight(_ head: LeetListNode?, _ k: Int) -> LeetListNode? {
		if head == nil || k <= 0 {
			return head
		}
		
		var lastNode = head
		var nodeCount = 1
		while lastNode?.next != nil {
			nodeCount += 1
			lastNode = lastNode?.next
		}
		
		let moveCount = k % nodeCount
		if moveCount == 0 {
		    return head
		}
		
		var currentHead = head
		for _ in 0..<(nodeCount - moveCount) {
			var nextNode = currentHead?.next
			
			lastNode?.next = currentHead
			currentHead?.next = nil
			lastNode = currentHead
			currentHead = nextNode
		}
		
		return currentHead
	}
	
	// 82. Remove Duplicates from Sorted List II
	// https://leetcode.com/problems/remove-duplicates-from-sorted-list-ii/
	static func deleteDuplicates2(_ head: LeetListNode?) -> ListNode? {
		let sentinel = LeetListNode(-1)
		sentinel.next = head
		
		var currentNode = head
		var prevNode: LeetListNode? = sentinel
		while let node = currentNode {
			var isDuplicated = false
			while let nextNode = currentNode?.next, node.val == nextNode.val {
				currentNode = nextNode
				isDuplicated = true
			}
			
			if isDuplicated {
				prevNode?.next = currentNode?.next
			} else {
				prevNode = prevNode?.next
			}
			
			currentNode = currentNode?.next
		}
		
		return sentinel.next
	}
	
	// 83. Remove Duplicates from Sorted List
	// https://leetcode.com/problems/remove-duplicates-from-sorted-list/
	static func deleteDuplicates(_ head: LeetListNode?) -> LeetListNode? {
		var currentNode = head
		while let node = currentNode, let nextNode = node.next {
			if node.val == nextNode.val {
				currentNode?.next = nextNode.next
			} else {
				currentNode = nextNode
			}
		}

		return head
	}
	
	// 86. Partition List
	// https://leetcode.com/problems/partition-list/
	static func partition(_ head: LeetListNode?, _ x: Int) -> LeetListNode? {
		let sentinel = LeetListNode(-1)
		sentinel.next = head
		
		var currentNode = head
		var prevNode: LeetListNode? = sentinel
		var secondHead: LeetListNode?
		var currentNodeOfSencondList: LeetListNode? 
		while let node = currentNode {
			if node.val < x {
				prevNode = node
				currentNode = node.next
			} else {
				prevNode?.next = node.next
				currentNode = node.next
				
				if secondHead == nil {
					secondHead = node
				}
				
				currentNodeOfSencondList?.next = node
				node.next = nil
				currentNodeOfSencondList = node
			}
		}
		
		prevNode?.next = secondHead
		
		return sentinel.next
	}
	
	// 92. Reverse Linked List II
	// https://leetcode.com/problems/reverse-linked-list-ii/
	static func reverseBetween(_ head: LeetListNode?, _ m: Int, _ n: Int) -> LeetListNode? {
		let sentinel = LeetListNode(0)
		sentinel.next = head
		var predecessor: LeetListNode? = sentinel
		for _ in 0..<(m-1) {
			predecessor = predecessor?.next
		}
		
		var startNode = predecessor?.next
		var nextNode = startNode?.next
		for _ in 0..<(n-m) {
			startNode?.next = nextNode?.next
			nextNode?.next = predecessor?.next
			predecessor?.next = nextNode
			nextNode = startNode?.next
		}
		
		return sentinel.next
	}
	
	// 138. Copy List with Random Pointer
	// https://leetcode.com/problems/copy-list-with-random-pointer/
//	RandomListNode *copyRandomList(RandomListNode *head) {
//		std::unordered_map<RandomListNode*, RandomListNode*> container;
//		RandomListNode *currentNode = head;
//		while (currentNode != nullptr) {
//			RandomListNode *y = new RandomListNode(currentNode->label);
//			container[currentNode] = y;
//			
//			currentNode = currentNode->next;
//		}
//		
//		currentNode = head;
//		while (currentNode != nullptr) {
//			if (container.find(currentNode) == container.end()) {
//				currentNode = currentNode->next;
//				continue;
//			}
//			
//			RandomListNode *y = container[currentNode];
//			y->next = container[currentNode->next];
//			y->random = container[currentNode->random];
//			
//			currentNode = currentNode->next;
//		}
//		
//		return container[head];
//	}
	
	// 141. Linked List Cycle
	// https://leetcode.com/problems/linked-list-cycle/
//	static func hasCycle(_ head: LeetListNode?) -> Bool {
//		var slow = head
//		var fast = head?.next
//		while true {
//			guard let fastNode = fast, 
//			      let nextFast = fastNode.next else {
//				return false
//			}
//			
//			guard let slowNode = slow else {
//				return false
//			}
//			
//			if fastNode == slowNode || nextFast == slowNode {
//				return true
//			}
//			
//			slow = slow?.next
//			fast = fast?.next?.next
//		}
//		
//		return false
//	}
	
	// 142. Linked List Cycle II
	// https://leetcode.com/problems/linked-list-cycle-ii/
//	static func detectCycle(_ head: LeetListNode?) -> LeetListNode? {
//		if head == nil || head?.next == nil {
//			return nil
//		}
//	
//		var slow = head;
//		var fast  = head;
//	
//		while fast?.next != nil && fast?.next?.next != nil {
//			slow = slow?.next
//			fast = fast?.next?.next
//			
//			if slow! == fast! {
//				var entry = head
//				while slow! != entry! {
//					slow = slow?.next
//					entry = entry?.next
//				}
//			}
//		}
//		
//		return nil
//	}

	// 143. Reorder List
	// https://leetcode.com/problems/reorder-list/
	static func reorderList(_ head: LeetListNode?) -> LeetListNode? {
		var slow = head
		var fast = head
		while let nextNextNode = fast?.next?.next {
			slow = slow?.next
			fast = nextNextNode
		}
		
		let secondPartHead = reverseList(slow?.next)
		slow?.next = nil
		
		var p1 = head
		var p2 = secondPartHead
		while let p1Node = p1, let p2Node = p2 {
			let p1Next = p1Node.next
			let p2Next = p2Node.next
			p1Node.next = p2Node
			p2Node.next = p1Next
			
			p1 = p1Next
			p2 = p2Next
		}
		
		return head
	}

	// 160. Intersection of Two Linked Lists
	// https://leetcode.com/problems/intersection-of-two-linked-lists/
//	ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
//		int lengthOfA = 0;
//		ListNode *l1 = headA;
//		while (l1 != nullptr) {
//			++lengthOfA;
//			l1 = l1->next;
//		}
//		
//		int lengthOfB = 0;
//		ListNode *l2 = headB;
//		while (l2 != nullptr) {
//			++lengthOfB;
//			l2 = l2->next;
//		}
//		
//		int diff = 0;
//		if (lengthOfA < lengthOfB) {
//			l1 = headB;
//			l2 = headA;
//			diff = lengthOfB - lengthOfA;
//		} else {
//			l1 = headA;
//			l2 = headB;
//			diff = lengthOfA - lengthOfB;
//		}
//		
//		for (int i = 0; i < diff; ++i) {
//			l1 = l1->next;
//		}
//		
//		while (l1 != nullptr && l2 != nullptr) {
//			if (l1 == l2) {
//				return l1;
//			}
//			
//			l1 = l1->next;
//			l2 = l2->next;
//		}
//		
//		return nullptr;
//	}

	// 203. Remove Linked List Elements
	// https://leetcode.com/problems/remove-linked-list-elements/
	static func removeElements(_ head: LeetListNode?, _ val: Int) -> LeetListNode? {
		let sentinel = LeetListNode(-1)
		sentinel.next = head
		
		var prevNode: LeetListNode? = sentinel
		var currentNode = head
		while let node = currentNode {
			if node.val == val {
				prevNode?.next = node.next
			} else {
				prevNode = prevNode?.next
			}
			
			currentNode = node.next
		}
		
		return sentinel.next
	}

	// 206. Reverse Linked List
	// https://leetcode.com/problems/reverse-linked-list/
	static func reverseList(_ head: LeetListNode?) -> LeetListNode? {
		var currentNode = head
		var tempNode: LeetListNode?
		var preNode: LeetListNode?
		while let node = currentNode {
			tempNode = node.next

			node.next = preNode
			preNode = node

			currentNode = tempNode
		}

		return preNode
	}
	
	// 234. Palindrome Linked List
	// https://leetcode.com/problems/palindrome-linked-list/
	static func isPalindrome(_ head: LeetListNode?) -> Bool {
		var slow = head
		var fast = head
		while fast?.next != nil && fast?.next?.next != nil {
			slow = slow?.next
			fast = fast?.next?.next
		}
		
		slow?.next = reverseList(slow?.next)
		slow = slow?.next
		var currentNode = head
		while let slowNode = slow, let node = currentNode {
			if slowNode.val != node.val {
				return false
			}
			
			currentNode = currentNode?.next
			slow = slow?.next
		}
		
		return true
	}
	
	// 445. Add Two Numbers II
	// https://leetcode.com/problems/add-two-numbers-ii/
	static func addTwoNumbers2(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
		var num1 = [Int]()
		var l1Node = l1
		while let node = l1Node {
			num1.append(node.val)
			l1Node = node.next
		}
		
		var num2 = [Int]()
		var l2Node = l2
		while let node = l2Node {
			num2.append(node.val)
			l2Node = node.next
		}
		
		var isCarry = false
		var currentNode: ListNode?
		while !num1.isEmpty || !num2.isEmpty {
			let n1 = !num1.isEmpty ? num1.removeLast() : 0
			let n2 = !num2.isEmpty ? num2.removeLast() : 0
			
			let addSum = n1 + n2 + (isCarry ? 1 : 0)
			let displayNum = addSum % 10
			
			var prevNode = currentNode
			currentNode = ListNode(displayNum)
			currentNode?.next = prevNode
			
			isCarry = addSum >= 10
		}
		
		if isCarry {
			var prevNode = currentNode
			currentNode = ListNode(1)
			currentNode?.next = prevNode
		}
		
		return currentNode
	}
}
