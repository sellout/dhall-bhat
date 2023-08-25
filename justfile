# Show the available `just` commands
list:
  just -l

sync-template:
  nix run .#dhall-to-yaml -- \
    --file .config/mustache.dhall \
    --generated-comment \
    --output .config/mustache.yaml \
    --quoted \
  nix run flaky#sync-template

update-generated-json source dest:
  nix run .#dhall-to-json -- --file {{source}} --output {{dest}}

update-generated-yaml source dest:
  nix run .#dhall-to-yaml -- \
    --file {{source}} \
    --generated-comment \
    --output {{dest}}

update-generated-files:
  just update-generated-json .config/renovate.dhall ./renovate.json
  just update-generated-yaml .config/garnix.dhall garnix.yaml
  just update-generated-yaml .config/github/settings.dhall .github/settings.yml
  just update-generated-yaml \
    .config/github/workflows/pages.dhall \
    .github/workflows/pages.yml
