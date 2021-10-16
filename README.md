# Dart with FFI via ffigen

## primitives-ffigen/

I found no nice example to generate FFI bindings with ffigen for Dart.
In particular https://github.com/dart-lang/samples/tree/master/ffi/primitives was confusing: while it worked, the bindings were created manually and not via ffigen.
I was curious why, so I tried to use ffigen instead to re-create those manual bindings. The main program had to be modified (simplified) a bit to make everything work, but in the end, it was much easier to understand and easier to maintain in case the C library will be updated.

This repo is the result: It's basically the primitives example from above GitHub repo, but using ffigen.

```
❯ cd primitives-ffigen
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
