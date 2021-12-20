## Stereo-Vision


### Task description
You need to use 8-point algorithm in order to find the fundamental matrix. For the initial key points detection (minimum 8 corresponding points) you can either do it manually or use any key points detection technique. Next step is to estimate the disparity map for the selected image pair. You may assume the baseline of the stereo camera as the 10cm and focal length of both the left and right side cameras as 2.8mm. The provided dataset contains left and right image.


it is needed to place a 3d object(e.g., cube, cylinder, etc) in an appropriate way with respect to [depth camera](https://www.intelrealsense.com/depth-camera-d435i/). Associate depth map with RGB information in order to isolate the object, which is to be extracted from the ground plane and other foreground objects if there are.
You may have to use RANSAC or some other algorithms to extract the object and find the center point of the object in the 3D space relative to the depth camera.
