clear all
ptCloud = pcread('horse.ply');
pointscolor=uint8(zeros(ptCloud.Count,3));
pointscolor(:,1)=0;
pointscolor(:,2)=255;
pointscolor(:,3)=0;
ptCloud.Color=pointscolor;
stepSize = 10;
indices = 1:stepSize:ptCloud.Count;
ptCloud = select(ptCloud,indices);
ptCloud;
A = ptCloud.Location;
X = vec2mat(A(:, 1), 1);
Y = vec2mat(A(:, 2), 1);
Z = vec2mat(A(:, 3), 1);
count = length(X)

nd = ones(1, count);
d1 = zeros(1, count);
d2 = zeros(1, count);
d3 = zeros(1, count);
d4 = zeros(1, count);
d5 = zeros(1, count);
d6 = zeros(1, count);
d7 = zeros(1, count);
d8 = zeros(1, count);


for i = 1: (count)
    if X(i) >= 0
        if Y(i) >= 0
            if Z(i) >= 0
                d1(1, nd(1, 1)) = i;%1象限の点の番号行列d1作成。nd(1, <1>)が<>象限の点の個数を表し、d1が個数目ごとの全体における番号を記録
                nd(1, 1) = nd(1, 1) + 1;
            else
                d5(1, nd(1, 5)) = i;
                nd(1, 5) = nd(1, 5) + 1;
            end
        else
            if Z(i) >= 0
                d4(1, nd(1, 4)) = i;
                nd(1, 4) = nd(1, 4) + 1;
            else
                d8(1, nd(1, 8)) = i;
                nd(1, 8) = nd(1, 8) + 1;
            end
        end
    else
        if Y(i) >= 0
            if Z(i) >= 0
                d2(1, nd(1, 2)) = i;
                nd(1, 2) = nd(1, 2) + 1;
            else
                d6(1, nd(1, 6)) = i;
                nd(1, 6) = nd(1, 6) + 1;
            end
        else
            if Z(i) >= 0
                d3(1, nd(1, 3)) = i;
                nd(1, 3) = nd(1, 3) + 1;
            else
                d7(1, nd(1, 7)) = i;
                nd(1, 7) = nd(1, 7) + 1;
            end
        end
    end
end

maxnd = 0;
for i = 1:8
    nd(1, i) = nd(1, i) - 1;
    if nd(1, i) > maxnd
        maxnd = nd(1, i);
    end
end

%(n-1) = 象限における点の個数
%size(d) =  象限における点の個数
l = zeros(maxnd, maxnd, 8);

for n = 1:(nd(1, 1) - 1)
    for nn = (n + 1):nd(1, 1)
        l(n, nn, 1) = (X(d1(1, nn)) - X(d1(1,n))) ^ 2 + (Y(d1(1, nn)) - Y(d1(1,n))) ^  2 + (Z(d1(1, nn)) - Z(d1(1,n))) ^  2 ;
    end
end

for n = 1:(nd(1, 2) - 1)
    for nn = (n + 1):nd(1, 2)
        l(n, nn, 2) = (X(d2(1, nn)) - X(d2(1,n))) ^ 2 + (Y(d2(1, nn)) - Y(d2(1,n))) ^  2 + (Z(d2(1, nn)) - Z(d2(1,n))) ^  2 ;
    end
end

for n = 1:(nd(1, 3) - 1)
    for nn = (n + 1):nd(1, 3)
        l(n, nn, 3) = (X(d3(1, nn)) - X(d3(1,n))) ^ 2 + (Y(d3(1, nn)) - Y(d3(1,n))) ^  2 + (Z(d3(1, nn)) - Z(d3(1,n))) ^  2 ;
    end
end

for n = 1:(nd(1, 4) - 1)
    for nn = (n + 1):nd(1, 4)
        l(n, nn, 4) = (X(d4(1, nn)) - X(d4(1,n))) ^ 2 + (Y(d4(1, nn)) - Y(d4(1,n))) ^  2 + (Z(d4(1, nn)) - Z(d4(1,n))) ^  2 ;
    end
