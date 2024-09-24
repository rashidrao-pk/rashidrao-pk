%/************************************************************************\
%/*                       KYUNG HEE UNIVERSITY                           *\
%/*                       Biomedical Department                          *\
%/*                 Medical Imaging System Laboratory                    *\
%/*                                                                      *\
%/*Name of Program: Denoising Metrics Demo                               *\
%/*By: Eric Michel Glez.                                                 *\
%/*Date: 28th May 2016                                                   *\
%/************************************************************************\
%
%  Please refer (and cite) to:    
%
%  [1]  Eric Michel, Min H. Cho and Soo Y. Lee, "Geometric nonlinear 
%       diffusion filter and its application to X-ray imaging"
%       BioMedical Engineering OnLine 2011, 10:47.
%       http://www.biomedical-engineering-online.com/content/10/1/47
%
%       Any comments and suggestions to: eric.michel.glez@gmail.com
%                     
%                    Copyright (c) since 2016 ERIC MICHEL     
%
%**************************************************************************
%**************************************************************************
close all;
clear all;
clc;
        
%--- Parameters
std_n = 0.05;       % Noise standard deviation
kernel = 3;         % Filter kernel size
iterations = 10;    % Number of iterations filtering
% ----- Load Image
image = phantom('Modified Shepp-Logan',256);    %Shepp-Logan Phantom
max_i = max(image(:));
Io = image./max_i;
    
% ----- Corrupt the image
vari=std_n^2;
In = imnoise(Io, 'gaussian',0,vari);    %Gaussian noise zero mean
In = imnoise(In, 'salt & pepper',std_n/2);    % Salt and pepper noise
In(In < 0) = 0;             % Eliminate Negative values
max_i = max(In(:));
In(~isfinite(In))=max_i;    %  Eliminate Infinite values     
    
Imfa=In;    %Initial condition
%%
NMSEa=zeros(1,iterations);
% Image filtering
H = fspecial('average', [kernel kernel]);
for iter=1:iterations
    
    %Average filtering
    Imfa = imfilter(Imfa,H,'replicate');
    
    % Get Normalized Mean Square Error value
    NMSEa(1,iter) = nmse(Io,In,Imfa);
end
    % PLOT TRUE IMAGE
    figure;
        imagesc(Io); colormap gray; axis square; %colorbar;        
        msg =  strcat('True Image');
        title(msg); 
        
    % PLOT NOISE IMAGE
    figure;
        imagesc(In); colormap gray; axis square; %colorbar;        
        msg =  strcat('Noise Image');
        title(msg); 
    % PLOT FILTERED IMAGES
    figure;
        imagesc(Imfa); colormap gray; axis square; %colorbar;        
        msg =  strcat('Average Filter',',  Iter=',num2str(iterations));
        title(msg);  
        
%%         
   
% Metrics
offset=0.0;
beta = bmetric(Io,Imfa,offset)  %Beta metric
cutoff=100;
ner = nerr(Io,In,Imfa,cutoff)   % Noise energy reduction ratio
% Plot Normalized Mean Square Error
figure; set(gcf, 'defaultaxesfontsize', 18);
plot(NMSEa,'-^','Color','r','LineWidth',2.2);  hold on;
xlabel('Number of Iterations'); 
ylabel('NMSE');
msg =  strcat('Normalized Mean Square Error');
title(msg,'FontSize',20); 