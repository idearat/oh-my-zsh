#!/usr/local/bin/zsh

# This file is executed indirectly via the oh-my-zsh.sh script which processes
# any files ending in .zsh which are found in the 'custom' directory. The file
# ${HOME}/.zshrc is a trivial wrapper which leverages that script after
# configuring zsh plugins including those for git and tmux in particular.

# ---
# path roots
# ---

# do these first since it prepends to the path and we don't want anything in
# front of ~/bin. we want to retain ultimate override ability.
eval "$(rbenv init - zsh)" > /dev/null 2>&1
source $(brew --prefix nvm)/nvm.sh > /dev/null 2>&1

# now set it manually thank you very much so ~/bin can always override.
export PATH="${HOME}/bin:${HOME}/.nvm/v0.10.24/bin"
export PATH="${PATH}:${HOME}/.rbenv/shims:/usr/local/bin:/usr/local/bin/araxis"
export PATH="${PATH}:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

export MANPATH=".:${HOME}/man:/usr/local/man:/usr/local/share/man:/usr/man:\
  /usr/bin/man:/usr/share/man:/usr/share/locale/en/man:/usr/X11R6/man"

export DEVL_HOME="${HOME}/dev"
export USB_ROOT='/Volumes/secure'

# ---
# shell options
# ---

set -o noclobber
set -o ignoreeof
set -o vi

# ---
# shell variables
# ---

export CLICOLOR=1
export IGNOREEOF=1
export LC_TYPE='en_US.UTF-8'
export LESS=FRSX
export LS_OPTIONS='--color=auto'
export LSCOLORS='gxgxfxfxcxdxdxhbadbxbx'
export TERM=xterm-256color

# ---
# zsh upgrades
# ---

autoload -U compinit
compinit

setopt completeinword

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

autoload select-word-style
select-word-style shell

# extended globs
setopt extendedglob
unsetopt caseglob

export REPORTTIME=10

# ---
# history setup
# ---

HISTFILE=${HOME}/.zhistory
HISTSIZE=SAVEHIST=10000
setopt extendedhistory
unsetopt sharehistory

# ---
# project roots
# ---

export IDEARAT_HOME="${DEVL_HOME}/idearat"
export PROJECT_HOME="${DEVL_HOME}/idearat"

export TPI_HOME="${DEVL_HOME}/TPI"
export TIBET_HOME="${TPI_HOME}/TIBET"
export CODESWARM_HOME="${TPI_HOME}/CodeSwarm"
export FIRSTCLASS_HOME="${PROJECT_HOME}/FirstClass"

alias cdcs='cd ${CODESWARM_HOME}'
alias cdfb='cd ${PROJECT_HOME}/fiscalball'
alias cdfc='cd ${FIRSTCLASS_HOME}'
alias cdtab='cd ${PROJECT_HOME}/tabmarks'
alias cdviz='cd ${PROJECT_HOME}/vizitd'

# ---
# config files
# ---

alias cddot="cd ${HOME}/.dotfiles"
alias cdvim='cd ${HOME}/.vim/bundle'
alias cdzsh='cd ${HOME}/.oh-my-zsh/plugins'

alias vimit="vi ${HOME}/.oh-my-zsh/custom/idearat.zsh"
alias srcit="source ${HOME}/.zshrc"

alias vimdot="vi ${HOME}/.dotfiles/install.sh"
alias vimgit="vi ${HOME}/.gitconfig"
alias vimtmux="vi ${HOME}/.tmux.conf"

alias vimvi="vi ${HOME}/.vimrc.after"
alias vimlocal="vi ${HOME}/.localrc"
alias vimcolor="vi ${HOME}/.vim/bundle/idearat/colors/idearat"
alias vimsyntax="vi ${HOME}/.vim/bundle/idearat/syntax/javascript.vim"

# ---
# listings
# ---

alias l='ls -Fh'
alias la='ls -aFh'
alias ll='ls -lFh'
alias lla='ls -laFh'

# ---
# common flags
# ---

