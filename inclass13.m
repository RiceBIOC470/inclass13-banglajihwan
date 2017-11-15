%Inclass 13
%GB comments
1a 100
1b 100
1c 100
1d 100
2a 100
2b 100
2c 100
overall: 100


%Part 1. In this directory, you will find an image of some cells expressing a 
% fluorescent protein in the nucleus. 
% A. Create a new image with intensity normalization so that all the cell
% nuclei appear approximately eqully bright. 
img = imread('Dish1Well8Hyb1Before_w0001_m0006.tif',1); 
img_double = im2double(img);
img_double_dilate = imdilate(img_double, strel('disk', 150)); % 150 gives a decent result
img_double_dilate_norm = img_double./img_double_dilate;
imshow(img_double_dilate_norm,[]); 
% B. Threshold this normalized image to produce a binary mask where the nuclei are marked true.
xmask = img_double_dilate_norm > 0.35; 
imshow(xmask); 

% C. Run an edge detection algorithm and make a binary mask where the edges
% are marked true.
edge_img = edge(img, 'canny', [0.01 0.05]);
imshow(edge_img, []);
% D. Display a three color image where the orignal image is red, the
% nuclear mask is green, and the edge mask is blue. 
toshow = cat(3, img_double_dilate_norm, xmask, edge_img); 
imshow(toshow); %we need to use the normalized image to actually see green and blue. 

%Part 2. Continue with your nuclear mask from part 1. 
%A. Use regionprops to find the centers of the objects
nucleus_properties = regionprops(xmask, 'Centroid')
centroid = struct2cell(nucleus_properties)
%B. display the mask and plot the centers of the objects on top of the
%objects
centroid_mat = cell2mat(centroid);
centroid_mat_x = centroid_mat(1:2:end); 
centroid_mat_y = centroid_mat(2:2:end); 
imshow(xmask); 
hold on; 
scatter(centroid_mat_x, centroid_mat_y); 

%C. Make a new figure without the image and plot the centers of the objects
%so they appear in the same positions as when you plot on the image (Hint: remember
%Image coordinates). 
hold off
scatter(centroid_mat_x, -centroid_mat_y); 


