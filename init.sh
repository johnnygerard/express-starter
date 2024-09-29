#!/bin/bash
set -o errexit

# Amend initial commit message
git commit --amend --message 'chore: clone template repository'
git push --force

# Get repository name from current directory
repo_name="$(basename "$(realpath .)")"

# Update WebStorm settings
repo_name="$repo_name" perl -i -pe 's/mean-app-starter/$ENV{repo_name}/g' .idea/modules.xml
mv .idea/mean-app-starter.iml ".idea/${repo_name}.iml"

# Commit changes
git add .
git commit --message 'chore: initialize project'
git push

echo 'Project initialized successfully!'
