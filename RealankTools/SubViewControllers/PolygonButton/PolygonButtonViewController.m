//
//  PolygonButtonViewController.m
//  RealankTools
//
//  Created by Realank on 16/2/16.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "PolygonButtonViewController.h"
#import "RLCShapeButton.h"

@interface PolygonButtonViewController ()

@end

@implementation PolygonButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBezierPath* path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(100, 50)];
    [path addLineToPoint:CGPointMake(100,100)];
    [path addLineToPoint:CGPointMake(0, 100)];
    [path closePath];
    
    RLCShapeButton *button = [[RLCShapeButton alloc]initWithPath:path andOrigin:CGPointMake(100, 100)];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)click {
    NSLog(@"click");
}


@end
