# djeroku
Shell script to create a Django app and host it to Heroku in a Debian distro.

An installation of [Anaconda](https://www.anaconda.com/distribution/) is strongly recommended before proceeding.

Run the app by executing  
`./djeroku.sh projectname`  

The `projectname` should be all lower case and this will be used to create a vitual environment, a django app and then host it to `projectname.heroku.com`.

Make sure to `chmod +x` the file.

An [Heroku account](https://signup.heroku.com) is required. But most of the pre-requisites are taken care of by the script.

