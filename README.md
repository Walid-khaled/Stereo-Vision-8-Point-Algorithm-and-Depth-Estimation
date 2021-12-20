## Stereo-Vision
In this repository, camera calibration is implemented using  MATLAB Camera Calibrator APP. It is apart of Assignment3 in Sensing, Perception and Actuation course for ROCV master's program at Innopolis University.

### Task description
You need to use 8-point algorithm in order to find the fundamental matrix. For the initial key points detection (minimum 8 corresponding points) you can either do it manually or use any key points detection technique. Next step is to estimate the disparity map for the selected image pair. You may assume the baseline of the stereo camera as the 10cm and focal length of both the left and right side cameras as 2.8mm. The provided dataset contains left and right image.


it is needed to place a 3d object(e.g., cube, cylinder, etc) in an appropriate way with respect to [depth camera 435i](https://www.intelrealsense.com/depth-camera-d435i/). Associate depth map with RGB information in order to isolate the object, which is to be extracted from the ground plane and other foreground objects if there are.
You may have to use RANSAC or some other algorithms to extract the object and find the center point of the object in the 3D space relative to the depth camera.

---
### Table of Content 
```
├── 8-point algorithm       <- directory for task1
|    ├── main.m             <- contains main script
|    ├── left.png
|    ├── right.png                 
|
├── object center depth     <- directory for task2
|    ├── main.m             <- contains main script
|    ├── RGB.png 
|    ├── Depth.png          
|    ├── Depth.raw          <- contains depth map values 
|    ├── Depth_metadata.csv <- contains depth camera parameters
|    ├── threshold.csv      <- contains RGB values for object color
|
├── Report.pdf                        
└── Readme.md
```
<p align="center"><img src="https://user-images.githubusercontent.com/90580636/146696031-4877726b-e362-4e05-a0bf-ffbd7ce4dad8.png" /></p>
<p align="center">Camera Calibrator APP</p>
