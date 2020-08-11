## What does this repo do? 

This will build a node.js app on docker that returns a message and a unix timestamp.  It will test it, and then push it to dockerhub.

## How do I use this?

Add your updates to the app and tests in the tests folder, then go into the `build-script` folder and run `./JenkinsShouldDoThis.sh <your dockerhub username>`

Your docker image will then be in your repository, ready to be deployed!