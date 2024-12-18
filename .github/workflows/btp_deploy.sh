#!/bin/bash
set -e



echo '############## Get cf Client ##############'
wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
sudo apt-get update
sudo apt-get install cf8-cli
sudo apt-get install moreutils


echo '############## Replace Variable on MTA.yaml #########'
envsubst \${docker_user}, \${docker_token} < mta.yaml | sponge mta.yaml

cat mta.yaml

echo '############## Check Installation ##############'
cf -v

echo '############## Install Plugins ##############'
cf add-plugin-repo CF-Community https://plugins.cloudfoundry.org
cf install-plugin multiapps -f
cf install-plugin html5-plugin -f

echo '########## Node Version ##########'
node -v
 
echo '############## Print directory ##############'
ls

echo '########## NPM Version ##########'
npm -v
npm i @sap/cds-dk@latest
echo '############## Build ##############'
npx mbt build --mtar app.mtar


echo '############## Authorizations ##############'
cf api $cf_api_url
cf auth $cf_user "$cf_password"

echo '############## Deploy ##############'
cf target -o $cf_org -s $cf_space
cf deploy mta_archives/app.mtar -f
