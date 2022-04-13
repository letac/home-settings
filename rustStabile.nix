with import <nixpkgs> {}; 
let
  myrust = (rustChannels.stable.rust.override {
    extensions = [ 
    "rust-src" 
    "rust-analysis"
    "llvm-tools-preview"
  ]; });
in
  myrust
