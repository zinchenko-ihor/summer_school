#!/bin/bash
user=devops
mydir=~/test

function user_exist {
if id "$user" >/dev/null 2>&1; then
return 0
else
echo "ERROR: User '$user' does not exist in the system. Please, enter correct user name."
return 1
fi
}

function dir_exist {
if [ -d "$mydir" ]; then
return 0
else
echo "ERROR: Directory '$mydir' not found. Please, enter correct directory path"
return 1
fi
}

function chown_er {
if (user_exist $user) && (dir_exist $mydir); then
sudo chown -R $user $mydir
echo " Directory owner was successfully changed"
fi
}
chown_er $user $mydir
