function img = dilateRGBImage(new_image)
     dilation_strength = 10;
     R = imclose(new_image(:,:,1),strel('disk',dilation_strength));
     G = imclose(new_image(:,:,2),strel('disk',dilation_strength));
     B = imclose(new_image(:,:,3),strel('disk',dilation_strength));
     img(:,:,1) = R;
     img(:,:,2) = G;
     img(:,:,3) = B;
end