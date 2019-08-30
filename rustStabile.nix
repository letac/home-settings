with import <nixpkgs> {}; 
let
  myrust = (rustChannels.stable.rust.override { extensions = [ 
    "rust-src" 
    "rls-preview"
    "rust-analysis"
  ]; });
in
  myrust
