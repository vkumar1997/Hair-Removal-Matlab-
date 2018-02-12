folder = 'C:\Users\vkuma\Documents\images\';
save_folder = 'C:\Users\vkuma\Documents\without_hair\';
filePattern = fullfile(folder,'*.jpg');
srcFiles = dir(filePattern);
numFiles = length(srcFiles);

for k  = 283:numFiles
   fprintf(strcat(int2str(k),strcat('.......',srcFiles(k).name)));
  filename = srcFiles(k).name;
    img = imread(strcat(folder,filename));
    dilated_image = dilateRGBImage(img);
    %figure;
    imshow(img);
    w=waitforbuttonpress;
    if w == 1 %key press%       
         continue
    end
    
    %conversion to grayscale images
    img_g = rgb2gray(img);
   
    
    %bot hat operation to obtain hairs%
    se = strel('disk',4);
    img_g = imadjust(img_g);
    img_g = imsharpen(img_g);
    img_c = imbothat(img_g,se);
  
    
    %invert the image to highlight hairs with a darker background%
    inverted_img_c = 255 - img_c;
    
    %fill unnecssary holes%
     inverted_img_c= imfill(inverted_img_c); 
   %  figure;
     imshow(inverted_img_c);
    
    %convert to binary image%
    image_bw = imbinarize(inverted_img_c,0.97);
    image_bw = imerode(image_bw,strel('disk',2));
    %figure;
    imshow(image_bw);
    
   %use large median filter for pixels with darker background on the original image%
    [Row,Column] = size(image_bw);
    new_image = img;
    for R = 1:Row
        for C = 1: Column
            pixel = image_bw(R,C);
            if pixel == 0
                for RGB = 1:3
                    new_image(R,C,RGB) = dilated_image(R,C,RGB);
                end
            end    
        end
    end
    %figure;
    new_image=imsharpen(new_image);
    imshow(new_image)
    w=waitforbuttonpress;
     if w == 0 %Button click%       
         imwrite(new_image,strcat(save_folder,filename));
         continue
    else %key press%
         continue
    end
end
