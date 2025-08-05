# Output repository name without owner
repositoryName=$(gh repo view --json name -q ".name")
gitUserName=$(git config --global user.name)
gitUserEmail=$(git config --global user.email)

echo "Repository Name (as determined from GH): $repositoryName"
echo $repositoryName > .devcontainer/repositoryName.tmp

echo "Git User Name: $gitUserName"
echo $gitUserName > .devcontainer/gitUserName.tmp

echo "Git User Email: $gitUserEmail"
echo $gitUserEmail > .devcontainer/gitUserEmail.tmp
