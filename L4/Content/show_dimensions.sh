#!/bin/bash

for file in ./lab04_raw_files/*.{png,jpg}
do
        identify -format "$file width: %w, height: %h \n" "$file"
done