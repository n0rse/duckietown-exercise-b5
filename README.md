# duckietown-exercise-b5

# Findings

- Frames provided assumed as input folder
- Default threshold provided (200) does not detect any blurry images, we chose a threshold of 300 for the original data set provided

- No names for the output folders are provided in the exercise
- Created and ran our own script called move_labels.sh in darknet directory to copy the correct labels for the non_blurred images

- Install packages first: install pip using package manager, install opencv-python (pip3 install opencv-python)

- Need to create data where the testset, trainset, and validset folders are stored (training sets)

- Execute: python3 create_datasets.py non_blurry_folder data_folder 80
