rhq-zanata-tools
================

rhq-zanata-push.sh - script takes no arguments, clones the RHQ repo from github, checkout the latest JON 3.3.x release branch and pushes the source .properties files to the jboss zanata server.
NOTE: 
  - The script does not quite run fully unattended, you will need to enter Y to a prompt to initiate the push to the zanata server.
  - The script doesn't do a whole lot of error checking, so please scan the last few lines on the console for error messages, a sucessful run will look like this:

[INFO] Found source documents:
[INFO]            MessageConstants
[INFO]            Messages
This will overwrite existing source documents on the server, and delete obsolete documents.

Are you sure (y/n)? y
[INFO] pushing source doc [name=MessageConstants size=21] to server
Done in 4 secs    
[INFO] Running Copy Trans for MessageConstants
Done in 3 secs
[INFO] pushing source doc [name=Messages size=2499] to server
Done in 14 secs   
[INFO] Running Copy Trans for Messages
Done in 12 mins:41 secs
Cleaning up...
