# Git Katas: Subtree

Subtree are a way to embed other git repository histories into your own by merging in the subtree history into yours. It also enables you to push patches to the subtree repository. This allows you to grab source change directly via merging histories, as well as _pushing_ them back.

This feature is useful if you decide that for instance a specific folder should be a repository on its own because other repositories/projects would need it.

## Resources

We found some resources that may assist you in understanding this feature of Git better.

* https://manpages.debian.org/testing/git-man/git-subtree.1.en.html
* https://lostechies.com/johnteague/2014/04/04/using-git-subtrees-to-split-a-repository/
* https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt
* https://devtut.github.io/git/subtrees.html#create-pull-and-backport-subtree

* https://codewinsarguments.co/2016/05/01/git-submodules-vs-git-subtrees/

* https://git-memo.readthedocs.io/en/latest/subtree.html

Subtrees are easier to pull, but harder to push

## Setup

1. Run `./setup.sh`

> NOTE: If running setup.sh on windows, you can run into problems by sourcing the setup script. Instead, run `./setup.sh`, and the folders would be created correctly.

## Task

After running `. setup.sh` or `. ./setup.sh`, you'll have two repositories that we will use for this exercise.

* A `product` repository that has one `component` inside is useful for the two scenarios: merging and splitting.

Go to the `product` repository.

1. Run `git log`. Can you explain the additional explanatory lines?
1. Go to the `component` repository, and see what `git log` says. Is it what you expected?
1. What does your working directory look like?
1. Does `git status` look like you expect?
1. Commit the changes on the `product` repository.
1.

Go to the `component` repository.

1. git split -b

Next, we'd like to actually the two repositories, so we end up with a single repository.
That's one of the powers of subtree.

## Useful commands

- `git subtree split`
- `git split add`
- `git log`
- `git read-tree`

Draw this entire exercise!
