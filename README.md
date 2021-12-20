## Stereo-Vision
In this repository, 8-point algorithm is used to find the fundamental matrix based on SVD. Disparity map is generated from left and right images. In addition, RealSense depth camera 435i is used to estimate object center depth. Image thresholding and object detection are implemented. It is apart of Assignment3 in Sensing, Perception and Actuation course for ROCV master's program at Innopolis University.

### Task description
For first task, you need to use 8-point algorithm in order to find the fundamental matrix. For the initial key points detection (minimum 8 corresponding points) you can either do it manually or use any key points detection technique. Next step is to estimate the disparity map for the selected image pair. You may assume the baseline of the stereo camera as the 10cm and focal length of both the left and right side cameras as 2.8mm. The provided dataset contains left and right image.

For the second task, it is needed to place a 3d object(e.g., cube, cylinder, etc) in an appropriate way with respect to [RealSense depth camera 435i](https://www.intelrealsense.com/depth-camera-d435i/). Associate depth map with RGB information in order to isolate the object, which is to be extracted from the ground plane and other foreground objects if there are. You may have to use RANSAC or some other algorithms to extract the object and find the center point of the object in the 3D space relative to the depth camera.

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

<p align="center"><img src="https://user-images.githubusercontent.com/90580636/146698668-76eb4b4e-37b8-44b1-b381-a4f9eb44bd9a.png" /></p>
<p align="center">Image thresholding</p>

<p align="center"><img src="https://user-images.githubusercontent.com/90580636/146698708-8d9c5dfb-7fbf-4243-8095-4d4a29a22db3.png" /></p>
<p align="center">Object detection</p>

<p align="center"><img src="https://user-images.githubusercontent.com/90580636/146698767-9539f4b8-d97a-48fd-89ff-52a895de8deb.png" /></p>
<p align="center">Center estimation</p>
