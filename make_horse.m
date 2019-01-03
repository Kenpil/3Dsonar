ptCloud = pcread('horse.ply');
pointscolor=uint8(zeros(ptCloud.Count,3));
pointscolor(:,1)=0;
pointscolor(:,2)=255;
pointscolor(:,3)=0;
ptCloud.Color=pointscolor;
pcshow(ptCloud);
pcwrite(ptCloud,'horse.ply');