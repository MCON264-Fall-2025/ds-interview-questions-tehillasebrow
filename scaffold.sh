#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="ds-starter"

# Create ROOT first
mkdir -p "$ROOT"

MODULES=(
  "S1-Stack-LIFO|S — Stack (LIFO)|Explain a Stack (LIFO)|ADT, LIFO, use cases|Easy|Covered"
  "S2-Stack-Impl|Implement a Stack (Array vs. List)|Build push/pop/peek using dynamic array and linked list.|Encapsulation, amortized cost, pointers|Medium|Covered"
  "S3-Balanced-Parentheses|Balanced Parentheses|Given ()[]{} string, check if it is balanced.|Parsing, stack usage, edge cases|Medium|Etty"
  "S4-Infix-To-Postfix|Infix → Postfix + Evaluate|Convert expression to postfix; then evaluate using a stack.|Operators, precedence, stacks|Medium|Rebecca Genack"
  "S5-Two-Stacks-One-Array|Two Stacks in One Array|Implement two stacks that grow toward each other.|Memory layout, boundaries, invariants|Medium-Hard|"
  "S6-Sort-Stack-Using-Stacks|Sort a Stack Using Only Stacks|Sort elements with only stack operations (no arrays).|Algorithm design, constraints|Hard|Covered"
  "S7-Min-Stack|Min-Stack (O(1) getMin)|Design stack with push/pop/top/getMin in O(1).|Auxiliary stack, invariants|Medium|Devora Sokol"
  "S10-Browser-History|Browser History with Two Stacks|Design visit(url), back(k), forward(k).|Two-stack simulation, amortized analysis|Medium|"

  "L1-Arrays-vs-LinkedLists|Arrays vs. Linked Lists|Compare access, insertion, deletion, memory.|Asymptotics, locality, trade-offs|Easy|Covered"
  "L2-Implement-SLL|Implement a Singly Linked List|Insert/delete/search; handle head/tail & edge cases.|Pointers, null checks, API design|Medium|Covered"
  "L3-Reverse-LinkedList|Reverse a Linked List (Iterative & Recursive)|Reverse pointers; analyze space/time.|Pointer manipulation, recursion|Medium|Sarah Kind"
  "L4-Detect-Cycle|Detect a Cycle (Floyd’s Tortoise & Hare)|Return true if list contains a loop; explain logic.|Two-pointer technique, invariants|Medium|Chana Mandel, Aviva Robinson"
  "L5-Find-Middle|Find Middle of a List|Return middle node using slow/fast pointers.|Two-pointer technique, parity|Medium|Chana Weiss, Leah Chaya Gluck, Elisheva Goldfarb, Rikki Mann"
  "L6-Merge-Two-Sorted-Lists|Merge Two Sorted Lists|Merge into one sorted list; iterative preferred.|Stable merge, dummy head pattern|Medium|Chaya Goldstein"
  "L7-Remove-Nth-From-End|Remove Nth from End|Delete the Nth node from end in one pass.|Two-pointer window, edge cases (head)|Medium|"
  "L8-Intersection|Intersection of Two Lists|Detect if two lists intersect; return node.|Length alignment, hashing alternative|Medium|Sonya Ginzburg"
  "L9-Palindrome-LinkedList|Palindrome Linked List|Check if list reads same forward/backward.|Middle split, reverse half, restore list|Medium-Hard|Hana Fogarty"
  "L10-Flatten-Multilevel|Flatten Multilevel Linked List|Flatten nodes with child pointers.|DFS with stack/recursion, pointers|Hard|"
  "L13-Reorder-List|Reorder List (L0→Ln→L1→Ln-1…)|Alternate from front/back in-place.|Middle split, reverse second half, merge|Medium|Tehilla Sebrow"

  "C1-Stack-Complexity|Stack Complexity & Trade-offs|Analyze push/pop/peek complexities and memory use.|Asymptotics, array vs. list|Easy|Covered"
  "C2-LinkedList-Pitfalls|Linked List Pitfalls|Discuss null checks, head/tail bugs, memory issues.|Error handling, testing|Easy-Medium|Covered"
)

to_pkg() {
  # Lowercase; non [a-z0-9] -> _
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/_/g'
}

echo "Scaffolding under: $ROOT"
for entry in "${MODULES[@]}"; do
  IFS='|' read -r DIR _ <<< "$entry"   # only need DIR for directories
  PKG="$(to_pkg "$DIR")"

  MOD_DIR="$ROOT/$DIR"
  SRC_MAIN="$MOD_DIR/src/main/java/edu/touro/mcon264/$PKG"
  SRC_TEST="$MOD_DIR/src/test/java/edu/touro/mcon264/$PKG"

  echo "→ Creating: $SRC_MAIN"
  mkdir -p "$SRC_MAIN"
  echo "→ Creating: $SRC_TEST"
  mkdir -p "$SRC_TEST"

#  # Tiny placeholders so dirs are committed
#  : > "$MOD_DIR/.keep"
#  : > "$SRC_MAIN/.keep"
#  : > "$SRC_TEST/.keep"
done

echo "Done. Preview:"
# Requires BSD/mac find; this works on macOS and Linux
find "$ROOT" -type d | sort

