# duckietown-exercise-b5
# Steps
1. Install required python dependencies ```pip install opencv-python easygui```
2. Clone the github repository: ```https://github.com/jorgeluceda/duckietown-exercise-b5```

3.  Uncompress the included data_4_classes.tar.gz file, which is our dataset ```tar -xf data_4_classes.tar.gz```

4. Create blurry_folder and non_blurry_folder in the root of the project ```mkdir blurry_folder non_blurry_folder```

5. Apply laplacian filter to our data set using ```python detect_blurry_img.py data_4_classes/frames/ blurry_folder non_blurry_folder --threshold 300```, using threshold of 300 so that blurrier images are filtered.

6. Run custom script ```./move_labels.sh```, this filters the labels given and places the ones that our threshold allowed in our non_blurry_folder, this skips the need to use the given label_data.py script so that we do not need to label a large amount of images manually.

8. Create data_folder that is used in the next steps to train YOLO ```mkdir data_folder```
7. Execute ```python create_datasets.py non_blurry_folder data_folder 80``` to create the dataset and needed directories. 

8. Create the two other files required for training with the bash commands ```ls data_folder/trainset/*.jpg > data_folder/train.txt``` and ```ls data_folder/validset/*.jpg > data_folder/valid.txt```

9. Copy both the architecture_file and the pretrained weights from the cfg directory using the command ```cp cfg/yolov3-tiny.cfg architecture_file.cfg``` and ```cp cfg/yolov3-tiny-duckie-multi.weights pretrained_weights.weights```

10. Create the class_name file to be used in the next step for the names ```touch class_names.names``` and add the following lines to it:

    bot\
    duckie\
    stop_sign\
    road_sign

This contains all of our class names and is used in the names parameter in the data_file that we'll create next.

10. Create the data_file in the root with the following command: ```touch data_file``` and add the following lines to it:

    train  = data_folder/train.txt\
    valid  = data_folder/valid.txt\
    names = class_names.names\
    backup = duckie_backup

This data_file specifies the data to use while training. This follows the YOLO Convention.

11. In our previously copied architecture_file.cfg, we need to modify lines 127 and 171 to filters=27 as we have 4 classes. The formula is filters=(classes + 5)*3. We also change lines 135 and 177 to classes=4 as we are training 4 classes.

12. To start the training, we need to first download cuda: ```wget -O cuda_9.2.88_396.26_linux.run -c https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda_9.2.88_396.26_linux``` (this file is > 1GB so be ready to wait a bit).

13. Now to install cuda we need to change the file permissions using the command ```chmod a+x cuda_9.2.88_396.26_linux.run``` then we need to execute the command ```./cuda_9.2.88_396.26_linux.run --verbose --silent --toolkit --override``` to run the CUDA installer. Remember to run this as root otherwise it will not install. Might want to skip this step for a workshop or similar environment and have CUDA pre-installed as it takes a while to install. 

14. If running ubuntu the easiest way to do this is to run the command ```sudo apt install nvidia-cuda-toolkit```, saves doing the previous 2 steps.

14. Now run the command ```make``` to compile our program. We can now call the following command to start the training process: ```./darknet detector train data_file architecture_file.cfg pretrained_weights.weights```

15. Now that we have trained weights from our previous training process, we can run ```./darknet detector test data_file architecture_file.cfg weights_file non_blurry_folder/frames/100_000005.jpg -thresh 0.7```. The threshold parameter allows us to tell the predictor to only output bounding boxes when it is highly confident of its predictions.