
## Default is for SMS. If you are using this on MDS change the line below to 'MDS=y'##
MDS=n

if [ "$MDS" = "y" ]; then
printf "\nGathering IP info of CMAs\n"
mgmt_cli -r true show domains --format json | jq -r '.objects[] | .name' >cma.txt

printf "\nChecking for Open Sessions\n"
for I in $(cat cma.txt)
do
 mgmt_cli -r true -d "$I" show sessions details-level full --format json |jq --raw-output '.objects[]| select(.state=="open") | "User:"+."user-name" + " has an open session on domain: " + .domain.name + " the UID is: " + .uid' >> open_sessions.txt
done

$MDS_TEMPLATE/bin/sendmail -t MAIL_SERVER -s "SUBJECT"  -f MAIL_FROM MAIL_TO <open_sessions.txt

elif [ "$MDS" = "n" ]; then
 mgmt_cli -r true -d "$I" show sessions details-level full --format json |jq --raw-output '.objects[]| select(.state=="open") | "User:"+."user-name" + " has an open session on domain: " + .domain.name + " the UID is: " + .uid' >> open_sessions.txt

$FWDIR/bin/sendmail -t MAIL_SERVER -s "SUBJECT"  -f MAIL_FROM MAIL_TO <open_sessions.txt
fi

rm open_sessions.txt
