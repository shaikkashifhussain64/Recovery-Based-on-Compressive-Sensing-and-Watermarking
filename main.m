function [] = main_11_10_2023()
clc;
close all;
clear al;
% path(path,'PCNN_toolbox/')
path(path,'nsct_toolbox')
% path(path,'FusionEvaluation/')
path(path,'NSST-PAPCNN-Fusion-master/')
path(path,'NSST-PAPCNN-Fusion-master/shearlet/')

%% Read database
an = 0;
if an == 1
    fname = '.\Dataset\';                                                    % folder name
    MyFolderInfo = dir(fname);                                               % List the Files in folder
    for i = 1:length(MyFolderInfo)-2                                         % for all images
        sr = strcat(fname,MyFolderInfo(i+2).name);
        MyFolderInfo2 = dir(sr);
        for j = 1:length(MyFolderInfo2)-2
            sn = strcat(sr,'\',MyFolderInfo2(j+2).name);                     %adding file name after the folder directory
            Im{i,j} = imread(sn);                                            % read image  and store in Im{i}(cell format)
        end
    end
    save Im Im
end

%% Decomposition using NSCT
an = 0;
if an == 1
    load Im
    for i = 1: size(Im,1)
        a = find(~cellfun(@isempty,Im(i,:)));                                 % get the indices of non empty cell
        for j= 1:length(a)
            Img = Im{i,j};
            if length(size(Img))==3
                ori_A = rgb2gray(Img);
            else
                ori_A = Img;
            end
            A=double(ori_A)/255;
            %%Parameters for NSCT
            pfilt = '9-7';
            dfilt = 'pkva';
            nlevs = [0,1,3,4,4];% default
            %%Parameters for PCNN
            Para.iterTimes=200;
            Para.link_arrange=3;
            Para.alpha_L=1;% 0.06931 Or 1
            Para.alpha_Theta=0.2;
            Para.beta=3;% 0.2 or 3
            Para.vL=1.0;
            Para.vTheta=20;
            disp('Decompose the image via nsct ...')
            yA=nsctdec(A,nlevs,dfilt,pfilt);
            
            n = length(yA);
            %%Initialized the coefficients of fused image
            Fused=yA;
            % Lowpass subband
            disp('Process in Lowpass subband...')
            ALow= yA{1};
            
            % Highpass subband
            disp('Process in Highpass subband...')
            for l = 3:3%3:n
                for d = 2:2%1:length(yA{l})
                    Ahigh = yA{l}{d};
                    Fused{l}{d} = Ahigh;
                    
                    Arnoid_lowimg = iarnold(ALow, 1);
                    Arnoid_highimg = iarnold(Fused{l}{d}, 1);
                    combined_img = fuse_NSST_PAPCNN(Arnoid_lowimg,Arnoid_highimg);
                    figure,imshow(combined_img,[])
                end
            end
            Arnoid_lowimg = arnold(ALow, 1);
            Arnoid_highimg = arnold(Ahigh, 1);
            combined_img = fuse_NSST_PAPCNN(Arnoid_lowimg,Arnoid_highimg);
            figure,imshow(ori_A,[])
            figure,imshow(ALow,[])
            figure,imshow(Ahigh,[])
            figure,imshow(Arnoid_lowimg,[])
            figure,imshow(Arnoid_highimg,[])
            figure,imshow(combined_img,[])
        end
    end
end

%% KEY GENERATION
an = 0;
if an == 1
    load Im
    Key = zeros(2, 155);
    dec_key = zeros(2, 155);
    for i = 1: size(Im,1)
        a = find(~cellfun(@isempty,Im(i,:)));                                 % get the indices of non empty cell
        for j= 1:length(a)
            I = Im{i,j};
            Hash = DataHash(I, 'SHA-256','double');  % SHA3 hash Function
            K = [];
            for n = 1:length(Hash)
                bin = de2bi(Hash(n),8);  % Convert decimal To binary value
                K = [K bin];
            end
            Key(i, j)  = K;  % Key to preocess Encryption
            dec_key(i, j) = Hash;
        end
    end
    save Key Key
    save dec_key dec_key
end

%% Experiment
an = 0;
if an == 1
    load Key
    load dec_key;
    load Im
    Tar = dec_key;
    for i = 1 : size(Im, 1)  % for all images
        a = find(~cellfun(@isempty,Im(i,:)));                                 % get the indices of non empty cell
        for j= 1:10%length(a)
            disp(i); disp(j);
            K = Key(i, :);
            Ii = Im{i, j};
            Ii = imresize(Ii,[256 256]);
            if size(Ii,3)==3 % convert rgb to grayscale image
                I = rgb2gray(Ii);
            else
                I = Ii;
            end

            % Koppu paper
            CI1 = Logistic2D_ImageCipher(I,'encryption',K,'modGWO');
            DI1 = Logistic2D_ImageCipher(CI1,'decryption',K,'modGWO');
            Res(i,j, 1).Cipher = CI1; Res(i,j, 1).Decrypt = DI1; %Res(i,1).Perf = [val1 val2]; Res(i,1).alg = 1;
        end
    end
    save Res Res
end


%% Optimization for Cryptography %%
an = 0;
if an == 1
    load Im
    for i = 1 : length(Im)
        D_Size = [5, 10, 15, 20, 25];
        for k = 1 : length(D_Size)
            size = ceil(length(Dataset{i})*((D_Size(k)/10)/100));
            message = round(Dataset{i}(1: size, :));
            for j = 1 : 5 % For all Algorithms
                if j == 1; alg = RFO;
                elseif j == 2; alg = GEO;
                elseif j == 3; alg = RFO;
                elseif j == 4; alg = SCO;
                else
                    alg = Prop;
                end
                sol = round(alg(i).bs);
                Result{i, k}(j, :) = PROP();
            end
            sol = round(rand(1, 64));
            Result{i, k}(6, :) = DWT();
            Result{i, k}(7, :) = CHOA();
            Result{i, k}(8, :) = Arnold();
            Result{i, k}(9, :) = ALCE();
            Result{i, k}(10, :) = Result{i, k}(5, :);
        end
    end
    save Result Result
end
PlotResults()
Image_Results()
end