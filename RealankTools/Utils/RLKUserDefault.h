//
//  RLKUserDefault.h
//  CustomUserDefault
//
//  Created by Realank on 16/8/31.
//  Copyright © 2016年 Realank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLKUserDefault : NSObject

+(instancetype) standardUserDefault;
+(instancetype) customUserDefaultWithDomain:(NSString*)domain;

// clue for improper use (produces compile time error)
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

- (id)objectForKey:(NSString *)defaultName;
- (BOOL)setObject:(id)value forKey:(NSString *)defaultName;
- (void)removeObjectForKey:(NSString *)defaultName;
- (void)removeAllCache;
- (void)synchronize;
@end
