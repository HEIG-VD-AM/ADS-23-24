#!/bin/bash

# Définition du dossier contenant les fichiers originaux
SOURCE_DIR="./lab04_raw_files"
# Définition du dossier de destination pour les fichiers renommés
RENAMED_DIR="$SOURCE_DIR/lab04_renamed_pictures"

# Crée le dossier de destination s'il n'existe pas
mkdir -p "$RENAMED_DIR"

for file in $SOURCE_DIR/*.{png,jpg}
do
    # Extraction des informations nécessaires du chemin du fichier
    suffix=$(identify -format '_%w_%h' "$file")
    file_name=$(basename "$file")
    name=${file_name%.*}
    extension=${file_name##*.}

    # Copie le fichier avec le nouveau nom dans le dossier de destination
    cp "$file" "$RENAMED_DIR/$name$suffix.$extension"
done



# Nous avons décidé de simplement créer un dossier qui va contenir les résulats. Ainsi les images se copient là-bas et le script n'y a pas accès, donc il ne fait pas le travail à double.