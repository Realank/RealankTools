//
//  Chinese2PinyinViewController.m
//  RealankTools
//
//  Created by Realank on 16/1/29.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "Chinese2PinyinViewController.h"

@interface Chinese2PinyinViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UILabel *outputL;

@end

@implementation Chinese2PinyinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)convert:(id)sender {
    NSString* input = self.inputTF.text;
    NSString* output = [self chineseToPinyin:input withSpace:YES];
    self.outputL.text = output;
}


- (NSString *)chineseToPinyin:(NSString *)chinese withSpace:(BOOL)withSpace {
    CFStringRef hanzi = (__bridge CFStringRef)chinese;
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, hanzi);
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinyin = (NSString *)CFBridgingRelease(string);
    if (!withSpace) {
        pinyin = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return pinyin;
}

@end
