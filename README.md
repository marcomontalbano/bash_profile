![](https://img.shields.io/badge/available_for-osx-green.svg?style=flat-square)
![](https://img.shields.io/badge/available_for-ubuntu-green.svg?style=flat-square)
![](https://img.shields.io/badge/available_for-windows-red.svg?style=flat-square)

# .bash_profile

This is a collection of bash utilities. It contains:

- [x] PS1 customization with Git and Svn integration.
- [x] Bash Completions for Git and Svn.
- [x] set/unset proxy faster.
- [x] Updatable `bash_profile` project.
- [ ] Pygmentize


## Get started

Clone this project in your home folder `~`.

```sh
# clone with SSH
cd ~ && git clone git@github.com:marcomontalbano/bash_profile.git

# OR

# clone with HTTPS
cd ~ && git clone https://github.com/marcomontalbano/bash_profile.git
```

Open and modify your `~/.bash_profile` on OSX or `~/.bashrc` on Ubuntu, adding the following scripts.

```sh
# base import
source ~/bash_profile/.bash_profile

# PS1 customization with Git integration
source ~/bash_profile/.bash_profile__git

# PS1 customization with Svn integration
source ~/bash_profile/.bash_profile__svn
```


## Git and Svn completion (OSX only)

If you want to use the git and svn completion, just run following scripts.

```sh
# Bash Completion for GIT
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.bash_completion_git

# Bash Completion for SVN
curl http://svn.apache.org/repos/asf/subversion/trunk/tools/client-side/bash_completion -o ~/.bash_completion_svn
```

## PS1 customization

![](images/PS1.png)

### Git integration

![](images/git--no-changes.png)

![](images/git--with-changes.png)

![](images/git--new-branch-no-changes--text.png)
![](images/git--new-branch-no-changes-pushed.png)

![](images/git--new-branch-with-changes--text.png)
![](images/git--new-branch-with-changes-pushed.png)
