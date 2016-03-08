//
//  UIImage+Realank.m
//  RealankTools
//
//  Created by Realank on 16/3/8.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "UIImage+Realank.h"

@implementation UIImage (Realank)
/*
 *
 *  压缩图片至目标尺寸
 *
 *  @param maxValue 图片长宽最大值
 *
 *  @return 返回按照self图片的宽、高比例压缩至目标宽、高的UIImage图片
 */
- (UIImage*)resizedImageWithMaxWidthOrHeight:(CGFloat)maxValue {
    CGSize imageSize = self.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (width > height && width > maxValue) {
        height = height * (maxValue / width);
        width = maxValue;
    }else if (height > width && height > maxValue) {
        width = width * (maxValue / height);
        height = maxValue;
    }else {
        return self;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0, 0, width, height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
