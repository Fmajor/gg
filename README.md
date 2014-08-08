gg
======================
Please wait for version v2.0 for more functions and better compatibility, this version is tested only in git version 1.7 and is not compatible with git version 1.9
=====================

About
-------

This bash command script is to achieve "A successful Git branching model" in http://nvie.com/posts/a-successful-git-branching-model.

It contains all the functions in the article, and something more for myself.

Model
--------

There are several kind of branches 

### master and develop branches
* Tow long-live branches, only stable release version of softwares can be in master branch, and unstable tings are in develop branch.

### feature branch 
* Temporary branch, it

> can only be created from the develop branch
> 
> will be merged into the develop branch and then deleted at least
> 
> has the name like newFeature.\*

When you come up with a new idea and want it to be a new feature of your soft, use (you must be in the develop branch)

		gg-feature-open featureName
When you finish it and want to merge it into develop, use (you must be in the feature branch)

		gg-feature-close

### release branch
* Temporary branch, it

> can only be created from the develop branch
> 
> will be merged into the develop and master branches, then be deleted at least
> 
> has the name like release-\*

When your soft in the develop branch is stable and prepared to release, create a release branch use (you must be in the develop branch)

		gg-release-open versionNumber
Then do some update-version things (or nothing), like modify the version number in readme, but DON'T make large changes to make the soft unstable, which you should do in the develop branch.
Then use (you must be in the release branch)

		gg-release-close
The new version is merged into the master and the develop branches

### hotfix branch
* Temporary branch, it

> can only be created from the master branch
> 
> will be merged into the develop and master branches, then be deleted at least
> 
> has the name like hotfix-\*

When you find a HOTBUG in the master branch and must fix it immediately, make a hotfix branch to fix it. use (you must be in the master branch)

		gg-hotfix-open versionNumber
Then fix the HOTBUG and use (you must be in the hotfix branch)

		gg-hotfix-close
The new version is merged into the master and the develop branches

### issues branch
* Temporary branch, it

> can only be created from the develop branch
> 
> will be merged into the develop and then deleted at least
> 
> has the name like issues.\*

When you have a issues (or a bug) and what to fix it from the develop branch, you can create a issues branch. use (you must be in the develop branch)

		gg-issues-open issuesName
when you fix the bug(s) and want to merge it into develop, use (you must be in the feature branch)

		gg-issues-close

### trials branch
* Temporary branch, it

> can be created from any branch and has the name like currentBranch.trials
> 
> will be merged into the branch from which it was created, which called "good close"
> 
> or will be deleted (and then become unreachable), which called "bad close"

You have many crazy ideas and what to try them anywhere, you can create a trials branch, use (you can be in any branch)

		gg-trials-open [trialsName]

With the option, you get a branch like currentBranchName.trials-trialsName

Without the option, you get a branch like currentBranchName.trials

Then do crazy things (or we will be too old to do them)

Finally, you have tow choices:
* merge it into the branch from which it was created, use (you must be in the trials branch)

		gg-trials-good-close
* delete it, use (you must be in the trials branch)

		gg-trials-bad-close
notice that when you delete the branch, the things become unreachable, so i log the things into .deletedTrailsBranchs, the unreachable commits will be autoremoved, depend on your git gc configurate

Usage
-------

### gg-init
* Initialized empty Git repository and make a develop branch.

### gg-default.gitignore
* Generate .gitignore to exclude \*~ and \*swp files.

### gg-stash-and-goto branchName
* autosave your uncommited things and goto branchName to do something

### gg-go-back-to-stash
* goback to the branch and load the uncommited things
 
### gg-find-big-files
* sometimes, a BIGGGG file may be added in the repository and make it tooooo big to hold, you can use this script to find out its name

### other funcions are mentioned above
### These may be all the things I want to do in git 


