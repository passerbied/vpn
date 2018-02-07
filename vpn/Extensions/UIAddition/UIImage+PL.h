//
//  UIImage+PL.h
//  Apollo
//
//  Created by xhan on 10-8-27.
//  Copyright 2010 wangguoyu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(PL)


////////////////////////////////////////////////////////////////////////////////
// Resize


- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;

////////////////////////////////////////////////////////////////////////////////
// Rounder Corner

- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

////////////////////////////////////////////////////////////////////////////////
// Alpha

- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;


+ (UIImage*)imageWithColor:(UIColor*)color bounds:(CGSize)size;
@end


