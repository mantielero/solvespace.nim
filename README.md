# About
**solvespace.nim** is a library wrappeing SolveSpace's geometric constraint solver. This enables the calculation of the geometry by setting conditions such as: distance between points, distance between line and point, and many others.

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