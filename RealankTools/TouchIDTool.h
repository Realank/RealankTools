//
//  TouchIDTool.h
//  TouchIDDemo
//
//  Created by Realank on 16/1/30.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
//需要导入LocalAuthentication.framework
@interface TouchIDTool : NSObject

+ (void)authTouchIDWithSuccess:(void(^)())successBlock
                    andFailure:(void(^)(NSInteger errorCode, NSString* errorReason))failureBlock;

@end