end

for n = 1:(nd(1, 5) - 1)
    for nn = (n + 1):nd(1, 5)
        l(n, nn, 5) = (X(d5(1, nn)) - X(d5(1,n))) ^ 2 + (Y(d5(1, nn)) - Y(d5(1,n))) ^  2 + (Z(d5(1, nn)) - Z(d5(1,n))) ^  2 ;
    end
end

for n = 1:(nd(1, 6) - 1)
    for nn = (n + 1):nd(1, 6)
        l(n, nn, 6) = (X(d6(1, nn)) - X(d6(1,n))) ^ 2 + (Y(d6(1, nn)) - Y(d6(1,n))) ^  2 + (Z(d6(1, nn)) - Z(d6(1,n))) ^  2 ;
    end
end

for n = 1:(nd(1, 7) - 1)
    for nn = (n + 1):nd(1, 7)
        l(n, nn, 7) = (X(d7(1, nn)) - X(d7(1,n))) ^ 2 + (Y(d7(1, nn)) - Y(d7(1,n))) ^  2 + (Z(d7(1, nn)) - Z(d7(1,n))) ^  2 ;
    end
end

for n = 1:(nd(1, 8) - 1)
    for nn = (n + 1):nd(1, 8)
        l(n, nn, 8) = (X(d8(1, nn)) - X(d8(1,n))) ^ 2 + (Y(d8(1, nn)) - Y(d8(1,n))) ^  2 + (Z(d8(1, nn)) - Z(d8(1,n))) ^  2 ;
    end
end

minn = ones(2, maxnd, 8);
minn2 = ones(2, maxnd, 8);

for d = 1:8
    for i = 1:maxnd
        for t = 1:maxnd
            if i > t
                if l(t, i, d) ~= 0
                    if l(t, i, d) < minn(2, i, d)
                        minn2(1, i, d) = minn(1, i, d);
                        minn2(2, i, d) = minn(2, i, d);
                        minn(1, i, d) = t;
                        minn(2, i, d) = l(t, i, d);
                    end
                end
                if l(t, i, d) ~= 0
                    if l(t, i, d) >= minn(2, i, d)
                        if l(t, i, d) <= minn2(2, i, d)
                            if t ~= minn(1, i, d)
                                minn2(1, i, d) = t;
                                minn2(2, i, d) = l(t, i, d);
                            end
                        end
                    end
                end
            end
            if i < t
                if l(i, t, d) ~= 0
                    if l(i, t, d) < minn(2, i, d)
                        minn2(1, i, d) = minn(1, i, d);
                        minn2(2, i, d) = minn(2, i, d);
                        minn(1, i, d) = t;
                        minn(2, i, d) = l(i, t, d);
                    end
                end
                if l(i, t, d) ~= 0
                    if l(i, t, d) >= minn(2, i, d)
                        if l(i, t, d) <= minn2(2, i, d)
                            if t ~= minn(1, i, d)
                                minn2(1, i, d) = t;
                                minn2(2, i, d) = l(i, t, d);
                            end
                        end
                    end
                end
            end
            if i == t
            end
        end
    end
end
% l
% minn
% minn2
% nd
% maxnd
% d1
for i = 1:nd(1, 1)
    Color = [1; 1; 1];

    XXX = [X(d1(i)); X(d1(minn(1, i, 1))); X(d1(minn2(1, i, 1)))];%d象限のi番目と、その点のminnとminn2。minn(番号の方, i番目に対する, d象限)
    YYY = [Y(d1(i)); Y(d1(minn(1, i, 1))); Y(d1(minn2(1, i, 1)))];
    ZZZ = [Z(d1(i)); Z(d1(minn(1, i, 1))); Z(d1(minn2(1, i, 1)))];
    fill3(XXX, YYY, ZZZ, 'g')

    hold on
    %pause(0.001);
