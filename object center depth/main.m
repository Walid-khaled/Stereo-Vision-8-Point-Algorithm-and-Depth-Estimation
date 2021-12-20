clear all;
clc;
%% 1- read depth map .raw file
fid = fopen('Depth.raw', 'r');
depth_data = fread(fid, [240,320]);
fclose(fid);

%% 2- read rgp image
rgb_img = imread('RGB.png');
figure(1);
imshow(rgb_img);
title('RGB Image');
% resize our image to 320 x 240 to match our depth map
rgb_img_resized = imresize(rgb_img,[240,320]);
figure(2)
imshow(rgb_img_resized);
title('Resized RGB Image');

%% 3- image thresholding
I = rgb_img_resized;
red = I(:,:,1); green = I(:,:,2); blue = I(:,:,3);
% d = impixel(I);
thres = xlsread('threshold.xlsx');
out1 = red > min(thres(:,1)) & red < max(thres(:,1))...
    & green > min(thres(:,2)) & green < max(thres(:,2)) & ...
    blue > min(thres(:,3)) & blue < max(thres(:,3));

figure(3);
subplot(2,2,1);
imshow(out1);
title('output 1');

out2 = imfill(out1,'holes');
subplot(2,2,2);
imshow(out2);
title('output 2');

out3 = bwmorph(out2,'dilate',3);
subplot(2,2,3);
imshow(out3);
title('output 3');

out4 = imfill(out3,'holes');
subplot(2,2,4);
imshow(out4);
title('output 4');
% imtool(out4);

stats = regionprops(out4,'Area','Centroid','BoundingBox','Extrema');
A = stats.Area;
C = stats.Centroid;
BB = stats.BoundingBox;
Ex = stats.Extrema;

hold on;
rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2);
hold off;

figure(4);
subplot(2,1,1)
imshow(I);
title('Object detection using Bounding Box');
hold on;
rectangle('Position', [BB(1),BB(2),BB(3),BB(4)],'EdgeColor','r','LineWidth',2);
hold off;

subplot(2,1,2);
imshow(I);
title('Object detection using Extrema points');
hold on;
for i=[2 4 6]
    line([Ex(i,1),Ex(i+2,1)],[Ex(i,2),Ex(i+2,2)],'color','b','LineWidth',3);
end
line([Ex(8,1),Ex(2,1)],[Ex(8,2),Ex(2,2)],'color','b','LineWidth',3);
hold off;

%% 4- locate object center based on Extrema points
x_center = (Ex(4,1)+Ex(6,1))/2;
y_center = (Ex(2,2)+Ex(4,2))/2;

figure(5);
imshow(I);
title('Object detection using Extrema points');
hold on;
for i=[2 4 6]
    line([Ex(i,1),Ex(i+2,1)],[Ex(i,2),Ex(i+2,2)],'color','b','LineWidth',3);
end
line([Ex(8,1),Ex(2,1)],[Ex(8,2),Ex(2,2)],'color','b','LineWidth',3);
plot(x_center,y_center, 'b+', 'MarkerSize', 5, 'LineWidth', 3);
hold off;

%% 5- depth of the estimated center 
y_center = floor(y_center);
x_center = floor(x_center);
center_depth = depth_data(y_center,x_center);

% mapping from depth map range [0,255] to camera range [0.3,3] meter
real_depth = ((center_depth*2.7)/255)+0.3;
ground_truth = 0.3;
Error = ((real_depth-ground_truth)/ground_truth)*100;

fprintf("Estimated center x: %.3f, y: %.3f\n",x_center,y_center);
fprintf("Depth estimated from depth map: %.3f m\n",real_depth);
fprintf("Ground truth measured by ruler: %.3f m\n",ground_truth);
fprintf("Error: %.3f%%\n",Error);







