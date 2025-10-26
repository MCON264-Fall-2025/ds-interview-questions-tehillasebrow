# L13 – Reorder List

## Overview
This assignment implements a solution for the **Reorder List** problem using a singly linked list.

Given a singly linked list `L: L0 → L1 → … → Ln-1 → Ln`,  
the goal is to **reorder the list** to:  
`L0 → Ln → L1 → Ln-1 → L2 → Ln-2 → …`

The reordering must be done **in-place** — meaning that no new nodes are created, and only the existing node links are rearranged.

---

## Approach

The algorithm works in three major steps:

1. **Find the middle of the list**
    - Use a slow and fast pointer.
    - When the fast pointer reaches the end, the slow pointer will be at the midpoint.

2. **Reverse the second half**
    - Split the list into two halves at the midpoint.
    - Reverse the second half using an iterative approach.

3. **Merge the two halves**
    - Alternate nodes from the first and second halves to get the reordered list.

### Example
Input 1 → 2 → 3 → 4 → 5 → 6
Output:1 → 6 → 2 → 5 → 3 → 4

---

## Files
L13-Reorder-List/
├── pom.xml
├── README.md
├── src/main/java/edu/touro/mcon264/l13_reorder_list/Solution.java
└── src/test/java/edu/touro/mcon264/l13_reorder_list/SolutionTest.java

### `Solution.java`
Implements the `reorderList` method and helper methods:
- `reverseList(ListNode head)` – reverses a linked list
- `mergeLists(ListNode l1, ListNode l2)` – merges two lists in alternating order

### `SolutionTest.java`
Contains parameterized JUnit 5 tests verifying both **odd** and **even-length** lists are reordered correctly.

---

## How to Run Tests

### Option 1: IntelliJ
1. Open the project in IntelliJ.
2. Right-click `SolutionTest.java`.
3. Click **Run 'SolutionTest'**.
4. All tests should pass ✅

### Option 2: Maven
If you prefer command line:
```bash
mvn test




