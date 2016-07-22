gg
======================
The mental model of gg
===============
![gg mental model](http://fmajor.lamost.org/blog/assets/posts/2014-08-08-gg/dev.png)
[gg-good use of git](http://fmajor.lamost.org/blog/2014/08/08/gg.html)
Install
==============

In Linux:
	./linuxInstall

In Mac:
	./macInstall

commands
=====================
	gg-init
		change the git repository to have the gg structure (one make a master-develop pair and add a pre-commit hook, no other file changes)
	gg-create-new-develop-branch-pair <name>
		make a new master-develop pair: <name>|develop and <name>|master
		we call <name> the dev code
		we call the $develop branch below for
			develop branch(without dev code) and
			<name>|develop branch(with dev code)
		the same with the $master branch
	gg-ck [m|d|f]
		ckeckout to the develop, master, and father branch within the same dev code.
			the father branch is available only for trial and issue branches
	gg-comment <comment>
		make a empty commit to make some comment
			git commit --allow-empty -m "<comment>"
	
	gg-feature-open <name>
		can use this function in all branches other than $master and release branch
		open a feature branch with name
			feature/<name> # if you run it from the $develop branch
			feature/<name>-FromBranch-$father # if your run it from $father(the current branch) other than the $develop branch
	gg-feature-close
		can only use this function in a feature branch
		merge the feature branch to $father and delete it
	gg-feature-update
		can only use this function in one feature branch
		merge the $father branch into this branch (update it)
	
	gg-issues-open <name>
		can use this function in all branches other than $master and release branch
		open a issue branch with name
			issue/<name> # if you run it from the $develop branch
			issue/<name>-FromBranch-$father # if your run it from $father(the current branch) other than the $develop branch
	gg-issues-close
		can only use this function in a issues branch
		merge the feature branch to $father and delete it
	gg-issues-update
		can only use this function in one issues branch
		merge the $father branch into this branch (update it)
	
	gg-release-open [<name>]
		can only use this function in the $develop branch
		if have no args, list all exist tags to help you make a name for this release
		if have the <name>
			open a release branch with name release-<name>
	gg-release-close
		can only use this function in a release branch
		merge the release branch to $master and $develop, then delete it
		tag the master with <name> from gg-release-open command
	
	gg-hotfix-open [<name>]
		can only use this function in the $master branch
		if have no args, list all exist tags to help you make a name for this hotfix
		if have the <name>
			open a release branch with name hotfix-<name>
	gg-hotfix-close
		can only use this function in a release branch
		merge the release branch to $master and $develop, then delete it
		tag the master with <name> from gg-hotfix-open
	
	gg-trials-open [<name>]
		can use this function in all branches other than $master branch
		open a trial branch with name
			$father%trials        # if have no <name> input
			$father%trials.<name> # if have    <name> input
		you can make a trials branch in a trials branch
	gg-trials-good-close
		can only use this function in a trials branch
		merge the trials branch to $father and delete it
	gg-trials-bad-close
		can only use this function in a trials branch
		detele the trials branch and save the log to .git/../.deletedTrailsBranchs
			so you can use the hash name to again find it before the git gc clean the data
demo
====================
to get this demo

	cd demo
	make simple

and hit Enter for 42 times

in this demo
	things after >>>> are the commands in the makefile
	things after # are the comments

other things are output from gg or git

you can get **colorful** demo by running it by yourself

	#=============================================
	# demo for gg
	# first we init a git repository
	>>>> git init
	Initialized empty Git repository in gg/demo/.git/
	>>>> git add makefile
	>>>> git commit --allow-empty -m "init a repository"
	[master (root-commit) 8717a5f] init a repository
	 1 file changed, 539 insertions(+)
	 create mode 100644 makefile
	#=============================================
	# make it into the gg structure(have a master-develop pair)
	>>>> gg-init
	Do you what to git init the directory like this?
		git checkout master
		git commit --allow-empty -m "Init commit as gg repertory"
		git checkout -b develop
		cat /usr/local/bin/gg/gg-pre-commit >> .git/hooks/pre-commit
	press ENTER to continue, press Ctrl+c to ESCAPE

	Already on 'master'
	[master 88e28f3] Init commit as gg repertory
	Switched to a new branch 'develop'
	>>>> git --no-pager log --oneline --decorate
	88e28f3 (HEAD -> develop, master) Init commit as gg repertory
	8717a5f init a repository
	#=============================================
	# we can also make another master-develop pair with prefix like somename|master and somename|develop
	>>>> gg-create-new-develop-branch-pair test
	Do you what to open a new pair of branches like this?
		git checkout -b "test|develop" "develop"
		git checkout -b "test|master" "develop"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to a new branch 'test|develop'
	Switched to a new branch 'test|master'
	>>>> git --no-pager log --oneline --decorate
	88e28f3 (HEAD -> test|master, test|develop, master, develop) Init commit as gg repertory
	8717a5f init a repository
	# gg-ck to quickly switch between develop and master with the same prefix
	>>>> gg-ck d
	Switched to branch 'test|develop'
	>>>> gg-ck m
	Switched to branch 'test|master'
	>>>> git checkout master
	Switched to branch 'master'
	>>>> gg-ck m
	Already on 'master'
	>>>> gg-ck d
	Switched to branch 'develop'
	#=============================================
	# now make some changes
	>>>> echo "in develop" > inDevelop.txt
	>>>> git add inDevelop.txt
	>>>> git commit -m "add file in develop"
	[develop ec08ac9] add file in develop
	 1 file changed, 1 insertion(+)
	 create mode 100644 inDevelop.txt
	# now checkout to master and try to make some change
	>>>> gg-ck m

	Switched to branch 'master'
	>>>> echo "in master" > inMaster.txt
	>>>> git add inMaster.txt
	>>>> git commit -m "add file in master" || echo "\tfailed to commit in master"
		You should NOT make a commit in the master branch
			If you have to do so, use git commit --no-verify
	  develop
	* master
	  test|develop
	  test|master
		failed to commit in master
	# now we stash and go to develop to commint
	>>>> git stash
	Saved working directory and index state WIP on master: 88e28f3 Init commit as gg repertory
	HEAD is now at 88e28f3 Init commit as gg repertory
	>>>> gg-ck d
	Switched to branch 'develop'
	>>>> git stash pop

	On branch develop
	Changes to be committed:
	  (use "git reset HEAD <file>..." to unstage)

		new file:   inMaster.txt

	Dropped refs/stash@{0} (a7e977f94b9d007edc5b91ba16b3d3d1d0f1b8a5)
	>>>> git commit -m "add file in master, but we can only commit in develop"
	[develop c70c146] add file in master, but we can only commit in develop
	 1 file changed, 1 insertion(+)
	 create mode 100644 inMaster.txt
	# make some changes and try to make a release
	>>>> echo "some changes" >> inDevelop.txt
	>>>> echo "some bugs\n more bug...\n bug everywhere..." >> inDevelop.txt
	>>>> git add inDevelop.txt
	>>>> git commit -m "make some changes and then we can make a release"
	[develop fd357b5] make some changes and then we can make a release
	 1 file changed, 4 insertions(+)
	# now make a release
	>>>> git tag -a "someTagName" -m "comments"
	>>>> gg-release-open || printf "\e[44m# without input arg, we can have a list of the current tags, which can help us to give a name of our release\e[0m\n"
	your are in branch develop, Please input release number
	Current tag names are
	someTagName
	# without input arg, we can have a list of the current tags, which can help us to give a name of our release
	>>>> gg-release-open v0.1
	Do you what to open a new release branch like this?
		git checkout -b "release-v0.1"
	press ENTER to continue, press Ctrl+c to ESCAPE
	[develop d498a72] Start to release version v0.1
	Switched to a new branch 'release-v0.1'
	# and then make some changes just for release(e.g. change the version number in README)
	>>>> echo "version: v0.1" > README.txt && git add README.txt && git cm -m "modify the version number in README"
	[release-v0.1 a6d8690] modify the version number in README
	 1 file changed, 1 insertion(+)
	 create mode 100644 README.txt
	# you can also do nothing here..

	# now we close the release and see what happend
	>>>> gg-release-close
	You are in branch ||      release-v0.1      ||
	Do you want to close it like this?
		git checkout "master"
		git merge --no-ff "release-v0.1"
		git tag -a "v0.1"
		git checkout "develop"
		git merge --no-ff "release-v0.1"
		git branch -d "release-v0.1"

	if you meet conflicts in merges, you should delete the branch manully
	press ENTER to continue, press Ctrl+c to ESCAPE
	Switched to branch 'master'
	Merge made by the 'recursive' strategy.
	 README.txt    | 1 +
	 inDevelop.txt | 5 +++++
	 inMaster.txt  | 1 +
	 3 files changed, 7 insertions(+)
	 create mode 100644 README.txt
	 create mode 100644 inDevelop.txt
	 create mode 100644 inMaster.txt
	Switched to branch 'develop'
	Merge made by the 'recursive' strategy.
	 README.txt | 1 +
	 1 file changed, 1 insertion(+)
	 create mode 100644 README.txt
	[develop e6efba5] Merge branch release-v0.1 into develop
	 Date: Fri Jul 22 16:54:39 2016 +0800
	press Enter to delete branch release-v0.1
	press ENTER to continue, press Ctrl+c to ESCAPE
	Deleted branch release-v0.1 (was a6d8690).
	>>>> git --no-pager log --oneline --decorate --graph
	*   e6efba5 (HEAD -> develop) Merge branch release-v0.1 into develop
	|\
	| * a6d8690 modify the version number in README
	|/
	* d498a72 Start to release version v0.1
	* fd357b5 (tag: someTagName) make some changes and then we can make a release
	* c70c146 add file in master, but we can only commit in develop
	* ec08ac9 add file in develop
	* 88e28f3 (test|master, test|develop) Init commit as gg repertory
	* 8717a5f init a repository
	# Oh!! we find a bug in the released version.. now try to fix it!!
	>>>> cat inDevelop.txt
	in develop
	some changes
	some bugs
	 more bug...
	 bug everywhere...
	>>>> gg-hotfix-open || printf "\e[44m# Oh!! we need to go to the master branch to open a hotfix..\e[0m\n"

	You must be in the master branch to create a new hotfix branch!

	On branch develop
	nothing to commit, working directory clean
	# Oh!! we need to go to the master branch to open a hotfix..
	>>>> gg-ck m
	Switched to branch 'master'

	>>>> gg-hotfix-open || printf "\e[44m# without input arg, we can have a list of the current tags, which can help us to give a name of our hotfix\e[0m\n"
	your are in branch master, Please input the hotfix number
	Current tag names are
	someTagName
	v0.1
	# without input arg, we can have a list of the current tags, which can help us to give a name of our hotfix
	# because last version is v0.1, i give the name of the hotfix v0.1.1
	>>>> gg-hotfix-open v0.1.1
	Do you what to open a new hotfix branch like this?
		git checkout -b "hotfix-v0.1.1"
	press ENTER to continue, press Ctrl+c to ESCAPE
	Switched to a new branch 'hotfix-v0.1.1'
	# fix the bug
	>>>> sed '/bugs/d' inDevelop.txt > temp.txt
	>>>> mv temp.txt inDevelop.txt
	>>>> git add inDevelop.txt
	>>>> git commit -m "fix bugs in hotfix v0.1.1"
	[hotfix-v0.1.1 59c8b5a] fix bugs in hotfix v0.1.1
	 1 file changed, 1 deletion(-)
	# the bug is reported as a issue #1 in our github, to make it more clear, we can make a issue branch
	# issue branch can be made in branchs other than master and release
	>>>> gg-issues-open "#1"
	Do you what to open a new issues branch like this?
		git checkout -b "issues/#1-FromBranch-hotfix-v0.1.1"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to a new branch 'issues/#1-FromBranch-hotfix-v0.1.1'
	# fix the bugs
	>>>> sed '/bug/d' inDevelop.txt > temp.txt
	>>>> mv temp.txt inDevelop.txt
	>>>> git add inDevelop.txt
	>>>> git commit -m "fix bugs for issues/#1/test/for/multi/slash/name"
	[issues/#1-FromBranch-hotfix-v0.1.1 16d44b0] fix bugs for issues/#1/test/for/multi/slash/name
	 1 file changed, 2 deletions(-)
	# now close issues branch
	>>>> gg-issues-close
	You are in branch ||   issues/#1-FromBranch-hotfix-v0.1.1   ||
	Do you want to close it like this?
		git checkout "hotfix-v0.1.1"
		git merge --no-ff "issues/#1-FromBranch-hotfix-v0.1.1"
		git branch -d "issues/#1-FromBranch-hotfix-v0.1.1"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to branch 'hotfix-v0.1.1'
	Merge made by the 'recursive' strategy.
	 inDevelop.txt | 2 --
	 1 file changed, 2 deletions(-)
	press Enter to delete issues/#1-FromBranch-hotfix-v0.1.1 branch
	press Ctrl+c to ESCAPE

	Deleted branch issues/#1-FromBranch-hotfix-v0.1.1 (was 16d44b0).
	>>>> echo "version: v0.1.1" > README.txt
	>>>> git add README.txt
	>>>> git commit -m"close hotfix-v0.1.1"
	[hotfix-v0.1.1 3df70cb] close hotfix-v0.1.1
	 1 file changed, 1 insertion(+), 1 deletion(-)
	# now we finish the hotfix
	>>>> gg-hotfix-close
	You are in branch ||      hotfix-v0.1.1      ||
	Do you want to close it like this?
		git checkout "master"
		git merge --no-ff "hotfix-v0.1.1"
		git tag -a "v0.1.1"
		git checkout "develop"
		git merge --no-ff "hotfix-v0.1.1"
		git branch -d "hotfix-v0.1.1"
		if you meet conflicts in merges, you should delete the branch manully
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to branch 'master'
	Merge made by the 'recursive' strategy.
	 README.txt    | 2 +-
	 inDevelop.txt | 3 ---
	 2 files changed, 1 insertion(+), 4 deletions(-)
	Switched to branch 'develop'
	Merge made by the 'recursive' strategy.
	 README.txt    | 2 +-
	 inDevelop.txt | 3 ---
	 2 files changed, 1 insertion(+), 4 deletions(-)
	press Enter to delete branch hotfix-v0.1.1
	press Ctrl+c to ESCAPE

	Deleted branch hotfix-v0.1.1 (was 3df70cb).
	>>>> git --no-pager log --oneline --decorate --graph
	*   67b7ba3 (HEAD -> develop) Merge hotfix branch hotfix-v0.1.1 into develop
	|\
	| * 3df70cb close hotfix-v0.1.1
	| *   f56870a Merge issue branch issues/#1-FromBranch-hotfix-v0.1.1 into hotfix-v0.1.1
	| |\
	| | * 16d44b0 fix bugs for issues/#1/test/for/multi/slash/name
	| |/
	| * 59c8b5a fix bugs in hotfix v0.1.1
	| *   f85f788 (tag: v0.1) Merge release branch release-v0.1 into master
	| |\
	* | \   e6efba5 Merge branch release-v0.1 into develop
	|\ \ \
	| | |/
	| |/|
	| * | a6d8690 modify the version number in README
	|/ /
	* | d498a72 Start to release version v0.1
	* | fd357b5 (tag: someTagName) make some changes and then we can make a release
	* | c70c146 add file in master, but we can only commit in develop
	* | ec08ac9 add file in develop
	|/
	* 88e28f3 (test|master, test|develop) Init commit as gg repertory
	* 8717a5f init a repository
	# now let us try the issues, features and trial branch in the develop branch
	>>>> echo "some changes in develop" >> inDevelop.txt
	>>>> git add inDevelop.txt && git commit -m "some changes in develop"
	[develop 7f976ec] some changes in develop
	 1 file changed, 1 insertion(+)
	# now we want to develop a new feature
	>>>> gg-feature-open fly
	Do you what to open a new feature branch like this?
		git checkout -b "feature/fly"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to a new branch 'feature/fly'
	# make a empty commit with some comment for this branch
	>>>> gg-comment "use empty commit to make a relative loooooooooooooooooooooooooooooooooooooooooooong description for this branch"
	Do you what to open a comment like this?
		git commit --allow-empty -m "use empty commit to make a relative loooooooooooooooooooooooooooooooooooooooooooong description for this branch"
	press ENTER to continue, press Ctrl+c to ESCAPE

	[feature/fly 36f29de] use empty commit to make a relative loooooooooooooooooooooooooooooooooooooooooooong description for this branch
	>>>> echo "new features" >> newFeature.txt && git add newFeature.txt && git commit -m "add new feature in feature/fly branch"
	[feature/fly 322ec12] add new feature in feature/fly branch
	 1 file changed, 1 insertion(+)
	 create mode 100644 newFeature.txt
	# while the develop branch is also under development
	>>>> gg-ck d && echo "some changes in develop" >> inDevelop.txt && git add inDevelop.txt && git commit -m"new changes in inDevelop"
	Switched to branch 'develop'
	[develop efde126] new changes in inDevelop
	 1 file changed, 1 insertion(+)
	# we want to update our feature branch with the latest develop branch
	>>>> gg-feature-update || printf "\e[44m# we forgot to change the branch..\e[0m\n"

	You must be in one feature branch to update it!
	On branch develop
	nothing to commit, working directory clean
	# we forgot to change the branch..
	>>>> git checkout feature/fly
	Switched to branch 'feature/fly'
	>>>> gg-feature-update || printf "\e[44m# we forgot to change the branch..\e[0m\n"
	You are in branch ||   feature/fly   ||
	Do you want to update it like this?
		git merge --no-ff "develop"

	press ENTER to continue, press Ctrl+c to ESCAPE

	Merge made by the 'recursive' strategy.
	 inDevelop.txt | 1 +
	 1 file changed, 1 insertion(+)
	# now add more feature
	>>>> echo "more features" >> newFeature.txt && git add newFeature.txt && git commit -m "add more new feature in feature/fly branch"
	[feature/fly 91f197b] add more new feature in feature/fly branch
	 1 file changed, 1 insertion(+)
	# now we try to open a issue in the feature brach and close it
	>>>> gg-issues-open "#2"
	Do you what to open a new issues branch like this?
		git checkout -b "issues/#2-FromBranch-feature/fly"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to a new branch 'issues/#2-FromBranch-feature/fly'
	>>>> echo "fix issues" >> newFeature.txt && git add newFeature.txt && git commit -m "fix issues"
	[issues/#2-FromBranch-feature/fly 230641b] fix issues
	 1 file changed, 1 insertion(+)
	>>>> gg-issues-close
	You are in branch ||   issues/#2-FromBranch-feature/fly   ||
	Do you want to close it like this?
		git checkout "feature/fly"
		git merge --no-ff "issues/#2-FromBranch-feature/fly"
		git branch -d "issues/#2-FromBranch-feature/fly"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to branch 'feature/fly'
	Merge made by the 'recursive' strategy.
	 newFeature.txt | 1 +
	 1 file changed, 1 insertion(+)
	press Enter to delete issues/#2-FromBranch-feature/fly branch
	press Ctrl+c to ESCAPE

	Deleted branch issues/#2-FromBranch-feature/fly (was 230641b).
	# add new feature and close feature
	>>>> echo "more features" >> inDevelop.txt && git add inDevelop.txt && git commit -m "add more new feature in feature/fly branch"
	[feature/fly c7d0029] add more new feature in feature/fly branch
	 1 file changed, 1 insertion(+)
	>>>> gg-feature-close
	You are in branch ||   feature/fly   ||
	Do you want to close it like this?
		git checkout "develop"
		git merge --no-ff "feature/fly"
		git branch -d "feature/fly"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to branch 'develop'
	Merge made by the 'recursive' strategy.
	 inDevelop.txt  | 1 +
	 newFeature.txt | 3 +++
	 2 files changed, 4 insertions(+)
	 create mode 100644 newFeature.txt
	press Enter to delete feature/fly branch
	 press Ctrl+c not to delete it

	Deleted branch feature/fly (was c7d0029).
	>>>> git --no-pager log --oneline --decorate --graph
	*   5a6b58e (HEAD -> develop) Merge feature branch feature/fly into develop
	|\
	| * c7d0029 add more new feature in feature/fly branch
	| *   e07f040 Merge issue branch issues/#2-FromBranch-feature/fly into feature/fly
	| |\
	| | * 230641b fix issues
	| |/
	| * 91f197b add more new feature in feature/fly branch
	| *   a7e2e34 Merge(update) branch develop into feature/fly
	| |\
	| |/
	|/|
	* | efde126 new changes in inDevelop
	| * 322ec12 add new feature in feature/fly branch
	| * 36f29de use empty commit to make a relative loooooooooooooooooooooooooooooooooooooooooooong description for this branch
	|/
	* 7f976ec some changes in develop
	*   67b7ba3 Merge hotfix branch hotfix-v0.1.1 into develop
	|\
	| * 3df70cb close hotfix-v0.1.1
	| *   f56870a Merge issue branch issues/#1-FromBranch-hotfix-v0.1.1 into hotfix-v0.1.1
	| |\
	| | * 16d44b0 fix bugs for issues/#1/test/for/multi/slash/name
	| |/
	| * 59c8b5a fix bugs in hotfix v0.1.1
	| *   f85f788 (tag: v0.1) Merge release branch release-v0.1 into master
	| |\
	* | \   e6efba5 Merge branch release-v0.1 into develop
	|\ \ \
	| | |/
	| |/|
	| * | a6d8690 modify the version number in README
	|/ /
	* | d498a72 Start to release version v0.1
	* | fd357b5 (tag: someTagName) make some changes and then we can make a release
	* | c70c146 add file in master, but we can only commit in develop
	* | ec08ac9 add file in develop
	|/
	* 88e28f3 (test|master, test|develop) Init commit as gg repertory
	* 8717a5f init a repository
	# release another version
	>>>> gg-release-open v0.2
	Do you what to open a new release branch like this?
		git checkout -b "release-v0.2"
	press ENTER to continue, press Ctrl+c to ESCAPE

	[develop ff2afde] Start to release version v0.2
	Switched to a new branch 'release-v0.2'
	>>>> echo "version: v0.2" > README.txt && git add README.txt && git cm -m "modify the version number in README"
	[release-v0.2 b6eb6ee] modify the version number in README
	 1 file changed, 1 insertion(+), 1 deletion(-)
	>>>> gg-release-close
	You are in branch ||      release-v0.2      ||
	Do you want to close it like this?
		git checkout "master"
		git merge --no-ff "release-v0.2"
		git tag -a "v0.2"
		git checkout "develop"
		git merge --no-ff "release-v0.2"
		git branch -d "release-v0.2"

	if you meet conflicts in merges, you should delete the branch manully
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to branch 'master'
	Merge made by the 'recursive' strategy.
	 README.txt     | 2 +-
	 inDevelop.txt  | 3 +++
	 newFeature.txt | 3 +++
	 3 files changed, 7 insertions(+), 1 deletion(-)
	 create mode 100644 newFeature.txt
	Switched to branch 'develop'
	Merge made by the 'recursive' strategy.
	 README.txt | 2 +-
	 1 file changed, 1 insertion(+), 1 deletion(-)
	[develop 234a448] Merge branch release-v0.2 into develop
	 Date: Fri Jul 22 16:54:44 2016 +0800
	press Enter to delete branch release-v0.2
	press ENTER to continue, press Ctrl+c to ESCAPE

	Deleted branch release-v0.2 (was b6eb6ee).
	>>>> git --no-pager log --oneline --decorate --graph --tags
	*   61c5763 (tag: v0.2, master) Merge release branch release-v0.2 into master
	|\
	| * b6eb6ee modify the version number in README
	| * ff2afde Start to release version v0.2
	| *   5a6b58e Merge feature branch feature/fly into develop
	| |\
	| | * c7d0029 add more new feature in feature/fly branch
	| | *   e07f040 Merge issue branch issues/#2-FromBranch-feature/fly into feature/fly
	| | |\
	| | | * 230641b fix issues
	| | |/
	| | * 91f197b add more new feature in feature/fly branch
	| | *   a7e2e34 Merge(update) branch develop into feature/fly
	| | |\
	| | |/
	| |/|
	| * | efde126 new changes in inDevelop
	| | * 322ec12 add new feature in feature/fly branch
	| | * 36f29de use empty commit to make a relative loooooooooooooooooooooooooooooooooooooooooooong description for this branch
	| |/
	| * 7f976ec some changes in develop
	| *   67b7ba3 Merge hotfix branch hotfix-v0.1.1 into develop
	| |\
	| * \   e6efba5 Merge branch release-v0.1 into develop
	| |\ \
	* | \ \   8dd0ebb (tag: v0.1.1) Merge hotfix branch hotfix-v0.1.1 into master
	|\ \ \ \
	| | |_|/
	| |/| |
	| * | | 3df70cb close hotfix-v0.1.1
	| * | |   f56870a Merge issue branch issues/#1-FromBranch-hotfix-v0.1.1 into hotfix-v0.1.1
	| |\ \ \
	| | * | | 16d44b0 fix bugs for issues/#1/test/for/multi/slash/name
	| |/ / /
	| * | | 59c8b5a fix bugs in hotfix v0.1.1
	|/ / /
	* | |   f85f788 (tag: v0.1) Merge release branch release-v0.1 into master
	|\ \ \
	| | |/
	| |/|
	| * | a6d8690 modify the version number in README
	| |/
	| * d498a72 Start to release version v0.1
	| * fd357b5 (tag: someTagName) make some changes and then we can make a release
	| * c70c146 add file in master, but we can only commit in develop
	| * ec08ac9 add file in develop
	|/
	* 88e28f3 (test|master, test|develop) Init commit as gg repertory
	* 8717a5f init a repository
	# last, let's try the trial branch. For test, i will start it on a issues branch of a feature branch
	>>>> gg-ck d && echo "some changes in develop" >> inDevelop.txt && git add inDevelop.txt && git commit -m"new changes in inDevelop"
	Already on 'develop'
	[develop af26b73] new changes in inDevelop
	 1 file changed, 1 insertion(+)
	>>>> gg-feature-open F
	Do you what to open a new feature branch like this?
		git checkout -b "feature/F"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to a new branch 'feature/F'
	>>>> gg-comment "feature branch to be tested"
	Do you what to open a comment like this?
		git commit --allow-empty -m "feature branch to be tested"
	press ENTER to continue, press Ctrl+c to ESCAPE

	[feature/F eb0382b] feature branch to be tested
	>>>> echo "some features" >> newFeature.txt && git add newFeature.txt && git commit -m"new features"
	[feature/F 5d136b5] new features
	 1 file changed, 1 insertion(+)
	>>>> gg-issues-open I
	Do you what to open a new issues branch like this?
		git checkout -b "issues/I-FromBranch-feature/F"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to a new branch 'issues/I-FromBranch-feature/F'
	>>>> gg-comment "issues branch to be tested"
	Do you what to open a comment like this?
		git commit --allow-empty -m "issues branch to be tested"
	press ENTER to continue, press Ctrl+c to ESCAPE

	[issues/I-FromBranch-feature/F f95d67e] issues branch to be tested
	>>>> echo "some issues" >> issues.txt && git add issues.txt && git commit -m"new issues"
	[issues/I-FromBranch-feature/F c1893a8] new issues
	 1 file changed, 1 insertion(+)
	 create mode 100644 issues.txt
	# last, let's try the trial branch
	>>>> gg-trials-open T1
	You are in branch ||      issues/I-FromBranch-feature/F      ||
	Do you want to make a trail branch like this?
		git checkout -b "issues/I-FromBranch-feature/F%trials.T1"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to a new branch 'issues/I-FromBranch-feature/F%trials.T1'
	>>>> echo "some trials" >> trials1.txt && git add trials1.txt && git commit -m"trials1"
	[issues/I-FromBranch-feature/F%trials.T1 2f81b6b] trials1
	 1 file changed, 1 insertion(+)
	 create mode 100644 trials1.txt
	# let's open another trial
	>>>> gg-ck f
	Switched to branch 'issues/I-FromBranch-feature/F'
	>>>> gg-trials-open T2
	You are in branch ||      issues/I-FromBranch-feature/F      ||
	Do you want to make a trail branch like this?
		git checkout -b "issues/I-FromBranch-feature/F%trials.T2"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to a new branch 'issues/I-FromBranch-feature/F%trials.T2'
	>>>> echo "some trials" >> trials2.txt && git add trials2.txt && git commit -m"trials2"
	[issues/I-FromBranch-feature/F%trials.T2 e1f90d8] trials2
	 1 file changed, 1 insertion(+)
	 create mode 100644 trials2.txt
	# we can also open a trial branch on a trial branch
	>>>> gg-trials-open T21
	You are in branch ||      issues/I-FromBranch-feature/F%trials.T2      ||
	Do you want to make a trail branch like this?
		git checkout -b "issues/I-FromBranch-feature/F%trials.T2%trials.T21"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to a new branch 'issues/I-FromBranch-feature/F%trials.T2%trials.T21'
	>>>> echo "some trials" >> trials21.txt && git add trials21.txt && git commit -m"trials21"
	[issues/I-FromBranch-feature/F%trials.T2%trials.T21 d7ffa4f] trials21
	 1 file changed, 1 insertion(+)
	 create mode 100644 trials21.txt
	# now let's good-close a trial
	>>>> gg-trials-good-close
	You are in branch ||      issues/I-FromBranch-feature/F%trials.T2%trials.T21      ||
	Do you want to close it like this?
		git checkout "issues/I-FromBranch-feature/F%trials.T2"
		git merge --no-ff "issues/I-FromBranch-feature/F%trials.T2%trials.T21"
		git branch -D "issues/I-FromBranch-feature/F%trials.T2%trials.T21"
	if you meet conflicts in merges, you should delete the branch manully
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to branch 'issues/I-FromBranch-feature/F%trials.T2'
	Merge made by the 'recursive' strategy.
	 trials21.txt | 1 +
	 1 file changed, 1 insertion(+)
	 create mode 100644 trials21.txt
	press Enter to delete issues/I-FromBranch-feature/F%trials.T2%trials.T21 branch
	press Ctrl+c to ESCAPE

	Deleted branch issues/I-FromBranch-feature/F%trials.T2%trials.T21 (was d7ffa4f).
	>>>> echo "some trials" >> trials2.txt && git add trials2.txt && git commit -m"trials2"
	[issues/I-FromBranch-feature/F%trials.T2 cbb65da] trials2
	 1 file changed, 1 insertion(+)
	# now let's good-close the trial from the issue branch
	>>>> gg-trials-good-close
	You are in branch ||      issues/I-FromBranch-feature/F%trials.T2      ||
	Do you want to close it like this?
		git checkout "issues/I-FromBranch-feature/F"
		git merge --no-ff "issues/I-FromBranch-feature/F%trials.T2"
		git branch -D "issues/I-FromBranch-feature/F%trials.T2"
	if you meet conflicts in merges, you should delete the branch manully
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to branch 'issues/I-FromBranch-feature/F'
	Merge made by the 'recursive' strategy.
	 trials2.txt  | 2 ++
	 trials21.txt | 1 +
	 2 files changed, 3 insertions(+)
	 create mode 100644 trials2.txt
	 create mode 100644 trials21.txt
	press Enter to delete issues/I-FromBranch-feature/F%trials.T2 branch
	press Ctrl+c to ESCAPE

	Deleted branch issues/I-FromBranch-feature/F%trials.T2 (was cbb65da).
	# now let's go to another trial branch and bad-close it (drop it)
	>>>> git checkout "issues/I-FromBranch-feature/F%trials.T1"
	Switched to branch 'issues/I-FromBranch-feature/F%trials.T1'
	>>>> gg-trials-bad-close
	You are in branch ||      issues/I-FromBranch-feature/F%trials.T1      ||
	Do you want to close it like this?
		Record the ref logs of this branch in .git/../.deletedTrailsBranchs and then
		git branch -D "issues/I-FromBranch-feature/F%trials.T1"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to branch 'issues/I-FromBranch-feature/F'

	press Enter to delete issues/I-FromBranch-feature/F%trials.T1 branch
	press Ctrl+c to ESCAPE

	Deleted branch issues/I-FromBranch-feature/F%trials.T1 (was 2f81b6b).
	[issues/I-FromBranch-feature/F 9f44563] bad close trial branch issues/I-FromBranch-feature/F%trials.T1
	 1 file changed, 7 insertions(+)
	 create mode 100644 .deletedTrailsBranchs
	# to finished our demo, let's close the issues and feature branch, make a new release and see the final network plot
	>>>> echo "some issues" >> issues.txt && git add issues.txt && git commit -m"new issues"
	[issues/I-FromBranch-feature/F eeb0c83] new issues
	 1 file changed, 1 insertion(+)
	>>>> gg-issues-close
	You are in branch ||   issues/I-FromBranch-feature/F   ||
	Do you want to close it like this?
		git checkout "feature/F"
		git merge --no-ff "issues/I-FromBranch-feature/F"
		git branch -d "issues/I-FromBranch-feature/F"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to branch 'feature/F'
	Merge made by the 'recursive' strategy.
	 .deletedTrailsBranchs | 7 +++++++
	 issues.txt            | 2 ++
	 trials2.txt           | 2 ++
	 trials21.txt          | 1 +
	 4 files changed, 12 insertions(+)
	 create mode 100644 .deletedTrailsBranchs
	 create mode 100644 issues.txt
	 create mode 100644 trials2.txt
	 create mode 100644 trials21.txt
	press Enter to delete issues/I-FromBranch-feature/F branch
	press Ctrl+c to ESCAPE

	Deleted branch issues/I-FromBranch-feature/F (was eeb0c83).
	>>>> echo "some features" >> newFeature.txt && git add newFeature.txt && git commit -m"new features"
	[feature/F 353bd27] new features
	 1 file changed, 1 insertion(+)
	>>>> gg-feature-close
	You are in branch ||   feature/F   ||
	Do you want to close it like this?
		git checkout "develop"
		git merge --no-ff "feature/F"
		git branch -d "feature/F"
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to branch 'develop'
	Merge made by the 'recursive' strategy.
	 .deletedTrailsBranchs | 7 +++++++
	 issues.txt            | 2 ++
	 newFeature.txt        | 2 ++
	 trials2.txt           | 2 ++
	 trials21.txt          | 1 +
	 5 files changed, 14 insertions(+)
	 create mode 100644 .deletedTrailsBranchs
	 create mode 100644 issues.txt
	 create mode 100644 trials2.txt
	 create mode 100644 trials21.txt
	press Enter to delete feature/F branch
	 press Ctrl+c not to delete it

	Deleted branch feature/F (was 353bd27).
	>>>> echo "some changes in develop" >> inDevelop.txt && git add inDevelop.txt && git commit -m"new changes in inDevelop"
	[develop a02441e] new changes in inDevelop
	 1 file changed, 1 insertion(+)
	>>>> gg-release-open v0.3
	Do you what to open a new release branch like this?
		git checkout -b "release-v0.3"
	press ENTER to continue, press Ctrl+c to ESCAPE

	[develop 2c0cf61] Start to release version v0.3
	Switched to a new branch 'release-v0.3'
	>>>> echo "version: v0.3" > README.txt && git add README.txt && git cm -m "modify the version number in README"
	[release-v0.3 56e9952] modify the version number in README
	 1 file changed, 1 insertion(+), 1 deletion(-)
	>>>> gg-release-close
	You are in branch ||      release-v0.3      ||
	Do you want to close it like this?
		git checkout "master"
		git merge --no-ff "release-v0.3"
		git tag -a "v0.3"
		git checkout "develop"
		git merge --no-ff "release-v0.3"
		git branch -d "release-v0.3"

	if you meet conflicts in merges, you should delete the branch manully
	press ENTER to continue, press Ctrl+c to ESCAPE

	Switched to branch 'master'
	Merge made by the 'recursive' strategy.
	 .deletedTrailsBranchs | 7 +++++++
	 README.txt            | 2 +-
	 inDevelop.txt         | 2 ++
	 issues.txt            | 2 ++
	 newFeature.txt        | 2 ++
	 trials2.txt           | 2 ++
	 trials21.txt          | 1 +
	 7 files changed, 17 insertions(+), 1 deletion(-)
	 create mode 100644 .deletedTrailsBranchs
	 create mode 100644 issues.txt
	 create mode 100644 trials2.txt
	 create mode 100644 trials21.txt
	Switched to branch 'develop'
	Merge made by the 'recursive' strategy.
	 README.txt | 2 +-
	 1 file changed, 1 insertion(+), 1 deletion(-)
	[develop e6d0cbb] Merge branch release-v0.3 into develop
	 Date: Fri Jul 22 16:54:52 2016 +0800
	press Enter to delete branch release-v0.3
	press ENTER to continue, press Ctrl+c to ESCAPE

	Deleted branch release-v0.3 (was 56e9952).
	>>>> git --no-pager log --oneline --decorate --graph --tags
	*   d237af2 (tag: v0.3, master) Merge release branch release-v0.3 into master
	|\
	| * 56e9952 modify the version number in README
	| * 2c0cf61 Start to release version v0.3
	| * a02441e new changes in inDevelop
	| *   e378ad9 Merge feature branch feature/F into develop
	| |\
	| | * 353bd27 new features
	| | *   95fce41 Merge issue branch issues/I-FromBranch-feature/F into feature/F
	| | |\
	| | | * eeb0c83 new issues
	| | | * 9f44563 bad close trial branch issues/I-FromBranch-feature/F%trials.T1
	| | | *   f0c23e1 Merge good trial branch issues/I-FromBranch-feature/F%trials.T2 into issues/I-FromBranch-feature/F
	| | | |\
	| | | | * cbb65da trials2
	| | | | *   709718d Merge good trial branch issues/I-FromBranch-feature/F%trials.T2%trials.T21 into issues/I-FromBranch-feature/F%trials.T2
	| | | | |\
	| | | | | * d7ffa4f trials21
	| | | | |/
	| | | | * e1f90d8 trials2
	| | | |/
	| | | * c1893a8 new issues
	| | | * f95d67e issues branch to be tested
	| | |/
	| | * 5d136b5 new features
	| | * eb0382b feature branch to be tested
	| |/
	| * af26b73 new changes in inDevelop
	| *   234a448 Merge branch release-v0.2 into develop
	| |\
	* | \   61c5763 (tag: v0.2) Merge release branch release-v0.2 into master
	|\ \ \
	| | |/
	| |/|
	| * | b6eb6ee modify the version number in README
	| |/
	| * ff2afde Start to release version v0.2
	| *   5a6b58e Merge feature branch feature/fly into develop
	| |\
	| | * c7d0029 add more new feature in feature/fly branch
	| | *   e07f040 Merge issue branch issues/#2-FromBranch-feature/fly into feature/fly
	| | |\
	| | | * 230641b fix issues
	| | |/
	| | * 91f197b add more new feature in feature/fly branch
	| | *   a7e2e34 Merge(update) branch develop into feature/fly
	| | |\
	| | |/
	| |/|
	| * | efde126 new changes in inDevelop
	| | * 322ec12 add new feature in feature/fly branch
	| | * 36f29de use empty commit to make a relative loooooooooooooooooooooooooooooooooooooooooooong description for this branch
	| |/
	| * 7f976ec some changes in develop
	| *   67b7ba3 Merge hotfix branch hotfix-v0.1.1 into develop
	| |\
	| * \   e6efba5 Merge branch release-v0.1 into develop
	| |\ \
	* | \ \   8dd0ebb (tag: v0.1.1) Merge hotfix branch hotfix-v0.1.1 into master
	|\ \ \ \
	| | |_|/
	| |/| |
	| * | | 3df70cb close hotfix-v0.1.1
	| * | |   f56870a Merge issue branch issues/#1-FromBranch-hotfix-v0.1.1 into hotfix-v0.1.1
	| |\ \ \
	| | * | | 16d44b0 fix bugs for issues/#1/test/for/multi/slash/name
	| |/ / /
	| * | | 59c8b5a fix bugs in hotfix v0.1.1
	|/ / /
	* | |   f85f788 (tag: v0.1) Merge release branch release-v0.1 into master
	|\ \ \
	| | |/
	| |/|
	| * | a6d8690 modify the version number in README
	| |/
	| * d498a72 Start to release version v0.1
	| * fd357b5 (tag: someTagName) make some changes and then we can make a release
	| * c70c146 add file in master, but we can only commit in develop
	| * ec08ac9 add file in develop
	|/
	* 88e28f3 (test|master, test|develop) Init commit as gg repertory
	* 8717a5f init a repository
