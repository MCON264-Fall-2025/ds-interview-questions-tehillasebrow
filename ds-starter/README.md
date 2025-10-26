# Interview Questions Assignment – Example Submission

This repository demonstrates how to **submit your Data Structures assignment** correctly.
It includes a sample Java solution and a JUnit 5 test class so you can see exactly what your
project structure and commit should look like.

---

## Repository Layout
Modules are organized by problem.
Each module contains the following files:
```
problem-name/
── pom.xml
── README.md
├── src/main/java/.../Solution.java
└── src/test/java/.../SolutionTest.java
```

###  `Solution.java`
Contains your implementation for the problem described in the assignment.  
You will **edit this file only** to implement your logic.

###  `SolutionTest.java`
Contains the unit tests.  
You can use it locally to verify that your implementation works before committing.

---

##  Assignment Goal

Provide solution in **`Solution.java`** so that all unit tests
in **`SolutionTest.java`** pass.

Each problem will specify:
- the method signature,
- the expected input and output,
- and any constraints (e.g., time or space complexity).

You are expected to:
1. **Read the problem description** on Canvas .
2. **Implement your solution** inside `Solution.java`.
3. **Run the unit tests** locally using IntelliJ, Maven, or the command line.
4. **Add README.md** following the README.md template provided.
4. **Commit and push** your changes to your GitHub Classroom repository.

---

##  Running Tests Locally

You can use **JUnit 5** with either Maven or IntelliJ.

###  Option 1: IntelliJ
- Open the repo in IntelliJ.
- Right-click `SolutionTest.java`.
- Choose **Run 'SolutionTest'**.
- All tests should pass 

### Option 2: Command Line (Maven)
If you have Maven installed:
```bash
mvn test
```
Clone the repository you received from GitHub Classroom.
Open project in IntelliJ in the directory for your problem module.
Implement your solution in Solution.java.
Run tests locally to confirm correctness.

Stage, commit, and push your changes:

git add README.md 
git add -u
git commit -m "Implemented detectCycleInfo solution" ( example message )
git push origin master


GitHub Classroom will automatically create a pull request to the feedback branch.

Take a screenshot of your passing unit tests.

Submit the screenshot and the PR link in Canvas.
Example Output

When all tests pass, you should see something like this:

```
-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running linkedlist.DetectCycleInfoTest
Tests run: 3, Failures: 0, Errors: 0, Skipped: 0
-------------------------------------------------------
BUILD SUCCESS
-------------------------------------------------------
```

Tips

Don’t rename files or change package names.

Always push your final commit before the deadline.

You can rerun tests as many times as you want locally.

Provide descriptive tests — they often describe the expected behavior.
