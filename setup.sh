#!/bin/sh
# Set UTF-8 encoding
export LANG=UTF-8
# Needed to work in SourceTree
export PATH=/usr/local/bin:$PATH

# Parent git repository absolute path
git_root=`git rev-parse --show-superproject-working-tree`
# Hook files path
hook_directory="$git_root/.git/hooks"

echo

if mkdir -p "$hook_directory"
then
  for hook in post-checkout post-merge pre-commit
  do
    if cp ""`dirname $0`"/$hook" "$hook_directory"
    then
      if chmod +x "$hook_directory/$hook"
      then 
        echo "$hook file copied and made executable."
      else 
        echo "Could not make $hook file executable."
      fi
    else 
      echo "Could not copy $hook file."
    fi
  done
fi

echo
echo "All hooks are copied and made executable."
echo "You can start using Git for Sketch files."
echo