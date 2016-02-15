//
//  TouchIDTool.m
//  TouchIDDemo
//
//  Created by Realank on 16/1/30.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import "TouchIDTool.h"


@implementation TouchIDTool


+ (void)authTouchIDWithSuccess:(void(^)())successBlock
                    andFailure:(void(^)(NSInteger errorCode, NSString* errorReason))failureBlock{
    
    LAContext *context = [[LAContext alloc]init];
    NSError *error = nil;
    __block NSString* errorReason = nil;
    
    BOOL canUserTouchID = [context canEvaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (canUserTouchID) {
        
        [context evaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请输入指纹来验证您的身份" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                //验证成功
                if (successBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        successBlock();
                    });
                    
                }
            }else {
                //验证失败
                switch (error.code) {
                    case kLAErrorAuthenticationFailed:
                        errorReason = @"用户校验失败";
                        break;
                    case kLAErrorUserCancel:
                        errorReason = @"用户取消校验";
                        break;
                    case kLAErrorUserFallback:
                        errorReason = @"用户回退校验（选择使用密码校验）";
                        break;
                    case kLAErrorSystemCancel:
                        errorReason = @"系统取消校验";
                        break;
                    case kLAErrorAppCancel:
                        errorReason = @"应用取消校验";
                        break;
                        
                    case kLAErrorTouchIDLockout:
                        errorReason = @"TouchID校验失败次数过多，已锁定";
                        break;
                        
                    case kLAErrorInvalidContext:
                        errorReason = @"LAContext实例被意外释放";
                        break;
                        
                    default:
                        errorReason = @"验证失败";
                        break;
                }

                if (failureBlock) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        failureBlock(error.code, errorReason);
                    });
                }
            }
        }];
        
    }else {

        switch (error.code) {
            case kLAErrorPasscodeNotSet:
                errorReason = @"用户没有输入密码";
                break;
            case kLAErrorTouchIDNotAvailable:
                errorReason = @"TouchID功能不可用";
                break;
            case kLAErrorTouchIDNotEnrolled:
                errorReason = @"TouchID没有可用指纹";
                break;
            default:
                errorReason = @"不可以使用TouchID";
                break;
        }

        if (failureBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock(error.code, errorReason);
            });
        }
    }
    
    
}


@end
