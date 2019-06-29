# farsight-functions

A framework for serverless ruby on top of cloud run and also a collection of services for the farsight service.

## services

A service (or sometimes called function) is a singular semi-isolated piece of code that does one job. It has access to the request, the response, the router, a client list, and a database. Using these pieces the service will do some operation.

For example, lets say we wanted a service that cleaned up old data. It would be called on a schedule (every 24h for example), it would pull all old records from the database, transform them to clean versions, and then store them in the database. Finally it would return status 200 (as a show that it completed successfully).

## how to setup

  0. Go to github.com/difference-engineers/farsight-functions
  0. Click the "Create new file" button
  0. Call it "DRAFT"
  0. Enter the name of your new service into the contents of the file (eg "initial-mtgjson-import")
  0. Name the branch after the service name (eg "initial-mtgjson-import")
  0. Click "Commit new file"
  0. Rename the pull request title to be named after the service name (eg "The mtgjson-import service")
  0. Detail a little bit of what you want this service to do
  0. Click the "Create pull request" button
  0. Click the "Gitpod" button

You'll know the process has worked because once gitpod has fully started your environment you should have a new commit on the pull request history (see: `git log`). That commit should remove the DRAFT file, add a line to the FUNCTIONS file (with your service name), have created a directory based on the name of your service, and much more.
