#!/bin/bash

echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1

# Do we have a working internet connection?
if [ $? -eq 0 ];
 then
    echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

    # Build the project.
    hugo

    # Go To Public folder.
    cd public
    # Add changes to git.
    git add .

    # Commit changes with default or provided commit title.
    msg="New site build: `date`"
    if [ $# -eq 1 ]
      then msg="$1"
    fi
    git commit -m "$msg"

    # Push source and build repos.
    git push origin master

    # Come Back up to the Project Root.
    cd ..
  else
    echo "No internet connection found. Aborting for now."
fi
