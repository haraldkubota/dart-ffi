// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:ffi/ffi.dart';

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

  prlib = pr.Primitive(ffi.DynamicLibrary.open(libraryPath));

  start = DateTime.now().millisecondsSinceEpoch;
  sum = doBenchFFIPlusOne(100000000);
  end = DateTime.now().millisecondsSinceEpoch;
  print('sum=$sum');
  // print('time in ms: ${end - start}');

}

int doBenchFFIPlusOne(n) {
  int sum = 0;
  for (int i = 0; i < n; ++i) {
    // the following line works:
    // sum = sum + prlib.plusOne(i) as int;
    // Bus this one should too yet it does not:
    sum = sum + prlib.plusOne(i);
  }
  return sum;
}

