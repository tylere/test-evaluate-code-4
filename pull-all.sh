#!/usr/bin/env bash

echo "repo directory: $1";

# for f in $1/*/; do
#     echo "$f: git pull"
#     cd $f
#     git pull > /dev/null
#     cd - > /dev/null
# done

wait < <(jobs -p)

# Print the last commits.
for f in $1/*/; do
  echo "$f"
  cd $f
  git show -s --oneline
  cd - > /dev/null
done

# Print the status.
for f in $1/*/; do
  cd $f
  r=$(git status -s)
  echo $r
  if [[ $r = *[!^[:space:]]* ]]; then
    cat <<EOF

=====
$f
$r
EOF
  fi
  cd - > /dev/null
done