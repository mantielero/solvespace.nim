# About
**solvespace.nim** is a library wrapping SolveSpace's geometric constraint solver. This enables the calculation of the geometry by setting conditions such as: distance between points, distance between line and point, and many others.

This could be used in conjunction with [occt.nim](https://github.com/mantielero/occt.nim).


# Support
https://github.com/realthunder/solvespace/blob/python/exposed/DOC.txt

Support on [SolveSpace](https://web.libera.chat/#solvespace).

http://solvespace.com - 

https://github.com/solvespace/solvespace - 

https://libera.irclog.whitequark.org/solvespace

https://github.com/KmolYuan/python-solvespace/issues/4


# License
The SolveSpace library is distributed as GPLv3 as stated [here](https://solvespace.com/library.pl):

> SolveSpace is distributed under the GPLv3, which permits most use in free software but generally forbids linking the library with proprietary software. For commercial support and licensing, please contact us.


My code is released as MIT License, but you need to fulfill SolveSpace own license requirements.


# Testing
Just run:
```bash
$ testament p "tests/**/test*.nim"
```

# TODO
- [ ] To improve `test_distance.nim`
- [ ] To improve `test_length.nim`
  - [ ] Equal distance from a point to two different segments (group 4). Solvespace bug?
  - [ ] Equal length between segment and arc of circle not working (group 5). Solvespace bug?
- [ ] To improve `test_on.nim`: it doesn't do what I though it would do
  - [ ] Point on cylinder doesn't seem to be working (group 1). Solvespace bug?
- [ ] `test_orientation.nim`: requires vector product
  - [ ] It looks like a bug in SolveSpace: 
      ```bash
File ./src/constrainteq.cpp, line 215, function ModifyToSatisfy:
Assertion failed: l.n == 1.
Message: Expected constraint to generate a single equation.
      ```
- [-] To improve `test_symmetric.nim`
  - [X] NOTE: it looks like the documentation is wrong. I think it is symmetric horizontally/vertically not regarding the horizontal/vertical axis as stated in the documentation.
  - [ ] Symmetric regarding a line doesn't seem to be working
- [ ] To improve `test_tangent.nim`
  - [ ] The tangent between segment - arc of circle doesn't seem to work
  