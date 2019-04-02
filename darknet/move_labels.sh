#!/bin/bash

#for filename in non_blurry_folder/frames/*.jpg
#do
#        if test -f non_blurry_folder/frames/$filename
#        	echo $filename
#            then cp data_4_classes/labels/$filename non_blurry_folder/labels/$filename
#        fi
#done

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