end
for i = 1:nd(1, 2)
    Color = [1; 1; 1];

    XXX = [X(d2(i)); X(d2(minn(1, i, 2))); X(d2(minn2(1, i, 2)))];
    YYY = [Y(d2(i)); Y(d2(minn(1, i, 2))); Y(d2(minn2(1, i, 2)))];
    ZZZ = [Z(d2(i)); Z(d2(minn(1, i, 2))); Z(d2(minn2(1, i, 2)))];
    fill3(XXX, YYY, ZZZ, 'g')

    hold on
    %pause(0.001);
end
for i = 1:nd(1, 3)
    Color = [1; 1; 1];

    XXX = [X(d3(i)); X(d3(minn(1, i, 3))); X(d3(minn2(1, i, 3)))];
    YYY = [Y(d3(i)); Y(d3(minn(1, i, 3))); Y(d3(minn2(1, i, 3)))];
    ZZZ = [Z(d3(i)); Z(d3(minn(1, i, 3))); Z(d3(minn2(1, i, 3)))];
    fill3(XXX, YYY, ZZZ, 'g')

    hold on
    %pause(0.001);
end
for i = 1:nd(1, 4)
    Color = [0.5; 0.4; 0.2];

    XXX = [X(d4(i)); X(d4(minn(1, i, 4))); X(d4(minn2(1, i, 4)))];
    YYY = [Y(d4(i)); Y(d4(minn(1, i, 4))); Y(d4(minn2(1, i, 4)))];
    ZZZ = [Z(d4(i)); Z(d4(minn(1, i, 4))); Z(d4(minn2(1, i, 4)))];
    fill3(XXX, YYY, ZZZ, 'g')

    hold on
    %pause(0.001);
end
for i = 1:nd(1, 5)
    Color = [0.5; 0.4; 0.2];

    XXX = [X(d5(i)); X(d5(minn(1, i, 5))); X(d5(minn2(1, i, 5)))];
    YYY = [Y(d5(i)); Y(d5(minn(1, i, 5))); Y(d5(minn2(1, i, 5)))];
    ZZZ = [Z(d5(i)); Z(d5(minn(1, i, 5))); Z(d5(minn2(1, i, 5)))];
    fill3(XXX, YYY, ZZZ, 'g')

    hold on
    %pause(0.001);
end
for i = 1:nd(1, 6)
    Color = [0.5; 0.4; 0.2];

    XXX = [X(d6(i)); X(d6(minn(1, i, 6))); X(d6(minn2(1, i, 6)))];
    YYY = [Y(d6(i)); Y(d6(minn(1, i, 6))); Y(d6(minn2(1, i, 6)))];
    ZZZ = [Z(d6(i)); Z(d6(minn(1, i, 6))); Z(d6(minn2(1, i, 6)))];
    fill3(XXX, YYY, ZZZ, 'g')

    hold on
    %pause(0.001);
end
for i = 1:nd(1, 7)
    Color = [0.5; 0.4; 0.2];

    XXX = [X(d7(i)); X(d7(minn(1, i, 7))); X(d7(minn2(1, i, 7)))];
    YYY = [Y(d7(i)); Y(d7(minn(1, i, 7))); Y(d7(minn2(1, i, 7)))];
    ZZZ = [Z(d7(i)); Z(d7(minn(1, i, 7))); Z(d7(minn2(1, i, 7)))];
    fill3(XXX, YYY, ZZZ, 'g')

    hold on
    %pause(0.001);
end
for i = 1:nd(1, 8)
    Color = [0.5; 0.4; 0.2];

    XXX = [X(d8(i)); X(d8(minn(1, i, 8))); X(d8(minn2(1, i, 8)))];
    YYY = [Y(d8(i)); Y(d8(minn(1, i, 8))); Y(d8(minn2(1, i, 8)))];
    ZZZ = [Z(d8(i)); Z(d8(minn(1, i, 8))); Z(d8(minn2(1, i, 8)))];
    fill3(XXX, YYY, ZZZ, 'g')

    hold on
    %pause(0.001);
end
%plot3(X, Y, Z)


%pcshow(ptCloud)
%pcwrite(ptCloud,'horse.ply');