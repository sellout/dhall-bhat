# Dhall Bhat

[![built with garnix](https://img.shields.io/endpoint?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2Fsellout%2Fdhall-bhat)](https://garnix.io/repo/sellout/dhall-bhat)

Tasty meal of Dhall

A large number of functional and categorical things.

We currently require Dhall 1.18.0, and try to support newer releases as much as possible.

Imports are available at https://sellout.github.io/dhall-bhat/ – the paths are the same as the documentation paths, but without the `.html` suffix.

## documentation

API docs are on [GitHub Pages](https://sellout.github.io/dhall-bhat).

## style

Dhall is still a young community, so the style is still evolving. Here’s how we’re currently doing things in Dhall Bhat.

### group expressions by type

It’s common to define a type and a number of related expressions for it. When you do this, we create a directory named for the type, with everything related to it in that directory.

- `Foo` (the name of the type, a directory)
  - `Type` (the file containing the type itself, capitalized)
  - `functor` (file containing a Functor instance for this type, lowercase)
  - `op` (some operation defined on this type, lowercase)
  - `terms.dhall` (file containing a record of all the terms related to this type)

### use `dhall format` and `dhall lint`

In this repository, those are accomplished with `nix fmt`, which additionally formats everything else in here.

**NB**: `dhall format` (and `lint`) currently [removes all comments from the file](https://github.com/dhall-lang/dhall-haskell/issues/145) except for a single “heading” comment. So be careful that you don’t lose important comments this way.

### don’t repeat names

In Dhall, the name of an expression is given by the file it’s in. Most of us aren’t used to this style, so we tend to give it a name _within_ the file, e.g.

```dhall
let foo = <the real expression>
in  foo
```

But this is a place that becomes easy to get out of sync – if the file is renamed, the name used within the file is no longer correct, so if you’re looking at the contents and trying to use the expression, it can be confusing that you can’t actually use that name. Instead, just rely on the file name, and let the expression be “bare” within the file.

However, when you have assertions (which double as examples in the docs, you effectively need to bind the primary expression. It looks like

```dhall
let foo =  <the real expression>
let example0 = assert : foo 3 ≡ 9
let example1 = assert : foo 2 ≡ 4
in  foo
```

The repetition here is useful because the name ends up in the docs and the expressions are tested.

### create bindings for imports

It’s often tempting to use imports directly inlined, like `(./Foo/functor).map`, but as we move toward freezing our imports, we need to add SHAs, which make inlined imports difficult to read. So, pre-emptively, we try to create bindings to avoid having SHAs littered throughout the expression.

### minimal top-level types

In general, we don’t have explicit types on expressions. Since there is only a single top-level expression per file, it’s relatively easy for editors to display the result of `dhall type` to present a type annotation on the fly.

The exception to this is type class instances, which end up looking like

```dhall
let Foo = ../Foo/Type
let Bar = ./Type
in  { operation = ...
    , anotherOperation = ...
    } : Foo Bar
```

This is because it isn’t enough that they have a valid type, but that type needs to align with the type class definition to be applicable where that type class is required.

### don’t define type class methods in their own files

Rather than making each definition its own file, we tend to define methods within the instance. One reason for this is that there are often _multiple_ instances of a type class for a single type, so it’s not always clear which one should be “blessed” at the top-level. For example, having two incompatible `Applicative` instances isn’t unusual, so defining a “./Foo/ap” can be confusing. See “Either/Sequential/applicative” and “Either/Parallel/applicative” for an example of how multiple instances are defined.

It’s also the case that those methods don’t have meaning outside of the laws that relate them to the type class, so we constrain the definition to where those laws apply. So we keep those names scoped to the classes, and then also expose them through `./Foo/terms.dhall` module that provides names for all operations of a type.

## development environment

We recommend the following steps to make working in this repository as easy as possible.

### `direnv allow`

This command ensures that any work you do within this repository happens within a consistent reproducible environment. That environment provides various debugging tools, etc. When you leave this directory, you will leave that environment behind, so it doesn’t impact anything else on your system.

### `git config --local include.path ../.cache/git/config`

This will apply our repository-specific Git configuration to `git` commands run against this repository. It’s lightweight (you should definitely look at it before applying this command) – it does things like telling `git blame` to ignore formatting-only commits.

## building & development

Especially if you are unfamiliar with the Dhall ecosystem, there is a Nix build (both with and without a flake). If you are unfamiliar with Nix, [Nix adjacent](...) can help you get things working in the shortest time and least effort possible.

### if you have `nix` installed

`nix build` will build and test the project fully.

`nix develop` will put you into an environment where the traditional build tooling works. If you also have `direnv` installed, then you should automatically be in that environment when you're in a directory in this project.

## versioning

In the absolute, almost every change is a breaking change. This section describes how we mitigate that to offer minor updates and revisions.

## comparisons

Other projects similar to this one, and how they differ.
