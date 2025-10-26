package edu.touro.mcon264.l13_reorder_list;

// Simple node class for a singly linked list
class ListNode {
    int val;         // holds the number stored in this node
    ListNode next;   // pointer to the next node

    ListNode(int x) {
        val = x;     // set the value when the node is created
    }
}

public class Solution {

    // Rearranges a linked list like this:
    // 1 → 2 → 3 → 4 → 5  becomes  1 → 5 → 2 → 4 → 3
    // Works in-place (no new nodes created)
    public void reorderList(ListNode head) {
        // If list is empty or only has one node, nothing to do
        if (head == null || head.next == null) return;

        // --- Step 1: Find the middle of the list ---
        // Use slow and fast pointers: fast moves 2x faster.
        // When fast hits the end, slow will be halfway.
        ListNode slow = head;
        ListNode fast = head;
        while (fast.next != null && fast.next.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        // --- Step 2: Reverse the second half ---
        // For example: if the list is 1→2→3→4→5
        // slow will stop at 3, and we’ll reverse 4→5 into 5→4
        ListNode second = slow.next; // start of the second half
        slow.next = null;            // cut the list in half
        second = reverseList(second); // reverse the second half

        // --- Step 3: Merge the two halves together ---
        // Combine them one node at a time:
        // 1→2→3 and 5→4 becomes 1→5→2→4→3
        mergeLists(head, second);
    }

    // Helper method to reverse a list and return the new head.
    private ListNode reverseList(ListNode head) {
        ListNode prev = null;
        ListNode curr = head;

        while (curr != null) {
            ListNode nxt = curr.next; // remember next node
            curr.next = prev;         // flip the direction
            prev = curr;              // move prev forward
            curr = nxt;               // move curr forward
        }

        return prev; // prev now points to the new head
    }

    // Helper method that merges two lists like:
    // l1: 1→2→3, l2: 6→5→4 → result: 1→6→2→5→3→4
    private void mergeLists(ListNode l1, ListNode l2) {
        while (l1 != null && l2 != null) {
            ListNode n1 = l1.next;
            ListNode n2 = l2.next;

            l1.next = l2;          // attach one from list2 after list1
            if (n1 == null) break; // if list1 ended, stop
            l2.next = n1;          // attach next node from list1

            // move forward in both lists
            l1 = n1;
            l2 = n2;
        }
    }

    // --- Small demo to see it working ---
    public static void main(String[] args) {
        // Build a simple list: 1 → 2 → 3 → 4 → 5 → 6
        ListNode head = new ListNode(1);
        head.next = new ListNode(2);
        head.next.next = new ListNode(3);
        head.next.next.next = new ListNode(4);
        head.next.next.next.next = new ListNode(5);
        head.next.next.next.next.next = new ListNode(6);

        // Print the original list
        System.out.println("Before reorder:");
        printList(head);

        // Reorder the list
        Solution sol = new Solution();
        sol.reorderList(head);

        // Print the reordered list
        System.out.println("After reorder:");
        printList(head);
    }

    // Helper method to print out the list values nicely
    private static void printList(ListNode head) {
        ListNode curr = head;
        while (curr != null) {
            System.out.print(curr.val);
            if (curr.next != null) System.out.print(" → ");
            curr = curr.next;
        }
        System.out.println();
    }
}
