# .bash_profile

This is a collection of bash utilities. It contains:

- [x] PS1 customization with Git and Svn integration.
- [x] Bash Completions for Git and Svn.
- [x] set/unset proxy faster.
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

Open and modify your `~/.bash_profile`, add the following scripts at top of it.

```sh
# base import
source ~/bash_profile/.bash_profile

# PS1 customization with Git integration
source ~/bash_profile/.bash_profile__git

# PS1 customization with Svn integration
source ~/bash_profile/.bash_profile__svn
```


## Git and Svn completion

If you want to use the git and svn completion, just run following scripts.

```sh
# Bash Completion for GIT
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.bash_completion_git

# Bash Completion for SVN
curl http://svn.apache.org/repos/asf/subversion/trunk/tools/client-side/bash_completion -o ~/.bash_completion_svn
```
