function [ output_args ] = readAndPreprocessImage( input_args, imr, imc)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
input_args = imread(input_args);
input_args = imresize(input_args, [imr imc]);
output_args = input_args;
end

