# .bash_profile

This is a collection of bash utilities. It contains:

- [x] PS1 customization with Git and Svn integration.
- [x] Bash Completions for Git and Svn.
- [x] set/unset proxy faster.
- [ ] Pygmentize


### Get started

Download this project in your home folder.

```sh
cd ~ && git clone git@github.com:marcomontalbano/bash_profile.git
```

Open your `.bash_profile` and add the following script at top of it.

```sh
source ~/bash_profile/.bash_profile
```

### Git and Svn completion

If you want to use the git and svn completion, just run following scripts.

```sh
# Bash Completion for GIT
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.bash_completion_git

# Bash Completion for SVN
curl http://svn.apache.org/repos/asf/subversion/trunk/tools/client-side/bash_completion -o ~/.bash_completion_svn
```
