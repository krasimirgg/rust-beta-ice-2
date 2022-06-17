# rust-beta-ice-2

Example of a rustc ICE for https://github.com/rust-lang/rust/issues/98056 that uses:
* latest bootstrapping rustc 1.62.0-beta.2 
* togehter with "standard" stage0 stdlib sysroot built via x.py.

To repro, `./run-in-docker.sh`:
[
https://gist.github.com/krasimirgg/69af6c35ebbe90d0d1d080831e97ee4c](https://gist.github.com/krasimirgg/b8b5456b970aba99ea6f4bcf64a6b2e9)
```
thread 'rustc' panicked at 'invalid enum variant tag while decoding `MacroKind`, expected 0..3'
```
