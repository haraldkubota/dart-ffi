// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

import 'primitives_bindings.dart' as pr;

void main() {
  // Open the dynamic library
  var libraryPath = path.join(
      Directory.current.path, 'primitives_library', 'libprimitives.so');
  if (Platform.isMacOS) {
    libraryPath = path.join(
        Directory.current.path, 'primitives_library', 'libprimitives.dylib');
  }
  if (Platform.isWindows) {
    libraryPath = path.join(
        Directory.current.path, 'primitives_library', 'Debug', 'primtives.dll');
  }

  final prlib = pr.NativeLibrary(ffi.DynamicLibrary.open(libraryPath));

  // calls int sum(int a, int b);
  print('3 + 5 = ${prlib.sum(3, 5)}');

  // calls int subtract(int *a, int b);
  // Create a pointer
  final p = calloc<ffi.Int32>();
  // Place a value into the address
  p.value = 3;

  print('3 - 5 = ${prlib.subtract(p, 5)}');

  // Free up allocated memory.
  calloc.free(p);

  // calls int *multiply(int a, int b);
  final resultPointer = prlib.multiply(3, 5);
  // Fetch the result at the address pointed to
  final int result = resultPointer.value;
  print('3 * 5 = ${result}');

  // Free up allocated memory. This time in C, because it was allocated in C.
  prlib.free_pointer(resultPointer);

  // example calling a C function with varargs
  // calls int multi_sum(int nr_count, ...);
  // print('3 + 7 + 11 = ${prlib.multi_sum(3, 3, 7, 11)}');
}
