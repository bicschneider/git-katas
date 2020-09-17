# Git Katas: Subtree split

```
########################################################
#
#
#
#
# TO BE DONE
#
#
#
#
#######################################################
```
Subtree was designed to integrate a "foreign" repository into a repository but also to deliver patches to the upstream subtree. The later feature also gives the ability to export a subdirectory history. In Git terms the subdirectory is a subtree. It is a similar to filter-branching, but this way works better if you want to it again and again as you commits are added to your "master" repository.

The feature enables development teams to work in a mono repository even though parts of the repository need to be delivered as repository and be part of something else as a submodule or integrated as subtree integration.


    Legend:
    [ ]: repositories

    [dev_env]                                                       [product]
       |- undelivrable                                                      |- integration-tests
       |- component                   --> [component] <--      |- [component]
       |- [other dependencies]                                        |- [other dependencies]



## Setup

1. On Windows: Run `Git Bash`
1. Run `./setup.sh`

## Task - Export subdirectory to its own history using --split option

After running `./setup.sh`, you'll have two repositories that we will use for this exercise.

INFO: You now have the following under the `excercise` directory:
* A `dev_env` repository that will contain the "dev_env" history including the subdirectory `component`
* A `component` repository that will contain the "component" history - split out from the `dev_env`

Exercise
* Go to the `component` repository and run `git log --all --decorate --graph` and notice the history. ( It should be empty )
* Go to the `dev_env` repository and run `git log --all --decorate --graph` and notice the history.
* Add the `component` repo as a remote reference: `git remote add component ../component/.git` ( optional, but good practice )
* Check the remotes using `git remote -v` and it should look like this:

```
$ git remote -v
component       ../component/.git (fetch)
component       ../component/.git (push)
```

* Split the subdirectory `component` to its own history stack using this command: `git subtree split --prefix component --branch component/master` . You should see something like this:
```
2/2 (1) [0]
Created branch 'component/master'
102958c98e3be6e6b2105e30f0b318a1c4afab0e
```
* What does that tell you? ( Amount of commits processed? Amount of commits split/exported? )
* Investigate the repository `dev_env` using `git log --all --decorate --graph` or `gitk --all`.
  * What is interesting about the history(ies) in the repository? ( Branches and commits, authors, committers, timestamps )
* Push the branch `component/master` to the `component` repository's `master` branch using command: `git push component  ${subdir}/master:master`
  * Investigate the repository again. What is added?
  * Investigate the repository `component` using `git log --all --decorate --graph` or `gitk --all`. What is interesting about the history(ies) in the repository? ( Branches and commits, authors, committers, timestamps )


## Task - Add merge commits
You have now see the basics of `git subtree --split` - let us continue to add more commit to see how it reacts to merges.

* Go to the `dev_env` repository
* Create a branch `feature` using command: `git checkout -b `feature`
* Add file `component/component.c` and commit it
* Check out branch `master`
* Add file `Readme.txt` and commit it
* Merge the branch `feature` into `master` ( `git merge feature` )
* Run the split command again, but this time with the `--onto` option: `git subtree split --prefix component --branch component/master --onto --branch component/master`
* Investigate the history(ies) of the repository.
  * What happend to the merge commit and why?
  * What about the remote pointer to `component/master`
* Push the changes from `component/master` to the `master` branch in remote `component` and notice the remote pointer

## Task - Add merge commits - continued

* Checkout branch `feature` again ( `git checkout feature` )
* Change file `component/component.c` and commit it
* Check out branch `master`
* Change file `component/component.h` and commit it
* Merge the branch `feature` into `master` ( `git merge feature` )
* Run the split command again, but this time with the `--onto` option: `git subtree split --prefix component --branch component/master --onto --branch component/master`
* Investigate the history(ies) of the repository.
  * What happend to the merge commit and why?
  * What about the remote pointer to `component/master`
* Push the changes from `component/master` to the `master` branch in remote `component` and notice the remote pointer

## Run all the exercises as a script
Run all the above commands to see the commands and their results.
```
replay=true debug=true ./setup.sh
```

## Resources

We found some resources that may assist you in understanding this feature of Git better.
* https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt

