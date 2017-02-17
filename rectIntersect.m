function [ intersect ] = rectIntersect( rect1, rect2) %#codegen
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%rect1 = [0 0; -1 3; 6 4; 7 1];
%rect2 = [2 0; 4 1; 3 8; 2 7];      % does intersect
%rect2 = [12 0; 14 1; 13 8; 12 7];  % does not intersect

% add first vertex also as end element
rect1 = [rect1; rect1(1,:)];
rect2 = [rect2; rect2(1,:)];

%figure;
%hold on;
%plot (rect1(:,1), rect1(:,2));
%plot (rect2(:,1), rect2(:,2));

% use separating axis test to check whether rectangles are intersecting
%  - convex polygons do not intersecting if they can be separated by a
%  straight line, i.e. all vertices of the poligons are on different sides of
%  the line.  Furthermore, if the rectangles don't overlap one of the edges
%  will be such a separating axis.
%    => check if one of the eight edges separates the two rectangles. Use
%    sign of dot product to check on which side of the line the vertices are
%  see: http://stackoverflow.com/questions/115426/algorithm-to-detect-intersection-of-two-rectangles

% start assuming polygons are intersected
intersect = 1;

% loop through all edges of rect 1
for j=2:5
    % compute the edge vector
    x = rect1(j,1) - rect1(j-1,1);
    y = rect1(j,2) - rect1(j-1,2);
    %
    x_ref = rect1(j-1,1);
    y_ref = rect1(j-1,2);
    
    % compute the perpendcular to the edge vector
    x_rot = -y;
    y_rot = x;
    
    % check on which side the vertices are
    intersect = CheckSide(rect1, rect2, x_rot, y_rot,x_ref,y_ref);
    if (intersect == 0)
        break;
    end
end

% loop through all edges of rect 2 if separation line was not found yet
if (intersect == 1)
    for j=2:5
        % compute the edge vector
        x = rect2(j,1) - rect2(j-1,1);
        y = rect2(j,2) - rect2(j-1,2);
        %
        x_ref = rect2(j-1,1);
        y_ref = rect2(j-1,2);
        
        % compute the perpendcular to the edge vector
        x_rot = -y;
        y_rot = x;
        
        
        
        % check on which side the vertices are
        intersect = CheckSide(rect1,rect2, x_rot,y_rot,x_ref,y_ref);
        if (intersect == 0)
            break;
        end
    end
end

end

function intersect = CheckSide(rect1,rect2,x_rot,y_rot,x_ref,y_ref)

intersect = 1;
% compute projection of vertex onto perpendicular edge using dot
% product => sign gives direction
side1 = zeros(1,4);
side2 = zeros(1,4);
for k=1:4
    side1(k) = sign(x_rot * (rect1(k,1) - x_ref) + y_rot * (rect1(k,2) - y_ref));
end
for k=1:4
    side2(k) = sign(x_rot * (rect2(k,1) - x_ref) + y_rot * (rect2(k,2) - y_ref));
end

% check if vertices are on different sides of the edge
if ( min(side1) > -1 && max(side2) < 1) || ( max(side1) < 1 && min(side2) > -1)
    intersect = 0;
end
end