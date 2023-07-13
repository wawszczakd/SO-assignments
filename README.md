# SO Assignments

This repository contains my solutions to assignments from the course "Operating
Systems".

## Overview

SO stands for "Systemy Operacyjne" in Polish, which translates to "Operating
Systems". This repository includes my solutions to the assignments from this
course. The first two assignments were related to assembly language, while the
next three involved modifying the MINIX source code. I completed the first three
assignments, which were sufficient to pass the course.

## Assignment Descriptions

Here is a list of short assignment descriptions:

1. **Inverting Permutations in Assembly Language**: This assignment involves
implementing a function in assembly language that computes the inverse of a
permutation in-place. The function is callable from C and takes a non-empty
array of integers and its size as arguments. The function verifies whether the
array represents a valid permutation within the range of `[0, n - 1]`.

2. **Distributed Stack Machine Simulator**: This assignment requires
implementing a simulator for a distributed stack machine in assembly language.
The simulator consists of `N` cores, each executing computations specified by
ASCIIZ strings. The operations include addition, multiplication, negation, stack
manipulation, and synchronization between cores. The result is the value at the
top of the stack after the computation is executed.

3. **Money Transfers in MINIX**: The objective of this assignment is to
implement money transfers between processes in the MINIX operating system.
Processes start with an initial balance and can perform mutual money transfers,
subject to certain conditions. The goal is to ensure successful transfers while
preventing money laundering and maintaining valid account balances.

Please refer to the respective assignment directories for detailed solutions.
