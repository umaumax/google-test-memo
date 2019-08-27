# google-test-memo

## how to gen gtest one cc,h lib
```
git clone https://github.com/google/googletest
cd googletest/googletest/scripts/
python ./fuse_gtest_files.py out/
# maybe both python2 and python3 are ok
```

```
out
└── gtest
    ├── gtest-all.cc
    └── gtest.h

1 directory, 2 files
```

## how to gen gtest and gmock one cc,h lib
```
git clone https://github.com/google/googletest
cd googletest/googlemock/scripts/
python2 ./fuse_gmock_files.py out
# only for python2
```

```
out
├── gmock
│   └── gmock.h
├── gmock-gtest-all.cc
└── gtest
    └── gtest.h

2 directories, 3 files
```

## how to use
NOTE: header only libではなく，ファイルをまとめた状態となる

### compile
```
g++ -std=c++11 -c -I./googletest/googletest/scripts/out/ ./googletest/googletest/scripts/out/gtest/gtest-all.cc -o gtest.o
ar r libgtest.a gtest.o

# gen pch
g++ -std=c++11 -x c++-header ./googletest/googletest/scripts/out/gtest/gtest.h -o gtest.h.pch

g++ -std=c++11 -c -I./googletest/googlemock/scripts/out/ ./googletest/googlemock/scripts/out/gmock-gtest-all.cc -o gtest.o
ar r libgtest.a gtest.o
cp libgtest.a libgmock

# gen pch
g++ -std=c++11 -x c++-header googletest/googlemock/scripts/out/gtest/gtest.h -o gtest.h.pch
g++ -std=c++11 -x c++-header googletest/googlemock/scripts/out/gmock/gmock.h -o gmock.h.pch

# NOTE: only one pch file
g++ -std=c++11 -x c++-header <(cat googletest/googlemock/scripts/out/gtest/gtest.h googletest/googlemock/scripts/out/gmock/gmock.h) -o gtest.h.pch
```

### gtest only
```
g++ -std=c++11 gtest_main.cpp -I./googletest/googletest/scripts/out/ ./googletest/googletest/scripts/out/gtest/gtest-all.cc

# or

g++ -std=c++11 gtest_main.cpp -I./googletest/googletest/scripts/out/ -L. -lgtest
# 0.71s user 0.08s system 97% cpu 0.812 total

----

# two ways
g++ -std=c++11 gtest_main.cpp -include gtest.h -I./googletest/googletest/scripts/out/ -L. -lgtest
# 0.32s user 0.06s system 97% cpu 0.393 total
# or
g++ -std=c++11 gtest_main.cpp -include-pch gtest.h.pch -I./googletest/googletest/scripts/out/ -L. -lgtest
# 0.30s user 0.06s system 91% cpu 0.389 total
```

### both gtest and gmock
```
g++ -std=c++11 gtest_gmock_main.cpp -I./googletest/googlemock/scripts/out/ ./googletest/googlemock/scripts/out/gmock-gtest-all.cc

# or

g++ -std=c++11 gtest_gmock_main.cpp -I./googletest/googlemock/scripts/out/ -L. -lgtest -lgmock
# 1.24s user 0.12s system 91% cpu 1.478 total

----

# NOTE: -include can treat only one pch file
# two ways
g++ -std=c++11 gtest_gmock_main.cpp -include gtest.h -I./googletest/googlemock/scripts/out/ -L. -lgtest -lgmock
# 0.74s user 0.09s system 93% cpu 0.892 total
# or
g++ -std=c++11 gtest_gmock_main.cpp -include-pch gtest.h.pch -I./googletest/googlemock/scripts/out/ -L. -lgtest
# 0.71s user 0.09s system 95% cpu 0.847 total
----

```

## NOTE
* Q: ホストのシステムにinstallしてある`gtest`を使っているのでは?
* A: `-M`や`-MM`を利用して，includeしたheaderの一覧を確認する
```
g++ -std=c++11 main.cpp -I./googletest/googletest/scripts/out/ -L. -lgtest -M
```

