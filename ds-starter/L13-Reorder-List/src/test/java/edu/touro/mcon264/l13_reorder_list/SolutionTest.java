package edu.touro.mcon264.l13_reorder_list;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.MethodSource;
import java.util.stream.Stream;

class ReorderListTest {

    // This method provides the different test cases for the parameterized test below.
    // Each test case has an input list (head node) and the expected final order of values.
    static Stream<org.junit.jupiter.params.provider.Arguments> provideLists() {
        return Stream.of(
                // Even number of nodes: 1 → 2 → 3 → 4 → 5 → 6
                // After reordering, it should be: 1 → 6 → 2 → 5 → 3 → 4
                org.junit.jupiter.params.provider.Arguments.of(
                        buildList(1, 2, 3, 4, 5, 6),
                        new int[]{1, 6, 2, 5, 3, 4}
                ),

                // Odd number of nodes: 1 → 2 → 3 → 4 → 5
                // After reordering: 1 → 5 → 2 → 4 → 3
                org.junit.jupiter.params.provider.Arguments.of(
                        buildList(1, 2, 3, 4, 5),
                        new int[]{1, 5, 2, 4, 3}
                ),

                // Single node list: 1
                // Should stay exactly the same
                org.junit.jupiter.params.provider.Arguments.of(
                        buildList(1),
                        new int[]{1}
                )
        );
    }

    @ParameterizedTest
    @MethodSource("provideLists")
    void testReorderList(ListNode head, int[] expected) {
        // Create the reorder list solution
        Solution rl = new Solution();

        // Call the reorder method on our linked list
        rl.reorderList(head);

        // Now walk through the list and make sure the order matches what we expected
        ListNode curr = head;
        for (int val : expected) {
            // Check that each node’s value is exactly what we predicted
            Assertions.assertEquals(val, curr.val);

            // Move to the next node
            curr = curr.next;
        }

        // When we're done, there shouldn't be any leftover nodes
        Assertions.assertNull(curr);
    }

    // Helper method to quickly build a linked list from an array of numbers
    private static ListNode buildList(int... vals) {
        if (vals.length == 0) return null; // if nothing was passed, return an empty list
        ListNode head = new ListNode(vals[0]); // first value becomes the head
        ListNode current = head;               // keep a pointer so we can chain new nodes
        for (int i = 1; i < vals.length; i++) {
            current.next = new ListNode(vals[i]); // link the next node
            current = current.next;               // move forward
        }
        return head; // return the start of the list
    }
}
