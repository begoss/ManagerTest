//
//  UIImage+Circle.h
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <UIKit/UIKit.h>
struct JMRadius {
    CGFloat topLeftRadius;
    CGFloat topRightRadius;
    CGFloat bottomLeftRadius;
    CGFloat bottomRightRadius;
};
typedef struct JMRadius JMRadius;

static inline JMRadius JMRadiusMake(CGFloat topLeftRadius, CGFloat topRightRadius, CGFloat bottomLeftRadius, CGFloat bottomRightRadius) {
    JMRadius radius;
    radius.topLeftRadius = topLeftRadius;
    radius.topRightRadius = topRightRadius;
    radius.bottomLeftRadius = bottomLeftRadius;
    radius.bottomRightRadius = bottomRightRadius;
    return radius;
}
@interface UIImage (Circle)

+ (UIImage *)circleImageWithNamed:(NSString *)name;
- (UIImage *)scaleImageToSize:(CGSize)size;
- (UIImage *)imageWithCirle;
/**
 *  黑白图片
 *
 *  @return image
 */
- (UIImage*) convertImageToGreyScale;
/**
 *  透明图片
 *
 *  @param alpha 透明度
 *
 *  @return image
 */
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;
- (UIImage *)circleImage;
- (UIImage *)circleImageWithCorner:(CGFloat)corner;
+ (UIImage *)ImageViewColor:(UIColor *)color;
+ (UIImage *)imageWithCorner:(CGFloat )corner size:(CGSize )size bgcolor:(UIColor *)color;
+ (UIImage *)imageWithRoundedCornersAndSize:(CGSize)sizeToFit JMRadius:(JMRadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage withContentMode:(UIViewContentMode)contentMode;


- (UIImage *)imageWithBlur;

- (UIImage *)imageWithWaterMarkText:(NSString *)text;

@end
