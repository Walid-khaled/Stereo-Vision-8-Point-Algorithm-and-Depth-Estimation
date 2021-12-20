clear all
clc
%% 1- read images and convert them into gray
I1 = rgb2gray(imread('left.png'));
I2 = rgb2gray(imread('right.png'));
% I1 = mat2gray(I1);
% I2 = mat2gray(I2);

%% 2- detect points using Harris features
points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);
[f1, vpts1] = extractFeatures(I1, points1);
[f2, vpts2] = extractFeatures(I2, points2);
indexPairs = matchFeatures(f1, f2) ;
matchedPoints1 = vpts1(indexPairs(1:8, 1));
matchedPoints2 = vpts2(indexPairs(1:8, 2));

%% 3- show matched points
figure; 
ax = axes;
warning('off');
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage','Parent',ax);
title(ax, 'Candidate point matches');
legend(ax, 'Matched points 1','Matched points 2');

%% 4- compute A matrix with DLT
xl = [matchedPoints1.Location, ones(8,1)]; 
xr = [matchedPoints2.Location, ones(8,1)];
fprintf("Matched points from left image:\n");
disp(xl)
fprintf("Matched points from right image:\n");
disp(xr)

for n=1:8
    A(n,:) = kron(xr(n,:),xl(n,:));
end
fprintf("A matrix:\n");
disp(A)

%% 5- Apply SVD to get fundamental matrix
[U, D, V] = svd(A);
Fa = reshape(V(:,9),3,3);
Fa_rank = rank(Fa);
fprintf("Fundamental matrix:\n");
disp(Fa)
fprintf("Rank of fundamental matrix: %d\n",Fa_rank);

%% 6- Apply a second SVD for the obtained F to enforce the rank to 2
[Ua, Da, Va] = svd(Fa);
F = Ua * diag([Da(1,1), Da(2,2), 0]) * transpose(Va);
F_rank = rank(F);
f = reshape(F,9,1);
x = A*f;
fprintf("\nFundamental matrix after second SVD:\n");
disp(F)
fprintf("Rank of fundamental matrix after second SVD: %d\n",F_rank);
fprintf("\nA*vect(F):\n");
disp(x)

%% 6- create the stereo anaglyph
B = stereoAnaglyph(I1,I2);
figure;
imshow(B);
title('Red-Cyan composite view of the rectified stereo pair image');

%% 7- disparity map 
disparityRange = [0 48];
disparityMap = disparity(I1,I2,'DisparityRange',disparityRange,'UniquenessThreshold',20);
figure;
imshow(disparityMap,disparityRange);
title('Disparity Map');
colormap jet;
colorbar;