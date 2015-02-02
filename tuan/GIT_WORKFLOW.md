### Git workflow

Some quick steps to set up our git in a way that would make it easy for multiple people to collaborate on large projects using feature branches with manageable/smaller pull requests.

Using git shortcuts is highly recommended, as it would save you a lot of time. There are multiple ways to make shortcuts -- you can define aliases in the `.gitconfig` file ([example)](https://github.com/flexport/dotfiles/blob/master/.gitconfig)), or if you find yourself typing these git commands over too many times a day, you can also add aliases to your `~/.bash_profile` ([example](https://github.com/flexport/dotfiles/blob/master/tuan/git_aliases)) for even more sugar.

When we first clone the flexport repo, the remote setup would look like this:
```
$ git remote -v show
origin  git@github.com:flexport/flexport.git (fetch)
origin  git@github.com:flexport/flexport.git (push)
```

Step 1. Fork the main repo and make sure your local master is tracking the remote origin master:
```
git branch --set-upstream-to=origin/master master
```
Step 2. Change the push destination of `origin` to your fork:
```
git remote set-url --push origin git@github.com:[your_user_name]/flexport.git
```
Step 3. Add a separate remote to the main repo in case you need to push something to it directly:
```
git remote add flexport git@github.com:flexport/flexport.git
```
Step 4. Add a separate remote to your fork in case you need to pull something from it to your local repo:
```
git remote add [your_name] git@github.com:[your_user_name]/flexport.git
```

Here is what your git remote would look like afterwards:
```
$ git remote -v show
flexport  git@github.com:flexport/flexport.git (fetch)
flexport  git@github.com:flexport/flexport.git (push)
origin  git@github.com:flexport/flexport.git (fetch)
origin  git@github.com:[your_user_name]/flexport.git (push)
[your_name]  git@github.com:[your_user_name]/flexport.git (push)
[your_name]  git@github.com:[your_user_name]/flexport.git (fetch)
```

#### (A) Workflow for bug fixes or small features:

Step 1. Create a new local branch tracking the main repo's master
```
$ gba issue_1234
```
Step 2. Make sure your branch is up to date by rebasing it
```
$ gpr
```
Step 3. Make changes to fix a bug or implement a small issue...

...

Step 4. Commit all changes
```
$ gc "Fix #1234. Sushi shouldn't smell like fish; add test."
```
Step 5. Make sure there is no conflicts with current state of master on the main repo
```
$ gpr
```
Step 6. If there are conflicts, work with the other committer(s) to resolve them, and finish the rebase
```
$ grc
```
Step 7. Push new code to your fork
```
$ gup
```
Step 8. Create a pull request from the branch issue_1234 on your fork to flexport/master to get the code reviewed and merged. Assuming you are already using [hub](https://github.com/github/hub):
```
$ greq
```

#### (B) Multiple people collaborating on the same feature branch:

Step 0. One of the collaborator creates a new feature branch on the main repo
```
$ gba sushi
$ gup flexport sushi
```

Each collaborator then can follow the same workflow as (A) to gradually build the huge sushi feature. The only difference is that the remote branch where everyone would pull from and submit pull request to should now be `origin:sushi` instead of `origin:master`. So:

Step 1a. Create a new local branch tracking the main repo's sushi
```
$ gba migration sushi
```
...

Step 8a. Create a pull request from the branch sushi_migration on your fork to flexport:sushi to get the code reviewed and merged.
```
$ greq sushi
```

Occasionally during this sushi project, you will need to update the feature branch with latest from master. The best way to do that is also to submit a pull request so that other collaborators would be aware of what's going on with the branch they're working on.
```
$ gba water sushi
$ gp
$ gm master
# resolve conflicts if there are any.
$ gc "Update from master"
$ gup
$ greq sushi
```

When the project is completed, make a pull request from flexport:sushi to flexport:master for final review, merge and deployment.
```
greq flexport:master flexport:sushi
```
