clc;
clear;
a=imread('1.jpg');
[r c p]=size(a);
[LL LH HL HH]=dwt2(a,'haar');
%dec=[LL LH;HL HH];
%Quantazation
WaveletDecomposeImage=[LL LH;HL HH];
quantizedvalue=10;
QuantizedImage=WaveletDecomposeImage/quantizedvalue;
QuantizedImage=round(QuantizedImage);
ImageArray= toZigzag(QuantizedImage);
% Run Lenght encoding part
j=1
a=lenght(ImageArray);
count=0;
for n=1:a
    b=ImageArray(n);
    if n==1
        count=count+1;
        c(i)=count;
        s(j)=ImageArray(n);
    elseif ImageArray(n)==ImageArray(n+1)
        count=count+1;
    elseif ImageArray(n)==b
        count=count+1;
        c(i)=count;
        s(j)=ImageArray(n);
        j=j+1;
        count=0;
    end
end
% Calculating the bitcost
InputBitcost=row*col*8;
InputBitcost=(InputBitcost);
cl=lenght(c);
sl=length(s);
OutputBitcost= (cl*8)+(sl*8);
OutputBitcost=(OutputBitcost);
cr=InputBitcost/OutputBitcost;
% Run Lenght decoding part
g=lenght(s);
j=1;
i=1;
for i=1:g
    v(i)=s(j);
    if c(j)==0
        w=l+c(j)-1;
        for p=lw
            v(i)=s(j);
            I=l+1;
        end
    end
    j=j+1;
end
% Inverse Quantazation
ReconstructedImageArray=v;
ReconstructedImage=invZigzag(ReconstructedImageArray)
ReconstructedImage=ReconstructedImageArray*quantizedvalue;
% Wavelet Reconstruction
sX=size(ReconstructedImage);
cA1=ReconstructedImage(1:(sX(1)/2), 1:(sX(1)/2));
cH1=ReconstructedImage(1:(sX(1)/2),(sX(1)/2 +1):sX(1));
cV1=ReconstructedImage((sX(1)/2 +1):sX(1),1:(sX(1)/2));
cD1=ReconstructedImage((sX(1)/2 +1 ): sX(1),(sX(1)/2 +1):sX(1));
ReconstructedImage=idwt2(cA1,cH1,cV1,cD1,'haar');
% Calculating PSNR value and MSE
InputImage=double(a);
ReconstructedImage=double(ReconstructedImage);
[peaksnr, snr]=psnr(ReconstructedImage,InputImage);
n=size(InputImage);
M=n(1);
N=n(2);
MSE=sum(sum((InputImage-ReconstructedImage).^2))/(M*N);
PNSR=10*log10(256*256/MSE);
disp('MSE');
disp(MSE);
disp(PNSR);
disp('InputBitcost');
disp(InputBitcost);
disp('OutBitcost');
disp(OutputBitcost);

figure;
imshow(dec,[]);

% %__________
% LHR=zeros(246,250);
% HLR=zeros(246,250);
% HHR=zeros(246,250);
% rec=idwt2(LL,LHR,HLR,HHR,'haar');
% 
% figure;
% imshow(dec,[]);
% imshow(a);
% imshow(rec,[]);
% imwrite(dec,'2.jpg');
% 
% c=(491*500*8);
% ll=(246*250*8);
% cr=c/ll;  %cr- Compression ratio
% disp(cr);
disp('exit');