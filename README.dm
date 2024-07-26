# MongoDB
To start mongodb on a clean instance, follow these steps:

 add to docker-compose:
  command: [ '--replSet', 'overleaf' ]

  log into mongo on first start by ```docker compose exec mongo mongosh```
 
 run 'rs.initiate()'

# Migrazione per mongo 4.0 -> 5.0
Dopo averlo avviato:

db.adminCommand( { setFeatureCompatibilityVersion: "5.0" } )
rs.initiate({ _id: "overleaf", members: [ { _id: 0, host: "mongo:27017" } ] })

rs.initiate()￼


# Migrazione per sharelatex:
 
 Fare un primo boot con l'immagine sharelatex/sharelatex:3.5.13
 Questa richiede anche le vecchie variabili d'ambiente SHARELATEX_***

 Istruzioni poi a https://github.com/overleaf/overleaf/wiki/Full-Project-History-Migration

 Comandi da eseguire una volta che è tutto su:
  cd /overleaf/services/web; VERBOSE_LOGGING=true node scripts/history/migrate_history.js --force-clean --fix-invalid-characters --convert-large-docs-to-file
  cd /overleaf/services/web; VERBOSE_LOGGING=true node scripts/history/migrate_history.js --force-clean --fix-invalid-characters --convert-large-docs-to-file


# Pushare l'immagine

 make -C server-ce build-base
 make -C server-ce build-community
 sudo docker tag sharelatex/sharelatex:main robol/sharelatex:main
 sudo docker push robol/sharelatex:main
