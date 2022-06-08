#!/bin/bash

source oauth.conf

##
## GET AN OAUTH TOKEN
## ie: curl -X POST https://cslab1.netsapiens.com/ns-api/oauth2/token -dgrant_type="password" -dusername="john" -dpassword="mypass" -dclient_id="clinetid" -dclient_secret="clientsecret"
##
TOKEN=$(curl -v -X POST $FQDN/ns-api/oauth2/token -dgrant_type="password" -dusername="$USERNAME" -dpassword="$PASSWORD" -dclient_id="$CLIENT_ID" -dclient_secret="$CLIENT_SECRET" | jq -r '.access_token' )

echo "access_token: $TOKEN"

##
## CREATE A DOMAIN
##
DOMAIN=t2training
TERRITORY=Toronto

echo "Creating domain $DOMAIN under Territory $TERRITORY"

curl -v -X POST $FQDN/ns-api/ -dobject=domain -daction=create -ddomain=$DOMAIN -dterritory=$TERRITORY -H "Authorization: Bearer $TOKEN"


##
## READ DOMAIN
##

echo "READING DOMAIN $DOMAIN"

curl -v -X POST $FQDN/ns-api/ -dobject=domain -daction=read -ddomain=$DOMAIN -dformat=json -H "Authorization: Bearer $TOKEN" | jq

echo "$0 exited..."

exit 0


### CLI COMMANDS
curl -v -X POST https://<FQDN>/ns-api/oauth2/token -dgrant_type="password" -dusername="yourusername" -dpassword="yourpass" -dclient_id="clientid" -dclient_secret="clientsecret"
curl -v -X POST https://<FQDN>/ns-api/ -dobject=domain -daction=create -ddomain=abc123 -dterritory=abcterritory -H "Authorization: Bearer thetoken"
curl -v -X POST https://<FQDN>/ns-api/ -dobject=domain -daction=read -ddomain=bac123 -dformat=json -H "Authorization: Bearer thetoken"
