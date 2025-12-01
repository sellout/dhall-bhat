### All available options for this file are listed in
### https://sellout.github.io/project-manager/options.xhtml
{config, ...}: {
  project = {
    name = "dhall-bhat";
    summary = "Tasty meal of Dhall";
  };

  programs.vale.vocab.${config.project.name}.accept = [
    "Bhat"
    "inlined"
    "SHAs"
  ];

  project.file.".dir-locals.el".source = ../emacs/.dir-locals.el;

  services.github.settings.repository.topics = [];
}
