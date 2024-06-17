#!/bin/bash

# Définition du dossier contenant les fichiers originaux
SOURCE_DIR="./lab04_raw_files"
# Définition du dossier de destination pour les miniatures
THUMBNAILS_DIR="$SOURCE_DIR/lab04_thumbnails"

# Crée le dossier de destination s'il n'existe pas
mkdir -p "$THUMBNAILS_DIR"

for file in $SOURCE_DIR/*.{png,jpg,pdf}
do
    # Extraction des informations nécessaires du chemin du fichier
    file_name=$(basename "$file")
    name=${file_name%.*}
    extension=${file_name##*.}
    path=$(dirname "$file")

    # Commande pour créer la miniature
    if [ "$extension" = "pdf" ]
    then
        thumbnail_file="$THUMBNAILS_DIR/${name}_thumb.jpg"
        convert -geometry 300 "$file"[0] "$thumbnail_file"
    else
        thumbnail_file="$THUMBNAILS_DIR/${name}_thumb.$extension"
        convert -geometry 300 "$file" "$thumbnail_file"
    fi
done

# Comme pour le script précédent, nous avons juste créer un dossier qui va contenir toutes les miniatures produites