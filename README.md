gg
======================

About
-------

This bash command script is to achieve "a-successful Git branching model" in http://nvie.com/posts/a-successful-git-branching-model.

There are 4 types of branches, `master` and `develop` are long-time branches who will always be there and `newFeature.\*`, `release-\*` and `hotfix-\*` branches can only live a short time, the hole model please read the article mentioned.

Usage
-------
gg-init
	Initialized empty Git repository and make a develop branch.

gg-default.gitignore
	Generate .gitignore to exclude *~ and *swp files.

gg-feature-open newFeatureName
	Generate a newFeatre branch named newFeatre.newFeatureName.

gg-feature-close
	Merge the newFeature branch into develop branch, then delete it.

gg-release-open versionNum
	Generate a release branch named release-versionNum.

gg-release-close
	Merge the release branch into develop branch and master branch, then delete it.

gg-hotfix-open versionNum
	Generate a hotfix branch named release-versionNum.

gg-hotfix-close
	Merge the hotfix branch into develop branch and master branch, then delete it.
