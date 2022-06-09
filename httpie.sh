#!/bin/bash

## Update the credentials parameters passed to this.
## Request for token
http POST https://cslab1.netsapiens.com/ns-api/oauth2/token grant_type="password" username="training" password="" client_id="training_id" client_secret=""


## Read the domain with bearer
http POST https://cslab1.netsapiens.com/ns-api/ object==domain action==read format==json domain==t2training 'Authorization:Bearer b0f1424778712d739b7e35a3703c0d7d'

## add -vv to enable verbose mode

## Using session
## Save the session first
http --session=cslab1 POST https://cslab1.netsapiens.com/ns-api/ object==domain action==read format==json domain==t2training 'Authorization:Bearer b0f1424778712d739b7e35a3703c0d7d'
## Now reuse the session
http --session=cslab1 POST https://cslab1.netsapiens.com/ns-api/ object==domain action==read format==json domain==t2training

## Output the response
http --session=cslab1 POST https://cslab1.netsapiens.com/ns-api/ object==domain action==read format==json domain==t2training >> t2training-domain.json

## Create a user in this domain
## Why go through this trouble? well you can create same users on two domains pretty fast with this
cat t2training-domain.json | jq '.[] | { "domain" : .domain , "user" : "1000", "first_name" : "Cool", "last_name" : "Dude", "email" : "cool@t2group.com" }' | http --session=cslab1 POST https://cslab1.netsapiens.com/ns-api/ object==subscriber action==create




// Recording

https://api.netsapiens.com/ns-api/?object=cdr2&action=read
http -vv --session=cslab1 POST https://cslab1.netsapiens.com/ns-api/ object==cdr2 action==read format==json domain==rahz start_date=="2022-06-01 00:00:00" end_date=="2022-06-08 00:00:00"

// get caller_id from cdr table via api,
https://api.netsapiens.com/ns-api/?object=cdr&action=read&term_callid=""

// read recordings
https://api.netsapiens.com/ns-api/?object=recording&action=read
'format' => 'json',
'object' =>  $this->object,
'action' => 'read',
'domain' => $domain,
'start_date' => $start_date,
'end_date' => $end_date,
'limit' => '9999999999',
'raw' => 'yes'

http --session=cslab1 POST https://cslab1.netsapiens.com/ns-api/ object==recording action==read format==json domain==t2training
