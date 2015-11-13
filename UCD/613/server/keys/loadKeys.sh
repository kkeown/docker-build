#!/bin/bash

shopt -s nullglob

cd /keystores
for k in *.keystore
do
  echo "Adding server keystore: $k"
  cp $k /opt/ibm-ucd/server/conf/$k
  keytool -importkeystore -srckeystore /opt/ibm-ucd/server/conf/$k -srcstorepass changeit -srcstoretype jceks -alias desedekeyyk2s -destkeystore /opt/ibm-ucd/server/conf/encryption.keystore -deststorepass changeit -storetype jceks -noprompt
done

keytool -list -keystore /opt/ibm-ucd/server/conf/encryption.keystore -storepass changeit -storetype jceks

