function valueChannel=extractValueChannel(color_image)
valueChannel = rgb2hsv(color_image);
valueChannel = valueChannel(:,:,3) * 255;
valueChannel = uint8(valueChannel);
end