alias bc='bc -l'
alias cls='clear; ls'
alias cp='cp -i'
alias df='df -H'
alias du='du -ch'
alias egrep='egrep --color=auto'
alias env='env | sort'
alias fgrep='fgrep --color=auto'
alias ftp='ftp -i'
alias grep='grep --color=auto'
alias h='history'
alias ifconfig='ifconfig -a'
alias jobs='jobs -l'
alias ln='ln -i'
alias lynx='lynx -vikeys'
alias md5='md5 -r'
alias md5sum='md5 -r'
alias mkdir='mkdir -pv'
alias mv='mv -i'
alias ping='ping -c 5'
alias psw='ps auxww'
alias rm='rm -i'
alias su='sudo -i'
alias tail="tail -f"
alias tmux="tmux -2"
alias wget='wget -c'
alias x="exit"  # don't want X-Quartz anyway ;)

# ---
# common destinations
# ---

alias ..='cd ..'
alias ...='cd ../../../'
alias cdbin="cd ${HOME}/bin"
alias cddev="cd ${DEVL_HOME}"
# NB: depends on having cloned into ${HOME}/.dotfiles.
alias cdidearat='cd ${IDEARAT_HOME}'
alias cdsrc='cd /usr/local/src'
alias cdtmp="cd ${HOME}/tmp"
alias cdtri="cd ${HOME}/Documents/SS\ Docs/Triathlon"
alias cdusb="cd ${USB_ROOT}"

# ---
# unaliases
# ---

# Seriously, I'm never gonna use these, but I do use 3 and 5 for aliasing into
# specific versions of TIBET.
unalias 1
unalias 2
unalias 3
unalias 4
unalias 5
unalias 6
unalias 7
unalias 8
unalias 9

# ---
# utility Aliases
# ---

alias todo="vim ~/Dropbox/todo.md"
alias more='less'
alias vi='vim'

alias myip="curl ipv4.icanhazip.com"
# Show time/date in easy form.
alias now='date +"%T"'
alias nowtime='now'
alias nowdate='date +"%d-%m-%Y"'

alias rmorig="\\ls -a | grep '_orig$' | xargs -n 1 rm -rf"
alias rmzcomp="\\ls -a | grep 'zcompdump' | xargs -n 1 rm -rf"

# Output decent size information
alias sizes='du -s *'

# NB: this relies on vim config to put temp files in ${HOME}/tmp
alias swapped='find ${HOME}/tmp -name '"'*.sw[op]'"' -print'

# ---
# utility functions
# ---

# Common prompting routine for querying the user with defaults for Y/N.
# Adapted for ZSH based on original at https://gist.github.com/1965569.
function ask () {
    local REPLY
    local prompt
    local default
    while [ -z $REPLY ]; do
        if [[ "${2:-}" = "Y" ]]; then
            prompt="Y/n"
            default="y"
        elif [[ "${2:-}" = "N" ]]; then
            prompt="y/N"
            default="n"
        else
            prompt="y/n"
            default=""
        fi

        read "REPLY?$1 [$prompt] "

        if [[ -z $REPLY ]]; then
          REPLY=$default
        fi
    done

    if [[ $REPLY = "y" ]]; then
      return 0
    elif [[ $REPLY = "n" ]]; then
      return 1
    fi
}

# Dump a list of any submodules which may have detached heads. This is necessary
# to avoid editing in a detached state, which effectively ensures your edits are
# a complete loss.
function detached () {
  local IFS_COPY=$IFS
  IFS=$'\n';
  data=($(git submodule foreach 'git status --branch --porcelain'))
  IFS=$IFS_COPY

  # Sample output...but note git output breaks at ' '
  # Entering 'vim/vim/bundle/vim-dispatch'
  # ## master...origin/master
  # Entering 'vim/vim/bundle/vim-fugitive'
  # ## HEAD (no branch)
  # Entering 'zsh/oh-my-zsh'
  # ## master...origin/master
  #  M custom/idearat.zsh

  for line in $data; do
    if [[ $line =~ "^Entering" ]]; then
      repo=$line[11,-2]
    fi
    if [[ $line =~ "HEAD" ]]; then
      echo $repo
    fi
  done
}

# Test for existence of a command. used for cmd-specific setups later.
# NB: it appears ZSH does better at this than Bash when using 'which'.
function exists () {
  command -v "$@" &>/dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    return 0
  else
    return 1
  fi
}

