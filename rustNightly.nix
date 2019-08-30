with import <nixpkgs> {}; 
let
  myrust = (rustChannels.nightly.rust.override { extensions = [ 
    "rust-src" 
    "rls-preview"
    "rust-analysis"
  ]; });
in
  myrust
