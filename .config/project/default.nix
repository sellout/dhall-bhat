{
  config,
  flaky,
  lib,
  pkgs,
  supportedSystems,
  ...
}: {
  project = {
    name = "dhall-bhat";
    summary = "Tasty meal of Dhall";

    devPackages = [
      pkgs.dhall
      pkgs.dhall-docs
      pkgs.dhall-lsp-server
    ];
  };

  ## dependency managerment
  services.renovate.enable = true;

  ## development
  programs = {
    direnv.enable = true;
    # This should default by whether there is a .git file/dir (and whether it’s
    # a file (worktree) or dir determines other things – like where hooks
    # are installed.
    git.enable = true;
  };

  ## formatting
  editorconfig.enable = true;
  programs = {
    treefmt.enable = true;
    vale = {
      enable = true;
      excludes = [
        "./.config/emacs/.dir-locals.el"
        "./.dir-locals.el"
        "./.gitattributes"
        "./.github/settings.yml"
      ];
      vocab.${config.project.name}.accept = [
        "Bhat"
        "inlined"
        "SHAs"
      ];
    };
  };
  project.file.".dir-locals.el".source = ../emacs/.dir-locals.el;

  ## CI
  services.garnix.enable = true;

  ## publishing
  services.flakehub.enable = true;
  services.github.enable = true;
  services.github.settings.repository.topics = [];
}
