#!/bin/bash
set -o errexit

# Set current working directory to script directory
script_dir="$(dirname "$(realpath "$0")")"
cd "$script_dir"

# Amend initial commit message
git commit --amend --message 'chore: clone template repository'
git push --force

# Install TypeScript dependencies for Node.js
# Allowed major versions: 10, 12, 14, 16, 17, 18, 19, 20, 21, 22
# See full list at https://github.com/tsconfig/bases?tab=readme-ov-file#table-of-tsconfigs
node_major_version=20
npm install --save-dev @tsconfig/node"$node_major_version"
npm install --save-dev @types/node@"$node_major_version"
npm install --save-dev typescript

# Install Express server
npm install express
npm install --save-dev @types/express

# Create tsconfig.json
cat > tsconfig.json <<EOF
{
  "extends": "@tsconfig/node${node_major_version}/tsconfig.json",
  "compilerOptions": {
    "outDir": "dist",
    "rootDir": "src"
  }
}
EOF

# Get repository name from current directory
repo_name="$(basename "$(realpath .)")"

# Update JetBrains IDE settings
repo_name="$repo_name" perl -i -pe 's/node-tsconfig/$ENV{repo_name}/g' .idea/modules.xml
mv .idea/node-tsconfig.iml ".idea/${repo_name}.iml"
