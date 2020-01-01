
# ...get input args...
# TODO: improve parsing... function to parsing arguments
REPO=$1
PATH_REL_LIB=$2
PUSH_REPO=$3
COMMIT_MESSAGE=$4

# ...(global) parameters definition...
PATH_ROOT_PROJECTS="/home/sergio/sc-sync/projects/"
BRANCH="master"
BRANCH_LIB="master"


PATH_ROOT_REPO=$PATH_ROOT_PROJECTS$REPO




# ...settings...
pwd
cd $PATH_ROOT_REPO
pwd

# ...pull of one repo...
echo ""
echo "----- STATUS-PULL MAIN PROJECT -----"
git status
git pull origin $BRANCH

# ...pull lib submodule...
cd $PATH_REL_LIB
pwd

echo ""
echo "----- STATUS-PULL LIB SUBMODULE -----"
git status
git pull origin $BRANCH_LIB
pwd

# ...return to repo path...
cd $PATH_ROOT_REPO
pwd

if [ "$3" == "push_repo" ] 
then
	echo "----- PUSH REPO -----"
	git status
	git add .
	git status
	if [ "$4" != "" ]
	then
		git commit -m $4
		git push origin $BRANCH 
	else
		git commit -m "pushing from sh utility"
		git push origin $BRANCH
	fi
fi

