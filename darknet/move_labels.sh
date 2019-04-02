#!/bin/bash

mkdir non_blurry_folder/frames/
mkdir non_blurry_folder/labels/

cd non_blurry_folder

for orig_image in *.jpg
do
    mv $orig_image frames/$orig_image
done

cd ..

cd non_blurry_folder/frames/
for filename in *.jpg
do
        if test -f $filename
        	echo $filename
        	name=$(basename $filename .jpg)
        	name+=".txt"
            then cp ../../data_4_classes/labels/$name ../labels/$name
        fi
done

