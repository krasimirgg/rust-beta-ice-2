#!/bin/bash
set -eux

RUSTC=/rust/build/x86_64-unknown-linux-gnu/stage0/bin/rustc
STAGE0_SYSROOT=/rust/build/x86_64-unknown-linux-gnu/stage0-sysroot

function run() {
  $RUSTC --version
  $RUSTC --print=sysroot
  $RUSTC serde_derive/lib.rs '--crate-name=serde_derive' '--crate-type=proc-macro' '--out-dir=outdir' '--emit=link' '--target=x86_64-unknown-linux-gnu'
  $RUSTC serde/lib.rs '--crate-name=serde' '--crate-type=rlib' '--out-dir=outdir' '--emit=link' '--target=x86_64-unknown-linux-gnu' '--extern=serde_derive=outdir/libserde_derive.so'
  $RUSTC gsgdt/lib.rs '--crate-name=gsgdt' '--crate-type=rlib' '--out-dir=outdir' '--emit=link' '--target=x86_64-unknown-linux-gnu' '--edition=2018' '--extern=serde=outdir/libserde.rlib' '-Ldependency=outdir'
}

echo '#### 1. Running with beta rustc and beta sysroot'
run

echo '#### 2. Running with beta rust and stage0 sysroot'
RUSTC="$RUSTC --sysroot=$STAGE0_SYSROOT"
run
