#!/usr/bin/env bash

#
# Install:
#
# 1. Save this script as "git-sync" somewhere in your $PATH with permissions "chmod u+x git-sync".
#
# 2. In a git repo, save the "destination" for rsync:
#
#    $ git config git-sync.destination="tumblr:/var/www/apps/"
#
#    These settings are stored for you alone in .git/config and they're
#    not saved in any remote.
#
# 3. If you want, add "post-merge" and "post-checkout" hooks:
#
#    $ (cd $(git rev-parse --git-dir)/hooks && echo -e '#!/usr/bin/env bash \ngit-sync' | tee post-{merge,checkout} >/dev/null && chmod u+x post-{merge,checkout} && echo "Ok.")
#
#
# Usage:
#
# From any directory in your git repo, run "git-sync" and it'll confirm if you want to rsync or not.
# You can also run "git-sync -y", and it won't ask you to confirm. This is useful if you want to run
# this in sublime as a "build" step.
#

SOURCE="$(git rev-parse --show-toplevel)"
if [[ $? != 0 ]] || [[ -z $SOURCE ]]; then
  exit
fi

DESTINATION="$(git config git-sync.destination)"
if [[ $? != 0 ]] || [[ -z $DESTINATION ]]; then
  echo "Failed 'git config git-sync.destination'"
  exit
fi

OPTS=(
  # archive mode (equals -rlptgoD), implies:
  # -r recurse into directories
  # -l copy symlinks as symlinks
  # -p preserve permissions
  # -t preserve modification times
  # -g preserve group
  # -o preserve owner (super-user only)
  # -D same as --devices --specials
  # --devices preserve device files (super-user only)
  # --specials preserve special files
  "--archive"

  # output numbers in a human-readable format
  "--human-readable"

  # transform symlink into referent file/dir
  # "--copy-links"

  # receiver deletes after transfer, not before
  "--delete-after"

  # also delete excluded files from dest dirs
  "--delete-excluded"

  "--compress-level=6"

  "--exclude '.DS_Store'"
  "--exclude '.git'"

  "--stats"

  # display files being transfered
  #"--verbose"

  # perform a trial run with no changes made
  #"--dry-run"
)

COMMAND="rsync ${OPTS[@]} '$SOURCE' '$DESTINATION'"

if [[ $1 == '-y' ]]; then
  eval $COMMAND
else
  REPO=$(basename $(git rev-parse --show-toplevel))
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  MESSAGE="\033[0;33mrsync: (${REPO}/${BRANCH}) \033[0m"
  COLORIZE="sed -E 's/(^[[:alpha:][:space:]]+:)/\\\e[38;05;244m\1\\\e[0m/g'"

  # Allow reading from STDIN during git hook
  exec < /dev/tty
  while true; do
    echo -ne $MESSAGE
    read -n 1 yn
    case $yn in
      [Nn]* ) echo; exit;;
      * ) printf "$(eval $COMMAND | eval $COLORIZE)\n\n"; break;;
      esac
  done

fi
