#@printf "\e[30;48;5;82m>>>>\e[0m "
#@printf "\e[44m# \e[0m\n"
all:
	@printf "\e[44m delete .git if it exists \e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	rm -rf .git || echo "no .git direcory"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	rm *.txt || echo "no txt to delete"
	rm .deletedTrailsBranchs || echo "no .deletedTrailsBranchs to delete"
	#=============================================
	@printf "\e[44m# demo for gg \e[0m\n"
	@printf "\e[44m# first we init a git repository \e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git init
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add makefile
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit --allow-empty -m "init a repository"
	#=============================================
	@printf "\e[44m# make it into the gg structure(have a master-develop pair) \e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-init
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate
	#=============================================
	@printf "\e[44m# we can also make another master-develop pair with prefix like somename|master and somename|develop\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-create-new-develop-branch-pair test
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate
	 
	@printf "\e[44m# gg-ck to quickly switch between develop and master with the same prefix\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck d
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck m
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git checkout master
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck m
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck d
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git checkout test\|develop
	#=============================================
	@printf "\e[44m# now make some changes\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "in develop" > inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m "add file in develop"
	 
	@printf "\e[44m# now checkout to master and try to make some change\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck m
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "in master" > inMaster.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inMaster.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m "add file in master" || echo "\tfailed to commit in master"
	 
	@printf "\e[44m# now we stash and go to develop to commint\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git stash
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck d
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git stash pop
	@printf "\e[30;48;5;82m>>>>\e[0m "
	 
	git commit -m "add file in master, but we can only commit in develop"
	@printf "\e[44m# make some changes and try to make a release \e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some changes" >> inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some bugs\n more bug...\n bug everywhere..." >> inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m "make some changes and then we can make a release"
	 
	@printf "\e[44m# now make a release\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git tag -a "someTagName" -m "comments"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-open || printf "\e[44m# without input arg, we can have a list of the current tags, which can help us to give a name of our release\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-open v0.1
	 
	@printf "\e[44m# and then make some changes just for release(e.g. change the version number in README)\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "version: v0.1" > README.txt && git add README.txt && git cm -m "modify the version number in README"
	 
	@printf "\e[44m# you can also do nothing here..\e[0m\n"
	@printf "\e[44m# now we close the release and see what happend\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate --graph
	 
	@printf "\e[44m# Oh!! we find a bug in the released version.. now try to fix it!!\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	cat inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-hotfix-open || printf "\e[44m# Oh!! we need to go to the master branch to open a hotfix..\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck m
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-hotfix-open || printf "\e[44m# without input arg, we can have a list of the current tags, which can help us to give a name of our hotfix\e[0m\n"
	@printf "\e[44m# because last version is v0.1, i give the name of the hotfix v0.1.1\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-hotfix-open v0.1.1
	@printf "\e[44m# fix the bug\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	sed '/bugs/d' inDevelop.txt > temp.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	mv temp.txt inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m "fix bugs in hotfix v0.1.1"
	@printf "\e[44m# the bug is reported as a issue #1 in our github, to make it more clear, we can make a issue branch\e[0m\n"
	@printf "\e[44m# issue branch can be made in branchs other than master and release\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-open "#1/test/for/multl/slash/name"
	@printf "\e[44m# fix the bugs\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	sed '/bug/d' inDevelop.txt > temp.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	mv temp.txt inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m "fix bugs for issues/#1/test/for/multi/slash/name"
	@printf "\e[44m# now close issues branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "version: v0.1.1" > README.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add README.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m"close hotfix-v0.1.1"
	@printf "\e[44m# now we finish the hotfix\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-hotfix-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate --graph
	 
	@printf "\e[44m# now let us try the issues, features and trial branch in the develop branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some changes in develop" >> inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inDevelop.txt && git commit -m "some changes in develop"
	@printf "\e[44m# now we want to develop a new feature\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-open fly/test
	@printf "\e[44m# make a empty commit with some comment for this branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-comment "use empty commit to make a relative loooooooooooooooooooooooooooooooooooooooooooong description for this branch"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "new features" >> newFeature.txt && git add newFeature.txt && git commit -m "add new feature in feature/fly/test branch"
	@printf "\e[44m# while the develop branch is also under development\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck d && echo "some changes in develop" >> inDevelop.txt && git add inDevelop.txt && git commit -m"new changes in inDevelop"
	@printf "\e[44m# we want to update our feature branch with the latest develop branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-update || printf "\e[44m# we forgot to change the branch..\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git checkout test\|feature/fly/test
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-update || printf "\e[44m# we forgot to change the branch..\e[0m\n"
	@printf "\e[44m# now add more feature\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "more features" >> newFeature.txt && git add newFeature.txt && git commit -m "add more new feature in feature/fly/test/ branch"
	@printf "\e[44m# now we try to open a issue in the feature brach and close it\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-open "#2/test/for/multl/slash/name/"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "fix issues" >> newFeature.txt && git add newFeature.txt && git commit -m "fix issues"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-close
	 
	@printf "\e[44m# add new feature and close feature\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "more features" >> inDevelop.txt && git add inDevelop.txt && git commit -m "add more new feature in feature/fly/test branch"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate --graph
	 
	@printf "\e[44m# release another version\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-open v0.2
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "version: v0.2" > README.txt && git add README.txt && git cm -m "modify the version number in README"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate --graph --tags
	 
	@printf "\e[44m# last, let's try the trial branch. For test, i will start it on a issues branch of a feature branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck d && echo "some changes in develop" >> inDevelop.txt && git add inDevelop.txt && git commit -m"new changes in inDevelop"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-open testFeature/test
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-comment "feature branch to be tested"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some features" >> newFeature.txt && git add newFeature.txt && git commit -m"new features"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-open newIssues/test
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-comment "issues branch to be tested"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some issues" >> issues.txt && git add issues.txt && git commit -m"new issues"
	@printf "\e[44m# last, let's try the trial branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-open newTrial/1
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some trials" >> trials1.txt && git add trials1.txt && git commit -m"trials1"
	@printf "\e[44m# let's open another trial\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck f
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-open newTrial/2
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some trials" >> trials2.txt && git add trials2.txt && git commit -m"trials2"
	@printf "\e[44m# we can also open a trial branch on a trial branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-open newTrial/2/1
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some trials" >> trials21.txt && git add trials21.txt && git commit -m"trials21"
	@printf "\e[44m# now let's good-close a trial\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-good-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some trials" >> trials2.txt && git add trials2.txt && git commit -m"trials2"
	@printf "\e[44m# now let's good-close the trial from the issue branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-good-close
	@printf "\e[44m# now let's go to another trial branch and bad-close it (drop it)\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git checkout "test|issues/newIssues/test-FromBranch-test|feature/testFeature/test%trials.newTrial/1"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-bad-close
	@printf "\e[44m# let's close the issues and feature branch, make a new release and see the final network plot\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some issues" >> issues.txt && git add issues.txt && git commit -m"new issues"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some features" >> newFeature.txt && git add newFeature.txt && git commit -m"new features"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some changes in develop" >> inDevelop.txt && git add inDevelop.txt && git commit -m"new changes in inDevelop"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-open v0.3
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "version: v0.3" > README.txt && git add README.txt && git cm -m "modify the version number in README"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate --graph --tags
	@printf "\e[44m# some example about the name of issues and feature branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-open F;gg-issues-open I;gg-feature-open ff;gg-issues-open II
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-close;gg-feature-close;gg-issues-close;gg-feature-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-open F;gg-feature-open F;gg-feature-open FF;gg-issues-open II
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-close;gg-feature-close;gg-feature-close;gg-issues-close
	@printf "\e[44m# test release branch with no name\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-open none
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-close
	@printf "\e[44m# test to make feature and issues branch in 'detached HEAD' state\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git checkout HEAD^^^; gg-feature-open D; touch test.txt; git add test.txt; git commit -m "add test.txt"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-close
	@printf "\e[44m# last comment: to fully test gg, i use the develop-master pair (test|develop and test|master) and\n\tvery complex name(with some / inside) for the branches, if you want to get simpler demo, use make simple\e[0m\n"
simple:
	@printf "\e[44m delete .git if it exists \e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	rm -rf .git || echo "no .git direcory"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	rm *.txt || echo "no txt to delete"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	rm .deletedTrailsBranchs || echo "no .deletedTrailsBranchs to delete"
	#=============================================
	@printf "\e[44m# demo for gg \e[0m\n"
	@printf "\e[44m# first we init a git repository \e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git init
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add makefile
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit --allow-empty -m "init a repository"
	#=============================================
	@printf "\e[44m# make it into the gg structure(have a master-develop pair) \e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-init
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate
	#=============================================
	@printf "\e[44m# we can also make another master-develop pair with prefix like somename|master and somename|develop\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-create-new-develop-branch-pair test
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate
	 
	@printf "\e[44m# gg-ck to quickly switch between develop and master with the same prefix\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck d
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck m
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git checkout master
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck m
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck d
	#=============================================
	@printf "\e[44m# now make some changes\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "in develop" > inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m "add file in develop"
	 
	@printf "\e[44m# now checkout to master and try to make some change\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck m
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "in master" > inMaster.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inMaster.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m "add file in master" || echo "\tfailed to commit in master"
	 
	@printf "\e[44m# now we stash and go to develop to commint\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git stash
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck d
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git stash pop
	@printf "\e[30;48;5;82m>>>>\e[0m "
	 
	git commit -m "add file in master, but we can only commit in develop"
	@printf "\e[44m# make some changes and try to make a release \e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some changes" >> inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some bugs\n more bug...\n bug everywhere..." >> inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m "make some changes and then we can make a release"
	 
	@printf "\e[44m# now make a release\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git tag -a "someTagName" -m "comments"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-open || printf "\e[44m# without input arg, we can have a list of the current tags, which can help us to give a name of our release\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-open v0.1
	 
	@printf "\e[44m# and then make some changes just for release(e.g. change the version number in README)\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "version: v0.1" > README.txt && git add README.txt && git cm -m "modify the version number in README"
	 
	@printf "\e[44m# you can also do nothing here..\e[0m\n"
	@printf "\e[44m# now we close the release and see what happend\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate --graph
	 
	@printf "\e[44m# Oh!! we find a bug in the released version.. now try to fix it!!\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	cat inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-hotfix-open || printf "\e[44m# Oh!! we need to go to the master branch to open a hotfix..\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck m
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-hotfix-open || printf "\e[44m# without input arg, we can have a list of the current tags, which can help us to give a name of our hotfix\e[0m\n"
	@printf "\e[44m# because last version is v0.1, i give the name of the hotfix v0.1.1\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-hotfix-open v0.1.1
	@printf "\e[44m# fix the bug\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	sed '/bugs/d' inDevelop.txt > temp.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	mv temp.txt inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m "fix bugs in hotfix v0.1.1"
	@printf "\e[44m# the bug is reported as a issue #1 in our github, to make it more clear, we can make a issue branch\e[0m\n"
	@printf "\e[44m# issue branch can be made in branchs other than master and release\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-open "#1"
	@printf "\e[44m# fix the bugs\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	sed '/bug/d' inDevelop.txt > temp.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	mv temp.txt inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m "fix bugs for issues/#1/test/for/multi/slash/name"
	@printf "\e[44m# now close issues branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "version: v0.1.1" > README.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add README.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git commit -m"close hotfix-v0.1.1"
	@printf "\e[44m# now we finish the hotfix\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-hotfix-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate --graph
	 
	@printf "\e[44m# now let us try the issues, features and trial branch in the develop branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some changes in develop" >> inDevelop.txt
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git add inDevelop.txt && git commit -m "some changes in develop"
	@printf "\e[44m# now we want to develop a new feature\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-open fly
	@printf "\e[44m# make a empty commit with some comment for this branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-comment "use empty commit to make a relative loooooooooooooooooooooooooooooooooooooooooooong description for this branch"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "new features" >> newFeature.txt && git add newFeature.txt && git commit -m "add new feature in feature/fly branch"
	@printf "\e[44m# while the develop branch is also under development\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck d && echo "some changes in develop" >> inDevelop.txt && git add inDevelop.txt && git commit -m"new changes in inDevelop"
	@printf "\e[44m# we want to update our feature branch with the latest develop branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-update || printf "\e[44m# we forgot to change the branch..\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git checkout feature/fly
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-update || printf "\e[44m# we forgot to change the branch..\e[0m\n"
	@printf "\e[44m# now add more feature\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "more features" >> newFeature.txt && git add newFeature.txt && git commit -m "add more new feature in feature/fly branch"
	@printf "\e[44m# now we try to open a issue in the feature brach and close it\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-open "#2"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "fix issues" >> newFeature.txt && git add newFeature.txt && git commit -m "fix issues"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-close
	 
	@printf "\e[44m# add new feature and close feature\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "more features" >> inDevelop.txt && git add inDevelop.txt && git commit -m "add more new feature in feature/fly branch"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate --graph
	 
	@printf "\e[44m# release another version\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-open v0.2
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "version: v0.2" > README.txt && git add README.txt && git cm -m "modify the version number in README"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate --graph --tags
	 
	@printf "\e[44m# last, let's try the trial branch. For test, i will start it on a issues branch of a feature branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck d && echo "some changes in develop" >> inDevelop.txt && git add inDevelop.txt && git commit -m"new changes in inDevelop"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-open F
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-comment "feature branch to be tested"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some features" >> newFeature.txt && git add newFeature.txt && git commit -m"new features"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-open I
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-comment "issues branch to be tested"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some issues" >> issues.txt && git add issues.txt && git commit -m"new issues"
	@printf "\e[44m# last, let's try the trial branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-open T1
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some trials" >> trials1.txt && git add trials1.txt && git commit -m"trials1"
	@printf "\e[44m# let's open another trial\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-ck f
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-open T2
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some trials" >> trials2.txt && git add trials2.txt && git commit -m"trials2"
	@printf "\e[44m# we can also open a trial branch on a trial branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-open T21
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some trials" >> trials21.txt && git add trials21.txt && git commit -m"trials21"
	@printf "\e[44m# now let's good-close a trial\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-good-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some trials" >> trials2.txt && git add trials2.txt && git commit -m"trials2"
	@printf "\e[44m# now let's good-close the trial from the issue branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-good-close
	@printf "\e[44m# now let's go to another trial branch and bad-close it (drop it)\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git checkout "issues/I-FromBranch-feature/F%trials.T1"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-trials-bad-close
	@printf "\e[44m# let's close the issues and feature branch, make a new release and see the final network plot\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some issues" >> issues.txt && git add issues.txt && git commit -m"new issues"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some features" >> newFeature.txt && git add newFeature.txt && git commit -m"new features"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "some changes in develop" >> inDevelop.txt && git add inDevelop.txt && git commit -m"new changes in inDevelop"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-open v0.3
	@printf "\e[30;48;5;82m>>>>\e[0m "
	echo "version: v0.3" > README.txt && git add README.txt && git cm -m "modify the version number in README"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-close
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git --no-pager log --oneline --decorate --graph --tags
	@printf "\e[44m# some example about the name of issues and feature branch\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-open F;gg-issues-open I;gg-feature-open ff;gg-issues-open II
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-issues-close;gg-feature-close;gg-issues-close;gg-feature-close
	@printf "\e[44m# test release branch with no name\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-open none
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-release-close
	@printf "\e[44m# test to make feature and issues branch in 'detached HEAD' state\e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	git checkout HEAD^^^; gg-feature-open D; touch test.txt; git add test.txt; git commit -m "add test.txt"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	gg-feature-close

clean:
	@printf "\e[44m delete .git if it exists \e[0m\n"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	rm -rf .git || echo "no .git direcory"
	@printf "\e[30;48;5;82m>>>>\e[0m "
	rm *.txt || echo "no txt to delete"
	rm .deletedTrailsBranchs || echo "no .deletedTrailsBranchs to delete"
