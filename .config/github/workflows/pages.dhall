let With = { command : Optional Text, extra_nix_config : Optional Text }

let Step =
      { name : Text, id : Optional Text, uses : Text, `with` : Optional With }

in  { name = "Deploy  modules & generated docs to Pages"
    , on =
      {   -- Runs on pushes targeting the default branch
          push
        . branches
        =
        [ "master" ]
      , workflow_dispatch = [] : List {}
      }
    , permissions = { contents = "read", pages = "write", id-token = "write" }
    , concurrency = { group = "pages", cancel-in-progress = False }
    , jobs =
      { build =
        { runs-on = "ubuntu-latest"
        , steps =
          [ { name = "Checkout"
            , id = None Text
            , uses = "actions/checkout@v3"
            , `with` = None With
            }
          , { name = "Setup Pages"
            , id = None Text
            , uses = "actions/configure-pages@v3"
            , `with` = None With
            }
          , { name = "Install Nix"
            , id = None Text
            , uses = "cachix/install-nix-action@v20"
            , `with` = Some
              { command = None Text
              , extra_nix_config = Some
                  ''
                  extra-trusted-public-keys = cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=
                  extra-substituters = https://cache.garnix.io
                  ''
              }
            }
          , { name = "Nix Develop"
            , id = None Text
            , uses = "lriesebos/nix-develop-command@v1"
            , `with` = Some
              { command = Some
                  ''
                  dhall-docs \
                    --input ./dhall \
                    --base-import-url "https://sellout.github.io/dhall-bhat" \
                    --package-name "dhall-bhat"
                  ## We copy here to fix the permissions from the Nix symlinks
                  cp -r ./docs ./_site
                  chmod --recursive +rwx ./_site
                  cp -r ./dhall/* ./_site/
                  ''
              , extra_nix_config = None Text
              }
            }
          , { name = "Upload artifact"
            , id = None Text
            , uses = "actions/upload-pages-artifact@v2"
            , `with` = None With
            }
          ]
        }
      , deploy =
        { environment =
          { name = "github-pages"
          , url = "\${{ steps.deployment.outputs.page_url }}"
          }
        , runs-on = "ubuntu-latest"
        , needs = "build"
        , steps =
          [ { name = "Deploy to GitHub Pages"
            , id = Some "deployment"
            , uses = "actions/deploy-pages@v2"
            , `with` = None With
            }
          ]
        }
      }
    }
