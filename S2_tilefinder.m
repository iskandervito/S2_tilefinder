%*******************************************************************
%
% License:  See top level LICENSE.txt file.
%
% Author: Iskander Benhadj (iskander.benhadj@vito.be)
% Description: Tool to find S2 tiles intersecting a bounding box.
%
%
%*************************************************************************

clc;
close all;
clear all;
tic;
%Modify these bounding box coordinates to yours
topLeftLat = 52;
topLeftLon = 5;
bottomRightLat = 52;
bottomRightLon = 5;
%check bbox coordinates
if topLeftLon > bottomRightLon
    error('Invalid longitude inputs');
end

if topLeftLat < bottomRightLat
    error('Invalid latitude inputs');
end

if topLeftLat ==  bottomRightLat
    topLeftLat = topLeftLat+0.000001;
end

if topLeftLon == topLeftLon
    topLeftLon = topLeftLon +0.000001;
end
%build the bounding box
rect1 = [ topLeftLon topLeftLat ;  bottomRightLon topLeftLat;  bottomRightLon bottomRightLat; topLeftLon bottomRightLat];
%load the sentinel2 grid
load sentinel2_tile_grid;

if topLeftLat-bottomRightLat <0.3
    Lat = rect1(:,2);
else
    Lat = topLeftLat:-0.2:bottomRightLat;
    Lat = [Lat bottomRightLat];
end


if bottomRightLon-topLeftLon <0.2
    Lon = rect1(:,1);
else
    Lon = topLeftLon:0.1:bottomRightLon;
    Lon = Lon';
    Lon = [Lon; bottomRightLon];
end

llat = length(Lat);
llon = length(Lon);
if llat > 4
    Lat = repmat(Lat,llon,1);
end
if llon > 4
    Lon = repmat(Lon,1,llat);
end
%get the utmzone intersecting your bounding box
[x,y,utmzone] = deg2utm(Lat(:),Lon(:));
for j = 1:size(utmzone,1)
    utm{j} = utmzone(j,:);
end
%remove duplicate zones
utmzone = unique(utm);
for j = 1: length(utmzone)
    disp(['Found possible ',utmzone{j}, ' UTM zone search'])
end

%find in the S2 grid the ones that are within the founded utmzone
lshp = length(shp);
index = cell(length(utmzone),1);
for j = 1:length(utmzone)
    index{j} = shp(strcmp(shp(:,5),utmzone{j}),:);
end
l = length(index);
rect1p = [rect1; rect1(1,:)];
plot(rect1p(:,1),rect1p(:,2),'b');

%Find the S2 tiles intersecting the user bounding box
found1Tile = 0;
for k = 1:l
    id = index{k};
    for j = 1: length(id)
        rect2 = [ id{j,2}(1,1) id{j,2}(2,2); id{j,2}(2,1)  id{j,2}(2,2); id{j,2}(2,1) id{j,2}(1,2);id{j,2}(1,1) id{j,2}(1,2)];
        rect2p = [rect2; rect2(1,:)];
        intersect = rectIntersect( rect1, rect2);
        hold on, plot(rect2p(:,1),rect2p(:,2),'r');
        if intersect == 1
            found1Tile = 1;
            disp(['Found S2 tile :',id{j,5},id{j,6}, ' [minLon = ',num2str(id{j,2}(1,1),'%3.6f'), ',minLat = ',num2str(id{j,2}(1,2),'%3.6f'), ',maxLon = ',num2str(id{j,2}(2,1),'%3.6f'),',maxLat = ',num2str(id{j,2}(2,2),'%3.6f'),']']);
            hold on, plot(rect2p(:,1),rect2p(:,2),'g');
        end
    end
end
if found1Tile == 0
    disp('Found no S2 tiles intersecting your region of interest');
end
title('[Requested bounding box(blue)] [Tested S2 tiles(red)] [Selected S2 tiles(green)]');
toc;