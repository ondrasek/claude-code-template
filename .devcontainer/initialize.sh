# Output repository name without owner
repositoryName=$(gh repo view --json name -q ".name")
repositoryNameWithOwner=$(gh repo view --json nameWithOwner -q ".nameWithOwner")
gitUserName=$(git config --global user.name)
gitUserEmail=$(git config --global user.email)

postCreateEnvFile=.devcontainer/postCreate.env.tmp

[ -f $postCreateEnvFile ] && rm $postCreateEnvFile 
touch $postCreateEnvFile

echo repositoryName=$repositoryName >> $postCreateEnvFile
echo repositoryNameWithOwner=$repositoryNameWithOwner >> $postCreateEnvFile
echo gitUserName=$gitUserName >> $postCreateEnvFile
echo gitUserEmail=$gitUserEmail >> $postCreateEnvFile

echo postCreateCommand env:
cat $postCreateEnvFile
echo

