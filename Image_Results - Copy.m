function [] = Image_Results()

load Res
% imwrite(watermark, strcat('./Results/watermark-image.png'))

load(strcat('Im.mat'))
load(strcat('Res.mat'))
% load(strcat('Decrypted_Images.mat'))
for n = 1:2
    for i = 1:5
        Original_Image = Im{n, i};
        Encrypted_Image = Res(n, i).Cipher;
        Decrypted_Image = Res(n,i).Decrypt;
        imwrite(Original_Image, strcat('./Results/Image_Results/Original_Image-', num2str(i), 'Dataset-', num2str(n), '.png'))
        imwrite(Encrypted_Image, strcat('./Results/Image_Results/Encrypted_Image-', num2str(i), 'Dataset-', num2str(n), '.png'))
        imwrite(Decrypted_Image, strcat('./Results/Image_Results/Decrypted_Image-', num2str(i), 'Dataset-', num2str(n), '.png'))
            figure('name', strcat('Original_Image-', num2str(i)))
            subplot(2, 2, 1), imshow(Original_Image);
            title('Original-Image');
            subplot(2, 2, 2), imshow((Encrypted_Image));
            title('Encrypted-Image');
            subplot(2, 2, 3), imshow((Decrypted_Image));  %unit8
            title('Decrypted-Image');
            drawnow
            pause(0.5)
            print('-dtiff','-r300',['./Results/image-result-', num2str(i)])
    end
end
end