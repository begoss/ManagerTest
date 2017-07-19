//
//  GYCircleView.m
//  MaxJia
//
//  Created by 郭源 on 16/2/25.
//  Copyright © 2016年 dotamax. All rights reserved.
//

#import "GYCircleView.h"

@implementation GYCircleView

- (void)setOffsetY:(CGFloat)offsetY {
    if (offsetY < 0) {
        _offsetY = offsetY;
    }else {
        _offsetY = 0;
    }
    
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.offsetY = 0;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, self.circleColor.CGColor);
    CGContextSetLineWidth(context, self.circleLineWidth);
    
    static CGFloat radius = 13;
    static CGFloat startAngle = 0;
    CGFloat endAngle = (ABS(_offsetY) / 51) * M_PI + startAngle;
    
    CGContextAddArc(context, CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2, radius, startAngle, endAngle, 0);
    
    CGContextDrawPath(context, kCGPathStroke);
}

@end
