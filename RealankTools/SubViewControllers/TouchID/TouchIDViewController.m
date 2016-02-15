//
//  TouchIDViewController.m
//  RealankTools
//
//  Created by Realank on 16/2/15.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "TouchIDViewController.h"
#import "TouchIDTool.h"



@interface TouchIDViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)authTouchID:(id)sender {
    [TouchIDTool authTouchIDWithSuccess:^{
        NSLog(@"验证成功");
        self.resultLabel.text = @"验证成功";
    } andFailure:^(NSInteger errorCode, NSString *errorReason) {
        NSLog(@"验证失败：%@",errorReason);
        self.resultLabel.text = errorReason;
    }];
}

@end
