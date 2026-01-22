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

# Migrazione per sharelatex > 3.5.13
 
 Fare un primo boot con l'immagine sharelatex/sharelatex:3.5.13
 Questa richiede anche le vecchie variabili d'ambiente SHARELATEX_***

 Istruzioni poi a https://github.com/overleaf/overleaf/wiki/Full-Project-History-Migration

 Comandi da eseguire una volta che è tutto su:
  cd /overleaf/services/web; VERBOSE_LOGGING=true node scripts/history/migrate_history.js --force-clean --fix-invalid-characters --convert-large-docs-to-file
  cd /overleaf/services/web; VERBOSE_LOGGING=true node scripts/history/migrate_history.js --force-clean --fix-invalid-characters --convert-large-docs-to-file

# Migrazione per Mongo 5.0 -> 8.0

A gennaio 2026 abbiamo aggiornato MongoDB; per aggiornare, basta caricare il database con le versioni di 
Mongo in successione: 5.0 -> 6.0 -> 7.0 -> 8.0; tuttavia, dopo ogni aggiornamento è necessario collegarsi, 
e aggiornare la "FeatureCompatibilityVersion".

Dopo aver aggiornato a Mongo 6.0:

 $ mongosh
 > db.adminCommand({ setFeatureCompatibilityVersion: "6.0" })

Dopo aver aggiornato a Mongo 7.0:

 $ mongosh
 > db.adminCommand({ setFeatureCompatibilityVersion: "7.0", confirm: true })

Dopo aver aggiornato a Mongo 8.0

 $ mongosh
 > db.adminCommand({ setFeatureCompatibilityVersion: "8.0", confirm: true })

# Migrazione per Sharelatex > 5.5.7

 Info: [https://docs.overleaf.com/on-premises/release-notes/release-notes-5.x.x/binary-files-migration](https://docs.overleaf.com/on-premises/release-notes/release-notes-5.x.x/binary-files-migration)

 Per aggiornare, è necessario caricare temporaneamente l'immagine di sharelatex 5.5.7, e seguire le istruzioni al link sopra.
 La migrazione richiede un certo numero di riavvii del container con aggiornamento della variabile d'ambiente OVERLEAF_FILESTORE_MIGRATION_LEVEL.

 Una volta completata la migrazione, si può partire con l'immagine nuova.

# Pushare l'immagine

 make -C server-ce build-base
 make -C server-ce build-community
 sudo docker tag sharelatex/sharelatex:main robol/sharelatex:main
 sudo docker push robol/sharelatex:main
