This script will look for open/unpublished sessions and send an email out with the User and Session ID.

## How to use ##
 - cp script over to mgmt station (this script is intended to run directly on the mgmt station)
 - By default the script works on SMS. If you need it for MDS modify the 'MDS=' from n to y. This will search across all domains.
 - Modify the email info;
  - $FWDIR/bin/sendmail -t MAIL_SERVER -s "SUBJECT"  -f MAILFROM@DOMAIN.COM MAIL_TO@DOMAIN.COM
 - execute ./check_sessions.sh
