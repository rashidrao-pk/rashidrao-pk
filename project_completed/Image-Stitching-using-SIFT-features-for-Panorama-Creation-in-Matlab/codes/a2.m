% a2.m
% Main FIle to run the Image Stitching Based on Affine & Homography Based

clc; clear all; close all; workspace;
% Affine Based Image Stitching
output_partA=main_PartA();
disp('Part A Completed ---------->');

% Homography Based Image Stitching
output_partB=main_PartB();
disp('Part B Completed ---------->');

