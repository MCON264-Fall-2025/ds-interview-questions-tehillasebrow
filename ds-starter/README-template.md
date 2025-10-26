#  README Template

##  Problem Statement
Describe the problem in your own words.
Example:
> Given the head of a singly linked list, determine whether the list contains a cycle.
> If a cycle exists, return both the index of the node where the cycle starts and the cycle length.

---

##  Assumptions
State any assumptions you made while solving the problem.
Examples:
- The list may be empty (`head = null`).
- Each node contains an integer value and a reference to the next node.
- You may not modify the list structure.
- Your algorithm must use O(1) extra space.

*(Add or adjust as needed for your own implementation.)*

---

##  Conceptual Solution
Explain **how** your algorithm works at a high level — no code, just logic.

Example outline:
1. **Cycle detection:**
   Use two pointers (`slow` and `fast`) that move at different speeds.
   If they ever meet, there is a cycle.
2. **Cycle length:**
   Once a meeting point is found, move one pointer around the loop to count its length.
3. **Entry node:**
   Reset one pointer to the head, and move both one step at a time until they meet again — that’s the start of the cycle.

*(Replace this with your own summary in your own words.)*

---

##  Example
Provide one illustrative example of your choice.
Include the input, expected output, and a short explanation.

Example:
