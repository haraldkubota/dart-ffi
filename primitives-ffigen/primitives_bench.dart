// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:path/path.dart' as path;

import 'primitives_bindings.dart' as pr;

var prlib;

void main() {
  int sum, start, end;

  // Open the dynamic library
  var libraryPath = path.join(
      Directory.current.path, 'primitives_library', 'libprimitives.so');
  if (Platform.isMacOS) {
    libraryPath = path.join(
        Directory.current.path, 'primitives_library', 'libprimitives.dylib');
  }
  if (Platform.isWindows) {
    libraryPath = path.join(
        Directory.current.path, 'primitives_library', 'Debug', 'primitives.dll');
  }

  prlib = pr.NativeLibrary(ffi.DynamicLibrary.open(libraryPath));

  // FFI
  // sum = doBenchFFIPlusOne(10000000);
  start = DateTime.now().millisecondsSinceEpoch;
  // calls int sum(int a, int b);
  sum = doBenchFFIPlusOne(100000000);
  end = DateTime.now().millisecondsSinceEpoch;
  print('sum=$sum');
  print('time in ms: ${end - start}');

  // sum = doBenchFFI(10000000);
  start = DateTime.now().millisecondsSinceEpoch;
  // calls int sum(int a, int b);
  sum = doBenchFFI(100000000);
  end = DateTime.now().millisecondsSinceEpoch;
  print('sum=$sum');
  print('time in ms: ${end - start}');

  // Native Dart

  // sum = doBenchPlusOne(10000000);
  start = DateTime.now().millisecondsSinceEpoch;
  sum = doBenchPlusOne(100000000);
  end = DateTime.now().millisecondsSinceEpoch;
  print('sum=$sum');
  print('time in ms: ${end - start}');

  // sum = doBench(10000000);
  start = DateTime.now().millisecondsSinceEpoch;
  sum = doBench(100000000);
  end = DateTime.now().millisecondsSinceEpoch;
  print('sum=$sum');
  print('time in ms: ${end - start}');
}

int doBenchFFI(n) {
  var sum = 0;
  for (var i = 0; i < n; ++i) {
    sum += prlib.sum(i, i) as int;
  }
  return sum;
}

int doBenchFFIPlusOne(n) {
  int sum = 0;
  for (int i = 0; i < n; ++i) {
    sum = sum + prlib.plusOne(i) as int;
  }
  return sum;
}

int doBench(n) {
  var sum = 0;
  for (var i = 0; i < n; ++i) {
    sum += sum2(i, i);
  }
  return sum;
}

int doBenchPlusOne(n) {
  var sum = 0;
  for (var i = 0; i < n; ++i) {
    sum += plusOne(i);
  }
  return sum;
}

int sum2(int n1, int n2) {
  return n1 + n2;
}

int plusOne(int n) {
  return n + 1;
}
