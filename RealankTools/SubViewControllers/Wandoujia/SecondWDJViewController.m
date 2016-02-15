//
//  SecondWDJViewController.m
//  RealankTools
//
//  Created by Realank on 16/2/15.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "SecondWDJViewController.h"

@interface SecondWDJViewController ()

@end

@implementation SecondWDJViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"VC2";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelf)];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setLeftBarButtonItem:item];
    
    //
}

- (void)dismissSelf {
    
    
    if (self.previousNav) {
        self.previousNav.view.transform = CGAffineTransformMakeScale(0.85, 0.85);
        [UIView animateWithDuration:0.5 animations:^{
            self.previousNav.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}




@end
