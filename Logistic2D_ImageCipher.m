function varargout = Logistic2D_ImageCipher(P,para,K,alg)
global algn
%% 1. Initialization
% 1.1. Genereate Random Key if K is not given
if ~exist('K','var') && strcmp(para,'encryption') 
    K = round(rand(1,256));
    varOutN = 2;
elseif ~exist('K','var') && strcmp(para,'decryption') 
    error('Cannot Complete Decryption without Encryption Key')
else
    varOutN = 1;
end
% 1.2. Translate K to map formats
transFrac = @(K,st,ed) sum(K(st:ed).*2.^(-(1:(ed-st+1)))); 

x01 = transFrac(K,1,52);
y01 = transFrac(K,53,104);
xmax = unifrnd(1,1,[10,2]);
xmin = unifrnd(0.1,0.1,[10,2]);
initsoln = unifrnd(0.1,1,[10,2]);
initsoln(1,:) = [x01 y01];
tic
% [bs, fit] = feval(alg,initsoln,xmax,xmin,25,P,K,transFrac);
% et = toc;
% algn.bs = bs; algn.fit = fit; algn.time = et;
x0 = 0.5;%bs(1);
y0 = 0.5;%bs(2);

r = transFrac(K,105,156)*.08+1.11;
T = transFrac(K,157,208);
turb = blkproc(K(209:256),[1,8],@(x) bi2de(x));

MN = numel(P);
% 1.3 2D Logistic map
Logistic2D = @(x,y,r) [r*(3*y+1)*x*(1-x), r*(3*(r*(3*y+1)*x*(1-x))+1)*y*(1-y)];
% format long eng
%% 2. Estimate cipher rounds
if max(P(:))>1
    F = 256;
    S = 4;
else
    F = 2;
    S = 32;
end
P = double(P);
iter = ceil(log2(numel(P))/log2(S));

%% 3. Image Cipher
C = double(P);
switch para
    case 'encryption'
        for i = 1:iter
            tx0 = mod(log(turb(mod(i-1,6)+1)+i)*x0+T,1);
            ty0 = mod(log(turb(mod(i-1,6)+1)+i)*y0+T,1);
            xy = zeros(MN,2);
            for n = 1:MN
                if n == 1
                    xy(n,:) = abs(Logistic2D(tx0,ty0,r)); 
                else
                    xy(n,:) = abs(Logistic2D(xy(n-1,1),xy(n-1,2),r));
                end
            end
            R = cat(3,reshape(xy(:,1),size(P,1),size(P,2)),reshape(xy(:,2),size(P,1),size(P,2)));
            C = LogisticSubstitution(C,R,'encryption');   
            C = LogisticPermutation(C,R,'encryption');
            C = LogisticMDS(C,'encryption');
        end
    case 'decryption'
        for i = iter:-1:1
            tx0 = mod(log(turb(mod(i-1,6)+1)+i)*x0+T,1);
            ty0 = mod(log(turb(mod(i-1,6)+1)+i)*y0+T,1);
            xy = zeros(MN,2);
            for n = 1:MN
                if n == 1
                    xy(n,:) = abs(Logistic2D(tx0,ty0,r)); 
                else
                    xy(n,:) = abs(Logistic2D(xy(n-1,1),xy(n-1,2),r));
                end
            end
            R = cat(3,reshape(xy(:,1),size(P,1),size(P,2)),reshape(xy(:,2),size(P,1),size(P,2)));
            C = LogisticMDS(C,'decryption');
            C = LogisticPermutation(C,R,'decryption'); 
            C = LogisticSubstitution(C,R,'decryption');                          
        end
end
%% 4. Output
switch F
    case 2
        C = logical(C);
    case 256
        C = uint8(C);
end

switch varOutN
    case 1
        varargout{1} = C;
    case 2
        varargout{1} = C;
        varargout{2} = K;
end
end

function C = LogisticPermutation(P,R,para)

C0 = zeros(size(P));
C = C0;
switch para
    case 'encryption'
        % 1. Shuffling within a Column
        [v,Epix] = sort(R(:,:,1),1);
        for i = 1:size(R,1)
            C0(:,i) = P(Epix(:,i),i);
        end
        % 2. Shuffling within a Row
        [v,Epiy] = sort(R(:,:,2),2);
        for j = 1:size(R,1)
            C(j,:) = C0(j,Epiy(j,:));
        end
    case 'decryption'
        % 1. Shuffling within a Row
        [v,Epiy] = sort(R(:,:,2),2);
        for j = 1:size(R,1)
            C0(j,Epiy(j,:)) = P(j,:);
        end
        % 2. Shuffling within a Column
        [v,Epix] = sort(R(:,:,1),1);
        for i = 1:size(R,2)
            C(Epix(:,i),i) = C0(:,i);
        end
end
end

function C = LogisticSubstitution(P,R,para)

trun = @(x,low,high) floor(x.*10^high)-floor(x.*10^(low-1))*10^(high-low+1);
T = trun(R(:,:,1)+R(:,:,2),9,16);
gfun = @(B,F) [mod(B(1,1),F), floor(mod(B(1,2),F)), mod(B(1,3)^2,F), mod(2*B(1,4),F);...
    floor(mod(B(2,1),F)), mod(B(2,2)^2,F), mod(2*B(2,3),F),mod(B(2,4),F);...
    mod(B(3,1)^2,F), mod(2*B(3,2),F),mod(B(3,3),F),floor(mod(B(3,4),F));...
    mod(2*B(4,1),F),mod(B(4,2),F),floor(mod(B(4,3),F)),mod(B(4,4)^2,F)];
if max(P(:))>1
    F = 256;
else
    F = 2;
end
I = blkproc(T,[4,4],@(x) gfun(x,F));

switch para
    case 'encryption'
        C = mod(I+P,F);
    case 'decryption'
        C = mod(P-I,F);
end
end

