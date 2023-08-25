{-|
These settings are synced to GitHub by https://probot.github.io/apps/settings/
-}
-- See https://docs.github.com/en/rest/reference/repos#update-a-repository for all available settings.
{ repository =
  { name = "dhall-bhat"
  , description = "Tasty meal of Dhall"
  , private = False
  , has_issues = True
  , has_projects = False
  , has_wiki = True
  , has_downloads = False
  , default_branch = "main"
  , allow_squash_merge = False
  , allow_merge_commit = True
  , allow_rebase_merge = False
  , delete_branch_on_merge = True
  , merge_commit_title = "PR_TITLE"
  , merge_commit_message = "PR_BODY"
  , enable_automated_security_fixes = True
  , enable_vulnerability_alerts = True
  }
, labels =
  [ { name = "bug", color = "#d73a4a", description = "Something isn’t working" }
  , { name = "documentation"
    , color = "#0075ca"
    , description = "Improvements or additions to documentation"
    }
  , { name = "enhancement"
    , color = "#a2eeef"
    , description = "New feature or request"
    }
  , { name = "good first issue"
    , color = "#7057ff"
    , description = "Good for newcomers"
    }
  , { name = "help wanted"
    , color = "#008672"
    , description = "Extra attention is needed"
    }
  , { name = "question"
    , color = "#d876e3"
    , description = "Further information is requested"
    }
  ]
, branches =
  [ { name = "main"
    , protection =
      { required_pull_request_reviews = None {}
      , required_status_checks =
        { strict = False
        , contexts =
          [ "check format [aarch64-darwin]"
          , "check format [aarch64-linux]"
          , "check format [x86_64-linux]"
          , "devShell default [aarch64-darwin]"
          , "devShell default [aarch64-linux]"
          , "devShell default [x86_64-linux]"
          , "homeConfiguration aarch64-darwin-dhall-bhat-example"
          , "homeConfiguration aarch64-linux-dhall-bhat-example"
          , "homeConfiguration x86_64-linux-dhall-bhat-example"
          , "package default [aarch64-darwin]"
          , "package default [aarch64-linux]"
          , "package default [x86_64-linux]"
          , "package dhall-bhat [aarch64-darwin]"
          , "package dhall-bhat [aarch64-linux]"
          , "package dhall-bhat [x86_64-linux]"
          ]
        }
      , enforce_admins = True
      , required_linear_history = False
      , allow_force_pushes = False
      , restrictions.apps = [] : List {}
      }
    }
  ]
, pages = { build_type = "workflow", source.branch = "master" }
}
