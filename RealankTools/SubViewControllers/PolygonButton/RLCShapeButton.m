//
//  RLCShapeButton.m
//  duobianxing
//
//  Created by Realank on 16/2/16.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "RLCShapeButton.h"

@interface RLCShapeButton ()

@property(nonatomic, strong) UIBezierPath *path;

@end
@implementation RLCShapeButton

- (instancetype)initWithPath:(UIBezierPath *)path andOrigin:(CGPoint)point{
    if (self = [super initWithFrame:CGRectMake(point.x, point.y, path.bounds.size.width, path.bounds.size.height)]) {
        _path = path;
        CAShapeLayer *shapLayer = [CAShapeLayer layer];
        shapLayer.path = self.path.CGPath;
        shapLayer.strokeColor = [UIColor redColor].CGColor;
        shapLayer.lineWidth = 5;
        shapLayer.fillColor = [UIColor clearColor].CGColor;
//        self.layer.mask = shapLayer;
        [self.layer addSublayer:shapLayer];
    }
    return self;
}

////绘制按钮时添加path遮罩
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//
//}

//覆盖方法，点击时判断点是否在path内，YES则响应，NO则不响应
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL res = [super pointInside:point withEvent:event];
    if (res)
    {
        if ([self.path containsPoint:point])
        {
            return YES;
        }
        return NO;
    }
    return NO;
}

@end