# Goal here is to get a list of files by name without junk from subversion or
# similar directory trees. Prune them (to avoid descent) and then remove the
# directory from the resulting file list via grep -v. Note the trailing sed
# line which handles filenames with blanks.
function findem () {
  find . -name .svn -prune -o -name .git -prune -o -name node_modules\
    -prune -o -name "*$1*" 2<&1 | grep -v '\.svn' | grep -v '\.git' |\
    grep -v 'node_modules' | grep -v 'thirdParty' |\
    grep -v 'Permission denied' | grep -v '\.sw[op]' |\
    grep -v '\.class' | sed 's/\ /\\ /g'
}

# Regex-driven update of javascript-specific CTAGS data. Prunes nested levels of
# node_modules but allows for the first level so you can drill down into libs.
# Run this in the directory you want searched.
function jstags () {
  find . -name '*.js' | grep -v 'node_modules/.*/node_modules' | grep -v '\.min\.js' |\
  ctags -L - -R --langdef=js --langmap=js:.js \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*\{/\5/,object/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*function[ \t]*\(/\5/,function/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*\[/\5/,array/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*[^\"]'[^']*/\5/,string/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*(true|false)/\5/,boolean/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*[0-9]+/\5/,number/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*=[ \t]*.+([,;=]|$)/\5/,variable/" \
  --regex-js="/(,|(;|^)[ \t]*(var|let|([A-Za-z_$][A-Za-z0-9_$.]+\.)*))[ \t]*([A-Za-z0-9_$]+)[ \t]*[ \t]*([,;]|$)/\5/,variable/" \
  --regex-js="/function[ \t]+([A-Za-z0-9_$]+)[ \t]*\([^)]*\)/\1/,function/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*\{/\2/,object/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*function[ \t]*\(/\2/,function/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*\[/\2/,array/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*[^\"]'[^']*/\2/,string/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*(true|false)/\2/,boolean/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*[0-9]+/\2/,number/" \
  --regex-js="/(,|^)[ \t]*([A-Za-z_$][A-Za-z0-9_$]+)[ \t]*:[ \t]*[^=]+([,;]|$)/\2/,variable/" \
  "$@"
}

# Interactively kill listener processes. Often needed when shutting down
# certain systems whose sub-processes don't always die cleanly. I'm looking at
# you Java.
function killem () {
  local IFS_COPY=$IFS
  IFS=$'\n';
  procs=( $(listeners "$*") )
  IFS=$IFS_COPY

  local last=''
  for line in $procs; do
    local pid=$(echo $line | awk '{print $2}')
    local ident=$(echo $line | awk '{print ("  ", $1, "(", $2, ")") }')
    if [[ $pid -eq $last ]]; then
      continue
    fi

    echo -e $line
    last=$pid
    ask "kill -9 $ident ?" N;
    if [[ $? -eq 0 ]]; then
      kill -9 $pid
    fi
  done
}

# List all processes that are listening on ports. Useful for debugging
# EADDRINUSE errors. Leveraged by killem() to provide input for kill.
function listeners () {
  local cmd='lsof -i -P | grep -i "listen"'
  if [[ $# > 0 ]];  then
    cmd="$cmd | grep \"$*\""
  fi
  eval $cmd
}

# Dump link (if found) for a particular pattern (if no params shows all).
function lnks () {
  ls -la | grep " ->" | grep "$*" | awk '{print $9, $10, $11}'
}

# Dump path list split on ':' so it's readable as an ordered list.
function paths () {
  echo ${PATH} | awk 'BEGIN{RS=":";} {print;}'
}

# Dump the real version of a command being run. This is 'which' but it will
# traverse at least one link level to point to a true target executable.
function real () {
  local src=`which $*`
  src=$(ls -al $src | grep "\->" | grep "$*" | awk '{print $9, $10, $11}')
  if [[ ${#src} -ne 0 ]]; then
    echo $src
  else
    which "$@"
  fi
}

# Find a directory containing a specific file. Useful for locating a "starting
# directory" for various operations within project directories like linting.
function root () {
  file="$1"
  dir=$PWD
  while [[ $dir != '/' ]]; do
    if [[ -e $dir/$file ]]; then
      echo $dir
      break
    else
      dir=`dirname $dir`
    fi
  done
}

# Update submodules, bringing then back onto master branch and sync'ing.
function subup () {
  echo 'Updating git submodules...'
  git submodule init
  git submodule update --recursive
  git submodule foreach 'git fetch origin; git checkout master; git pull'
}

# Test for existence of a varable/export.
function varexists () {
  local VAR
  eval 'VAR=${'"$*"'}'
  if [[ -z $VAR ]]; then
    return 1
  fi
  return 0
}

# ---
# PATH-sensitive installations
# ---

# Now that our path is complete we can test for existence of various tools and
# install customizations/extensions as appropriate.


# Warn if we haven't got brew installed. We use it to install most everything
# else.
if ! exists brew; then
  echo 'brew not found'
  echo 'install brew via:'; echo
  echo 'ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"'
else
  # TODO: do we want brew doctor here?
fi

# Ack for common file types in web development.
if exists ack; then
  alias ackls='ack -l -s --ignore-dir="thirdParty" --ignore-dir="node_modules" --ignore-file=ext:map'
  alias ackall='ack -l -s --nolog --ignore-dir="thirdParty" --ignore-dir="node_modules" --ignore-file=ext:map'
  alias ackcss='ack -l -s --css --sass --less --ignore-dir="thirdParty" --ignore-dir="node_modules"'
  alias ackhtml='ack -l -s --html --ignore-dir="thirdParty" --ignore-dir="node_modules"'
  alias ackjs='ack -l -s --js --ignore-dir="thirdParty" --ignore-dir="node_modules"'
  alias ackjsish='ack -l -s --js --json --ignore-dir="thirdParty" --ignore-dir="node_modules"'
  alias ackjson='ack -l -s --json --ignore-dir="thirdParty" --ignore-dir="node_modules"'
  alias ackmd='ack -l -s --markdown --ignore-dir="thirdParty" --ignore-dir="node_modules"'
  alias ackxml='ack -l -s --xml --ignore-dir="thirdParty" --ignore-dir="node_modules"'
  alias ackvim='ack -l -s --vim --ignore-dir="thirdParty" --ignore-dir="node_modules"'
else
  echo 'ack not found'
  echo 'install ack via:';echo
  echo 'brew install ack'
fi

# Git, and if that's not here, well, that's curious :)
if exists git; then
  alias b="git branch"
  alias ba="git branch -a"
  alias d='git diff'
  alias s='git status --short --branch'
  alias t='git log --oneline --graph --all --date-order --first-parent --decorate=short'

  # ---
  # prompt
  # ---

  c_cyan=`tput setaf 6`
  c_red=`tput setaf 1`
  c_green=`tput setaf 2`
  c_sgr0=`tput sgr0`

  function trim_pwd ()
  {
    #   How many characters of the $PWD should be kept
    local pwdmaxlen=20
    #   Indicator that there has been directory truncation:
    #trunc_symbol="<"
    local trunc_symbol='...'
    if [[ ${#PWD} -gt $pwdmaxlen ]]; then
      local pwdoffset=$(( ${#PWD} - $pwdmaxlen ))
      newPWD="${trunc_symbol}${PWD:$pwdoffset:$pwdmaxlen}"
    else
      newPWD=${PWD}
    fi
    echo $newPWD
  }

  function parse_git_branch ()
  {
    if git rev-parse --git-dir >/dev/null 2>&1; then
      gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
    else
      return 0
    fi
    echo -e $gitver
  }

  function parse_git_user ()
  {
    if git rev-parse --git-dir >/dev/null 2>&1; then
          gitusr=$(git config user.name)
    else
      return 0
    fi
    echo -e $gitusr
  }

  function branch_color ()
  {
    if git rev-parse --git-dir >/dev/null 2>&1; then
      color=''
      if git diff --quiet 2>/dev/null >&2; then
        color="${c_green}"
      else
        color="${c_red}"
      fi
    else
      return 0
    fi
    echo -ne $color
  }

  export PS1='$(parse_git_user) [\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]] \[${c_red}\]$(trim_pwd)\[${c_sgr0}\] $ '
else
  echo 'git not found'
  echo 'install git via:';echo
  echo 'brew install git'
fi

# Node. Need this to install JS-related packages like JSHint etc.

# test for nvm and initialize it if found
if exists nvm; then
  nvm use v0.10.24 2 > /dev/null

  # TODO: adjust to the highest one found by default?
  export NODE_VERSION="v0.10.24"
  export NODE_PATH="${NVM_DIR}/${NODE_VERSION}/lib/node_modules:\
${HOME}/lib/node_modules:./node_modules"
  alias cdnvm="cd ${NVM_DIR}/${NODE_VERSION}/lib/node_modules"
fi

if ! exists node; then
  echo 'node not found'
  echo 'install node via:';echo
  echo 'nvm install {version}'
  echo 'install nvm from https://github.com/creationix/nvm'
fi

# OpenSSL
if exists openssl; then
  alias sha1='openssl sha1'
else
  echo 'openssl not found'
  echo 'install openssl via:';echo
  echo 'brew install openssl'
fi

# Perl
if exists perl; then
  # convert line-endings. probably an easier way now tho.
  alias fixcm="perl -ne 's/\cM/\n/g; print'"
  alias fixdos="perl -ne 's/\cM\cJ/\n/g; print'"
  alias fixmac="perl -ne 's/\cM/\n/g; print'"

  if exists wc.pl; then
    function loc () {
      find . -name "$*" -exec wc {} \; | wc.pl
    }
  fi
else
  echo 'perl not found'
  echo 'install perlbrew via:'; echo
  echo 'curl -kL http://install.perlbrew.pl | bash'
  echo 'source ${HOME}/perl5/perlbrew/etc/bashrc'
  echo 'perlbrew'
fi

# Python
if ! exists python; then
  echo 'python not found'
  echo 'install python via:'; echo
  echo 'brew install python'
fi

# Console Vim
if exists vim; then
  if [[ -e /usr/local/share/vim ]]; then
    export VIMRUNTIME="/usr/local/share/vim/vim74"
  else
    if [[ -e /usr/share/vim ]]; then
      export VIMRUNTIME="/usr/share/vim/vim74"
    fi
  fi
  export VISUAL=vim

  # Turn off flow control. This lets VIM have better access to these keys.
  stty start undef stop undef
else
  echo 'vim not found'
  echo 'install vim via:';echo
  echo 'brew install macvim --override-system-vim'
fi

# TODO: clean up a combination of GCL and JSHint
# Google Closure Linter
if exists gjslint; then
  alias glint="gjslint --jslint_error optional_type_marker,well_formed_author,\
    no_braces_around_inherit_doc,braces_around_type,blank_lines_at_top_level\
    --additional_extensions 'mu' --custom_jsdoc_tags=module,submodule,namespace"

  alias tlint="gjslint --jslint_error optional_type_marker,well_formed_author,\
    no_braces_around_inherit_doc,braces_around_type,blank_lines_at_top_level\
    --custom_jsdoc_tags=name,synopsis,description,example,returns,todo"
else
  echo 'gjslint not found'
  echo 'install gjslint via:';echo
  echo 'cd /usr/local/src'
  echo 'svn checkout http://closure-linter.googlecode.com/svn/trunk/ closure-linter-read-only';
  echo 'cd closure-linter-read-only'
  echo 'python ./setup.py install'
fi

# TODO: write something that actually works. This doesn't really work.
# relativize a path. $1 is the root, $2 is the path to relativize
function relative () {
  echo $2 | sed "s@$1@.@g"
}

# Lint just the files which have changed since the last commit. Designed to be
# run from anywhere within the project so you don't have to CD around.
function hintem () {
  # find the directory at/above us with the .git directory
  dir=$(root '.git')
  pushd $dir &>/dev/null

  # look for custom lint (for increased strictness hopefully ;))
  if [[ -e .jshintrc_local ]]; then
    rules='.jshintrc_local'
  else
    rules='.jshintrc'
  fi

  files=`git diff --name-only master | grep --color=never '\.js'`
  for f in $files; do
    echo "----- jshint --config $rules $f -----"
    jshint --config $rules $f
  done
  popd &>/dev/null
}

# Google Closure Linter, minus things we'll rely on from jshint settings or
# which are effectively non-bug/style concerns.
function glintem () {
  # find the directory at/above us with the .git directory
  dir=$(root '.git')
  pushd $dir &>/dev/null

  files=`git diff --name-only master | grep --color=never '\.js'`
  for f in $files; do
    glint $f | grep -v "Extra space after \"function" | grep -v "Line too long" | grep -v "Single-quoted string"
  done
  popd &>/dev/null
}

# Run both jshint and google's linter to get a complete picture.
alias lintem="hintem; glintem"

# ---
# /Applications
# ---

# Chrome
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
--enable-file-cookies --allow-file-access-from-files \
--js-flags=\"--debugger true --debug_code --expose-debug-as debug --expose-gc\""

# TODO: convert to something we can run from Alfred
[[ -e '/Applications/Marked.app/Contents/MacOS/Marked' ]] && \
  alias marked='/Applications/Marked.app/Contents/MacOS/Marked &'

# ---
# tool-specific vars
# ---

# ---
# java
# ---

if exists ant; then
  export ANT_HOME="$(which ant)"
  export ANT_OPTS="-Xmx512M -Xss5120k"
fi

# java
# TODO: check for libexec, and java
export JAVA_HOME="$(/usr/libexec/java_home)"
export JAVA_OPTS="-Xmx256m"

# NB: This is a tab
export XMLLINT_INDENT="	"

# TODO: requires installation of the closure compiler jar file
alias gjscomp="java -D=/usr/local/src/compiler-latest/ -jar compiler.jar"

# TODO: requires installation of Mozilla JavaScript-in-JVM project.
alias rhino="java org.mozilla.javascript.tools.shell.Main"

# TODO: these require installation of selenium
alias selenium_firefox="java -Dwebdriver.firefox.profile=default\
  -jar /usr/local/src/selenium/selenium-server-standalone-2.25.0.jar"
alias selenium_chrome="java -Dwebdriver.chrome.profile=default\
  -jar /usr/local/src/selenium/selenium-server-standalone-2.25.0.jar"

# TODO: this requires installation of xalan
alias xalan="java org.apache.xalan.xslt.Process"

# ---
# javascript
# ---

# Mac JavaScript interpreter from WebKit
alias jsc="/System/Library/Frameworks/JavaScriptCore.\
framework/Versions/A/Resources/jsc"

# TODO: phantomjs ?
# TODO: webdriver ?

# ---
# ruby
# ---

# rails
# TODO: check for ruby
export RAILS_ENV="development"

# ---
# servers
# ---

# Apache: MacOSX 10.8+ has Apache in /etc/apache2
if [[ -e /etc/apache2 ]]; then
  export APACHE_HOME="/etc/apache2"
  alias cdapache="cd ${APACHE_HOME}"

  # NOTE these depend on the creation on non-standard links for OSX.
  alias cdcgi="cd ${APACHE_HOME}/cgi-bin"
  alias cdhtml="cd ${APACHE_HOME}/htdocs"

  alias aprestart="sudo apachectl restart"
  alias apstart="sudo apachectl start"
  alias apstop="sudo apachectl stop"
fi

# Memcached
if exists memcached; then
  alias mem="memcached -d"
fi


# MySQL
if exists mysql.server; then
  alias mystart="mysql.server start"
  alias mystop="sudo mysql.server stop"
fi

# Postgres
if exists pg_ctl; then
  export PG_HOME="/usr/local/pgsql"
  export PG_DATA="${PG_HOME}/data"
  alias pgstart="sudo\
    -u postgres pg_ctl -D ${PG_DATA} -l ${PG_HOME}/log/logfile start"
  alias pgstop="sudo -u postgres pg_ctl stop -D ${PG_DATA}"
  alias pgtail="sudo -u postgres tail -f ${PG_HOME}/log/logfile"
fi

# Redis
if exists redis-server; then
  alias redis="redis-server /usr/local/etc/redis.conf"
fi

# ---
# ss
# ---

alias ssbod="pushd ${HOME}/dev/idearat/big7; ./ssbod.js; popd"
function sslbs () {
  # note use of $@ here to send 'unrolled' params.
  pushd ${HOME}/dev/idearat/big7 > /dev/null 2>&1; ./sslbs.js "$@"; popd > /dev/null 2>&1;
}

# ---
# mac stuff
# ---

alias show_hidden="defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder"
alias hide_hidden="defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder"

# ---
# other rc files
# ---

[[ -s ${HOME}/.localrc ]] && source ${HOME}/.localrc
[[ -s ${HOME}/.tibetrc ]] && source ${HOME}/.tibetrc

# airline-promptline shell prompt file, if used.
[[ -s ${HOME}/.shell_prompt.sh ]] && source ${HOME}/.shell_prompt.sh

