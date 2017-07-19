//
//  UIImage+Circle.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "UIImage+Circle.h"
#import <YYWebImage.h>
@implementation UIImage (Circle)


+ (UIImage *)circleImageWithNamed:(NSString *)name {
    UIImage *oldImage = [UIImage imageNamed:name];
    UIGraphicsBeginImageContext(oldImage.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, oldImage.size.width, oldImage.size.height);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [oldImage drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)circleImage {
    
    UIImage * image = [self yy_imageByResizeToSize:CGSizeMake(17*2, 17*2) contentMode:UIViewContentModeScaleToFill];
    return [image yy_imageByRoundCornerRadius:17];
    
}
- (UIImage *)circleImageWithCorner:(CGFloat)corner {
    return [self yy_imageByRoundCornerRadius:corner];
}
- (UIImage *)scaleImageToSize:(CGSize)size {
    /*
     UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
     
     CGFloat x = MAX(size.width / self.size.width, size.height / self.size.height);
     CGSize resultSize = CGSizeMake(x* self.size.width, x* self.size.height);
     
     [self drawInRect:CGRectMake(0, 0, resultSize.width, resultSize.height)];
     
     UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     return finalImage;
     */
    
    if (self.size.width / self.size.height > 1) {
        CGFloat height = size.height;
        CGFloat width = self.size.width * size.height / self.size.height;
        
        size = CGSizeMake(width, height);
    }else {
        CGFloat width = size.width;
        CGFloat height = self.size.height * size.width / self.size.width;
        
        size = CGSizeMake(width, height);
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [self drawInRect:(CGRect){0, 0, size.width, size.height}];
    
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimage;
    
}
- (UIImage *)imageWithCirle {
    
    CGFloat Height = self.size.height * self.scale;
    CGFloat Width = self.size.width * self.scale;
    
    CGRect rect;
    
    if (Height > Width)
        rect = CGRectMake(0, (Height - Width) / 2, Width, Width);
    else
        rect = CGRectMake((Width - Height) / 2, 0, Height, Height);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIImage *newImage = [cropped yy_imageByRoundCornerRadius:self.size.width  < self.size.height?self.size.width:self.size.height];
    
    return newImage;
}

- (UIImage*) convertImageToGreyScale
{
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, self.size.width, self.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [self CGImage]);
    
    // Create bitmap image info from pixel data in current context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    // Release colorspace, context and bitmap information
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    // Return the new grayscale image
    return newImage;
}
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
+ (UIImage *)ImageViewColor:(UIColor *)color {
    CGSize imageSize = CGSizeMake(10, 10);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}
+ (UIImage *)imageWithCorner:(CGFloat )corner size:(CGSize )size bgcolor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0);
    CGContextSetFillColorWithColor(context, color.CGColor);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:corner];
    CGContextAddPath(context, path.CGPath);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outImage;
    
}
+ (UIImage *)imageWithRoundedCornersAndSize:(CGSize)sizeToFit JMRadius:(JMRadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage withContentMode:(UIViewContentMode)contentMode {
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.5, 0.5, sizeToFit.width - 1, sizeToFit.height - 1) cornerRadius:radius.topLeftRadius];
    CGContextAddPath(context, path.CGPath);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    
    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outImage;
}

- (UIImage *)imageWithBlur {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:6.0] forKey:@"inputRadius"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

- (UIImage *)imageWithWaterMarkText:(NSString *)text {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    [self drawInRect:(CGRect){0, 0, self.size.width, self.size.height}];
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0f], NSFontAttributeName,[UIColor blackColor] ,NSForegroundColorAttributeName,nil];
    [text drawAtPoint:(CGPoint){10, self.size.height-22} withAttributes:dic];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
