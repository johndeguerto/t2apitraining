#!/bin/bash

## Request for token
http POST https://cslab1.netsapiens.com/ns-api/oauth2/token grant_type="password" username="training@deguerto-test" password="CsAWrLwpnpXM4SwGRxmFV49v9mQzqq" client_id="training_id" client_secret="d96e73ecdbb5bb28f1cf699c8bfeef05"


## Read the domain with bearer
http POST https://cslab1.netsapiens.com/ns-api/ object==domain action==read format==json domain==t2training 'Authorization:Bearer 2fde6898df652ac8ef65192231d01877'

## add -vv to enable verbose mode

## Using session
## Save the session first
http --session=cslab1 POST https://cslab1.netsapiens.com/ns-api/ object==domain action==read format==json domain==t2training 'Authorization:Bearer 2fde6898df652ac8ef65192231d01877'
## Now reuse the session
http --session=cslab1 POST https://cslab1.netsapiens.com/ns-api/ object==domain action==read format==json domain==t2training

## Output the response
http --session=cslab1 POST https://cslab1.netsapiens.com/ns-api/ object==domain action==read format==json domain==t2training >> t2training-domain.json

## Create a user in this domain
## Why go through this trouble? well you can create same users on two domains pretty fast with this
cat t2training-domain.json | jq '.[] | { "domain" : .domain , "user" : "1000", "first_name" : "Cool", "last_name" : "Dude", "email" : "cool@t2group.com" }' | http --session=cslab1 POST https://cslab1.netsapiens.com/ns-api/ object==subscriber action==create
