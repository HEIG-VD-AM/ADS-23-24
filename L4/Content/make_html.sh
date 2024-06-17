#!/bin/bash

# Définir les chemins
RAW_FILES_DIR="./raw_files/lab04_raw_files"
THUMBNAILS_DIR="./raw_files/lab04_thumbnails"
DEST_DIR="."
BEGIN_TEMPLATE="${DEST_DIR}/template_begin.html"
END_TEMPLATE="${DEST_DIR}/template_end.html"
PAGE="${DEST_DIR}/page.html"

# Créer ou vider le fichier page.html
> "${PAGE}"

# Ajouter le début du template
cat "${BEGIN_TEMPLATE}" > "${PAGE}"

# Section des images
cat <<EOF >> "${PAGE}"
<article class="container article">
    <div class="row">
        <div class="col-md-10 col-md-pull-3 col-md-offset-4 article__content">
            <div><div><h2>Découvrez-nous en images</h2></div></div>
            <div class="row">
EOF

# Générer les entrées pour les images
for img in ${RAW_FILES_DIR}/*.{png,jpg}; do
    filename=$(basename "$img")
    thumb="${THUMBNAILS_DIR}/${filename%.*}_thumb.${filename##*.}"
    if [[ -f "$thumb" ]]; then
        echo "<div class=\"col-md-6 col-xs-12\"><a href=\"$img\"><img class=\"vignette\" src=\"$thumb\" /></a></div>" >> "${PAGE}"
    fi
done

# Fin de la section des images et début de la section des brochures
cat <<EOF >> "${PAGE}"
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 40px;">
        <div class="col-md-10 col-md-pull-3 col-md-offset-4 article__content">
            <div><div><h2>Téléchargez nos brochures</h2></div></div>
            <div class="row">
EOF

# Générer les entrées pour les brochures
for pdf in ${RAW_FILES_DIR}/*.pdf; do
    filename=$(basename "$pdf")
    thumb="${THUMBNAILS_DIR}/${filename%.*}_thumb.jpg"
    if [[ -f "$thumb" ]]; then
        echo "<div class=\"col-md-6 col-xs-12\"><a href=\"$pdf\"><img class=\"vignette\" src=\"$thumb\" /></a></div>" >> "${PAGE}"
    fi
done

# Fin de la section dynamique
cat <<EOF >> "${PAGE}"
            </div>
        </div>
    </div>
</article>
EOF

# Ajouter la fin du template
cat "${END_TEMPLATE}" >> "${PAGE}"