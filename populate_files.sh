#!/usr/bin/env bash
set -Eeuo pipefail

# Script to populate starter files for DS questions.
# Usage:
#   bash populate_files.sh [--force] [--parent]
#
# Assumptions:
# - ds-starter/<MODULE>/src/... directories already exist (from your dir scaffold).
#
# Flags:
#   --force   overwrite existing files
#   --parent  also create a root multi-module parent pom.xml

FORCE=0
for arg in "$@"; do
  case "$arg" in
    --force)  FORCE=1 ;;
    *) echo "Unknown arg: $arg" >&2; exit 2 ;;
  esac
done

ROOT="ds-starter"

# Ensure the root directory exists before creating files
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
  "L9-Palindrome-LinkedList|Palindrome Linked List|Check if list reads the same forward/backward.|Middle split, reverse half, restore list|Medium-Hard|Hana Fogarty"
  "L10-Flatten-Multilevel|Flatten Multilevel Linked List|Flatten nodes with child pointers.|DFS with stack/recursion, pointers|Hard|"
  "L13-Reorder-List|Reorder List (L0→Ln→L1→Ln-1…)|Alternate from front/back in-place.|Middle split, reverse second half, merge|Medium|Tehilla Sebrow"
  "C1-Stack-Complexity|Stack Complexity & Trade-offs|Analyze push/pop/peek complexities and memory use.|Asymptotics, array vs. list|Easy|Covered"
  "C2-LinkedList-Pitfalls|Linked List Pitfalls|Discuss null checks, head/tail bugs, memory issues.|Error handling, testing|Easy-Medium|Covered"
)

ensure_file() {
  local path="$1"
  local content="$2"
  mkdir -p "$(dirname "$path")"
  if [[ -e "$path" && $FORCE -eq 0 ]]; then
    echo "skip (exists): $path"
    return 0
  fi
  printf '%s' "$content" > "$path"
  echo "wrote: $path"
}

to_pkg() {
  # Convert to lowercase, replace hyphens with underscores, remove other non-alphanum
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's/-/_/g; s/[^a-z0-9_]+//g'
}

# ----- Root files -----
ensure_file "$ROOT/.gitignore" "$(cat <<'EOF'
target/
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
release.properties
.idea/
*.iml
.vscode/
.DS_Store
EOF
)"

ensure_file "$ROOT/README.md" "$(cat <<'EOF'
# Data Structures — Stacks & Linked Lists (Starter)

This repo contains one Maven project per question in its own subdirectory.

## Build & Test a single module
```bash
mvn -q -f <MODULE_DIR>/pom.xml test
```
EOF
)"

for mod in "${MODULES[@]}"; do
  IFS='|' read -r mod_dir mod_name mod_desc mod_topics mod_level mod_owner <<< "$mod"
  mod_path="$ROOT/$mod_dir"
  # derive a module-specific package id and group id so each module is an independent Maven project
  mod_pkg="$(to_pkg "$mod_dir")"
  mod_group="edu.touro.mcon264.${mod_pkg}"
  pom_content="$(cat <<EOF
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>${mod_group}</groupId>
  <artifactId>${mod_dir}</artifactId>
  <name>${mod_name}</name>
  <description>${mod_desc}</description>
  <version>1.0-SNAPSHOT</version>
  <properties>
    <maven.compiler.source>21</maven.compiler.source>
    <maven.compiler.target>21</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
  <dependencies>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter</artifactId>
      <version>5.10.2</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-surefire-plugin</artifactId>
        <version>3.2.5</version>
        <configuration>
          <useModulePath>false</useModulePath>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
EOF
)"
  ensure_file "$mod_path/pom.xml" "$pom_content"

  # --- Add Solution.java and SolutionTest.java placeholders ---
  pkg="edu.touro.mcon264.$(to_pkg "$mod_dir")"
  pkg_dir="$(echo "$pkg" | tr . /)"
  main_dir="$mod_path/src/main/java/$pkg_dir"
  test_dir="$mod_path/src/test/java/$pkg_dir"

  echo "DEBUG: main_dir=$main_dir"
  echo "DEBUG: test_dir=$test_dir"

  mkdir -p "$main_dir"
  mkdir -p "$test_dir"

  ensure_file "$main_dir/Solution.java" "$(cat <<EOF
package $pkg;

public class Solution {
    // TODO: Implement solution for: $mod_name
}
EOF
)"

  ensure_file "$test_dir/SolutionTest.java" "$(cat <<EOF
package $pkg;

import org.junit.jupiter.api.Test;

class SolutionTest {
    @Test
    void testPlaceholder() {
        // TODO: Add tests for $mod_name
    }
}
EOF
)"
done
