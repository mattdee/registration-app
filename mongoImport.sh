#!/bin/bash

# Import mongodb collection into ADBJSON

# To get all collections in a database run this command from mongosh
# db.getCollectionNames()


# Example
# https://www.mongodb.com/docs/database-tools/mongoimport/#mongodb-binary-bin.mongoimport
# mongoimport --username joe --password secret1 mongodb://mongodb0.example.com:27017 

# Update path as needed
/opt/homebrew/bin/mongoimport --type=json --file=registrations.json mongodb://x:xxx@xxxx.adb.ca-toronto-1.oraclecloudapps.com:27017/admin?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true

