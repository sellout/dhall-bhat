{ builds =
  { -- TODO: Remove once garnix-io/garnix#285 is fixed.
    exclude =
    [ "homeConfigurations.x86_64-darwin-dhall-bhat-example" ]
  , include = [ "*.*", "*.*.*" ]
  }
}
