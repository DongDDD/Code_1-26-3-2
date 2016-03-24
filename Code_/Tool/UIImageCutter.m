//
//  UIImageCutter.m
//  CutImageView
//
//  Created by admin on 15/10/20.
//  Copyright © 2015年 东. All rights reserved.
//
//#import "Downloader.h"
#import "UIImageCutter.h"
#import "SDWebImageManager.h"


@implementation UIImageCutter


+ (void)cutImageWithUIImageView:(UIImageView *)imageView urlString:(NSString *)urlString{
    
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:urlString] options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //这里可以写加载进度条，例如ProgressView
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        CGFloat scale = image.size.width / imageView.frame.size.width;

        CGFloat height = imageView.frame.size.height * scale;

        CGFloat y = (image.size.height - height) / 2;

        CGFloat width = image.size.width;
        
          
        CGRect rect = CGRectMake(0, y, width, height);

        CGImageRef imageRef=CGImageCreateWithImageInRect([image CGImage],rect);
        UIImage *image1 = [UIImage imageWithCGImage:imageRef];
        
        CGImageRelease(imageRef);
        
        imageView.image = image1;
    }];
}
//只用调用下面这个类方法就可以了，上面的方法不要
+ (void)cutImageAutoWithUIImageView:(UIImageView *)imageView urlString:(NSString *)urlString{

    

    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:urlString] options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //这里可以写加载进度条，例如ProgressView
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        CGFloat scaleImage = image.size.width / image.size.height;
        CGFloat scaleImageView = imageView.frame.size.width / imageView.frame.size.height;
        
        CGFloat scale = 0;
        CGFloat height = 0;
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = 0;
        
        if (scaleImage <= scaleImageView) {

            scale = image.size.width / imageView.frame.size.width;
            
            height = imageView.frame.size.height * scale;
            x = 0;
            
            y = (image.size.height - height) / 2;
           
            width = image.size.width;
        }else{

            scale = image.size.height / imageView.frame.size.height;
            
            width = imageView.frame.size.width * scale;
            
            height = image.size.height;
            y = 0;
            
            x = (image.size.width - width) / 2;
        }
        
        
        CGRect rect = CGRectMake(x, y, width, height);
      
        CGImageRef imageRef=CGImageCreateWithImageInRect([image CGImage],rect);
        UIImage *imageCutted = [UIImage imageWithCGImage:imageRef];
        //释放内存，防止内存泄漏
        CGImageRelease(imageRef);
        
        imageView.image = imageCutted;
    }];
}

@end
