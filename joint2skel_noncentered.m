% This file writes yx, yz, and zx projections of MSR-Action3D skeletons as binary images of 5 sizes.
% -Wesley Chavez, 10-30-16

% files is an array of characters storing the skeleton filenames
[status,files]=system('ls *_skeleton.txt');

% 25 characters per filename, ex: 'a01_s01_e01_skeleton.txt\n'
for i = 1:size(files,2)/25
    aa = files((i-1)*25+2:(i-1)*25+3);
    ss = files((i-1)*25+6:(i-1)*25+7);
    ee = files((i-1)*25+10:(i-1)*25+11);
    vidIdentifier = ['a' aa '_s' ss '_e' ee];

    % Load 3D joint data into matrix for each video clip.
    % Each 20 rows of joints represents a single frame. (20 joints per frame)
    % Each row represents a single joint, [x,y,z,confidence_value].  I don't use confidence_value
    joints=load(['/stash/tlab/datasets/MSR-Action3D/skeletons/' vidIdentifier '_skeleton.txt']);

    % We draw "bones" from jointindex1(x) to jointindex2(x).
    % The diagram for joint positions is at:
    % http://research.microsoft.com/en-us/um/people/zliu/ActionRecoRsrc/SkeletonModelMSRAction3D.jpg
    jointindex1=[12 10 8 1 3 3 2 9 11 3 4 7 5 14 16 7 6 15 17];
    jointindex2=[10 8 1 3 20 2 9 11 13 4 7 5 14 16 18 6 15 17 19];

    % For each frame
    for j = 1:size(joints,1)/20
        % Head locations
        xhead = joints((j-1)*20+20,1);
        yhead = joints((j-1)*20+20,2);
        zhead = round(joints((j-1)*20+20,3)*240/970);

        % Offset of the head from middle position
	xdiff = 20;
	ydiff = 0;
	zdiff = 0;

	% Initializations
	im320x240_yx = uint8(zeros(320,240));
        im160x120_yx = uint8(zeros(160,120));
        im80x60_yx = uint8(zeros(80,60));
        im40x30_yx = uint8(zeros(40,30));
        im20x15_yx = uint8(zeros(20,15));
        index320x240_yx = [];
        index160x120_yx = [];
        index80x60_yx = [];
        index40x30_yx = [];
        index20x15_yx = [];
	
	im320x240_yz = uint8(zeros(320,240));
        im160x120_yz = uint8(zeros(160,120));
        im80x60_yz = uint8(zeros(80,60));
        im40x30_yz = uint8(zeros(40,30));
        im20x15_yz = uint8(zeros(20,15));
        index320x240_yz = [];
        index160x120_yz = [];
        index80x60_yz = [];
        index40x30_yz = [];
        index20x15_yz = [];

	im240x240_zx = uint8(zeros(240,240));
        im120x120_zx = uint8(zeros(120,120));
        im60x60_zx = uint8(zeros(60,60));
        im30x30_zx = uint8(zeros(30,30));
        im15x15_zx = uint8(zeros(15,15));
        index240x240_zx = [];
        index120x120_zx = [];
        index60x60_zx = [];
        index30x30_zx = [];
        index15x15_zx = [];
	% For each "bone"
        for k = 1:19
            % Start and end point (the joints, offset)
	    xpt1 = joints((j-1)*20+jointindex1(k),1) - xdiff;
	    xpt2 = joints((j-1)*20+jointindex2(k),1) - xdiff;
	    ypt1 = joints((j-1)*20+jointindex1(k),2) - ydiff;
	    ypt2 = joints((j-1)*20+jointindex2(k),2) - ydiff;
	    zpt1 = round(joints((j-1)*20+jointindex1(k),3)*240/970) - zdiff;
	    zpt2 = round(joints((j-1)*20+jointindex2(k),3)*240/970) - zdiff;

            % Array of indices between the points
            x=linspace(xpt1,xpt2,1000);
            y=linspace(ypt1,ypt2,1000);
            z=linspace(zpt1,zpt2,1000);

            % Downsampled indices
            % If any of the values round to 0, set to 1 
	    roundx = round(x);
            if (roundx(1) == 0 || roundx(end) == 0)
                roundx(find(~roundx)) = 1;
            end
	    roundy = round(y);
            if (roundy(1) == 0 || roundy(end) == 0)
                roundy(find(~roundy)) = 1;
            end
	    roundz = round(z);
            if (roundz(1) == 0 || roundz(end) == 0)
                roundz(find(~roundz)) = 1;
            end

            xdiv2 = round(x/2);
            if (xdiv2(1) == 0 || xdiv2(end) == 0)
                xdiv2(find(~xdiv2)) = 1;
            end
            ydiv2 = round(y/2);
            if (ydiv2(1) == 0 || ydiv2(end) == 0)
                ydiv2(find(~ydiv2)) = 1;
            end
            zdiv2 = round(z/2);
            if (zdiv2(1) == 0 || zdiv2(end) == 0)
                zdiv2(find(~zdiv2)) = 1;
            end
            xdiv4 = round(x/4);
            if (xdiv4(1) == 0 || xdiv4(end) == 0)
                xdiv4(find(~xdiv4)) = 1;
            end
            ydiv4 = round(y/4);
            if (ydiv4(1) == 0 || ydiv4(end) == 0)
                ydiv4(find(~ydiv4)) = 1;
            end
            zdiv4 = round(z/4);
            if (zdiv4(1) == 0 || zdiv4(end) == 0)
                zdiv4(find(~zdiv4)) = 1;
            end
            xdiv8 = round(x/8);
            if (xdiv8(1) == 0 || xdiv8(end) == 0)
                xdiv8(find(~xdiv8)) = 1;
            end
            ydiv8 = round(y/8);
            if (ydiv8(1) == 0 || ydiv8(end) == 0)
                ydiv8(find(~ydiv8)) = 1;
            end
            zdiv8 = round(z/8);
            if (zdiv8(1) == 0 || zdiv8(end) == 0)
                zdiv8(find(~zdiv8)) = 1;
            end
            xdiv16 = round(x/16);
            if (xdiv16(1) == 0 || xdiv16(end) == 0)
                xdiv16(find(~xdiv16)) = 1;
            end
            ydiv16 = round(y/16);
            if (ydiv16(1) == 0 || ydiv16(end) == 0)
                ydiv16(find(~ydiv16)) = 1;
            end
            zdiv16 = round(z/16);
            if (zdiv16(1) == 0 || zdiv16(end) == 0)
                zdiv16(find(~zdiv16)) = 1;
            end

            % Concatenate "bone" indices with others in same frame. 
            index320x240_yx = [index320x240_yx sub2ind(size(im320x240_yx),roundy,roundx)];
            index160x120_yx = [index160x120_yx sub2ind(size(im160x120_yx),ydiv2,xdiv2)];
            index80x60_yx = [index80x60_yx sub2ind(size(im80x60_yx),ydiv4,xdiv4)];
            index40x30_yx = [index40x30_yx sub2ind(size(im40x30_yx),ydiv8,xdiv8)];
            index20x15_yx = [index20x15_yx sub2ind(size(im20x15_yx),ydiv16,xdiv16)];

            index320x240_yz = [index320x240_yz sub2ind(size(im320x240_yz),roundy,roundz)];
            index160x120_yz = [index160x120_yz sub2ind(size(im160x120_yz),ydiv2,zdiv2)];
            index80x60_yz = [index80x60_yz sub2ind(size(im80x60_yz),ydiv4,zdiv4)];
            index40x30_yz = [index40x30_yz sub2ind(size(im40x30_yz),ydiv8,zdiv8)];
            index20x15_yz = [index20x15_yz sub2ind(size(im20x15_yz),ydiv16,zdiv16)];

            index240x240_zx = [index240x240_zx sub2ind(size(im240x240_zx),roundz,roundx)];
            index120x120_zx = [index120x120_zx sub2ind(size(im120x120_zx),zdiv2,xdiv2)];
            index60x60_zx = [index60x60_zx sub2ind(size(im60x60_zx),zdiv4,xdiv4)];
            index30x30_zx = [index30x30_zx sub2ind(size(im30x30_zx),zdiv8,xdiv8)];
            index15x15_zx = [index15x15_zx sub2ind(size(im15x15_zx),zdiv16,xdiv16)];

        end

        % Output image at indices is white pixel.
        im320x240_yx(index320x240_yx) = 255;
        im160x120_yx(index160x120_yx) = 255;
        im80x60_yx(index80x60_yx) = 255;
        im40x30_yx(index40x30_yx) = 255;
        im20x15_yx(index20x15_yx) = 255;
        
        im320x240_yz(index320x240_yz) = 255;
        im160x120_yz(index160x120_yz) = 255;
        im80x60_yz(index80x60_yz) = 255;
        im40x30_yz(index40x30_yz) = 255;
        im20x15_yz(index20x15_yz) = 255;

        im240x240_zx(index240x240_zx) = 255;
        im120x120_zx(index120x120_zx) = 255;
        im60x60_zx(index60x60_zx) = 255;
        im30x30_zx(index30x30_zx) = 255;
        im15x15_zx(index15x15_zx) = 255;

        % Write images
        imwrite(im320x240_yx,['skeletons_noncentered/320x240_yx_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im160x120_yx,['skeletons_noncentered/160x120_yx_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im80x60_yx,['skeletons_noncentered/80x60_yx_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im40x30_yx,['skeletons_noncentered/40x30_yx_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im20x15_yx,['skeletons_noncentered/20x15_yx_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        
	imwrite(im320x240_yz,['skeletons_noncentered/320x240_yz_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im160x120_yz,['skeletons_noncentered/160x120_yz_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im80x60_yz,['skeletons_noncentered/80x60_yz_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im40x30_yz,['skeletons_noncentered/40x30_yz_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im20x15_yz,['skeletons_noncentered/20x15_yz_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);

        imwrite(im240x240_zx,['skeletons_noncentered/240x240_zx_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im120x120_zx,['skeletons_noncentered/120x120_zx_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im60x60_zx,['skeletons_noncentered/60x60_zx_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im30x30_zx,['skeletons_noncentered/30x30_zx_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
        imwrite(im15x15_zx,['skeletons_noncentered/15x15_zx_Skeleton_' vidIdentifier '_' sprintf('%.03d',j) '.png']);
    end
end
