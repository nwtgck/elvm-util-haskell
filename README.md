# elvm-util
[![Build Status](https://travis-ci.org/nwtgck/elvm-util-haskell.svg?branch=develop)](https://travis-ci.org/nwtgck/elvm-util-haskell)

Utils for autogen Haskell code by [ELVM](https://github.com/shinh/elvmhttps://github.com/shinh/elvm)

## Install

Add this library to your `stack.yaml` like the following if you use [Stack](https://docs.haskellstack.org/en/stable/README/).

```yaml
...
extra-deps:
- git: https://github.com/nwtgck/elvm-util-haskell.git
  commit: 53c6bfacc0fb6f78b4ef621c44e293e3d88409cd
...
```

Then, add `elvm-util` to your `package.yaml`.

```yaml
...
library:
 dependencies:
 - elvm-util
...
```

## Example repository

The repository bellow uses this package.

[nwtgck/knapsack-elvm-haskell: Knapsack problem solver converted from C language by ELVM.](https://github.com/nwtgck/knapsack-elvm-haskell)
