
# ...get input args...
REPO=$1
PATH_REL_LIB=$2

# ...parameters definition...
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

