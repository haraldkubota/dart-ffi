# Dart with FFI vi ffigen

I found no nice example using ffigen to generate FFI bindings for Dart.
In particular https://github.com/dart-lang/samples/tree/master/ffi/primitives was confusing. While it worked, ffigen was not used to create the bindings. And once I used ffigen, the main program had to be modified (simplified) a bit.

This repo is the result: It's basically the primitives example from above GitHub repo, but using ffigen.

```
❯ cd primitives_library
❯ cmake .
❯ make
❯ cd ..
❯ dart pub get
❯ dart run ffigen
❯ dart test
❯ dart primitives.dart
3 + 5 = 8
3 - 5 = -2
3 * 5 = 15
```
