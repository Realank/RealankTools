//
//  QBTimeTool.h
//  enjoyStroll
//
//  Created by kaixuan on 15/2/10.
//  Copyright (c) 2015年 kaixuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (QB)

- (BOOL) isToday;

- (BOOL) isYesterday;

- (BOOL)isThisYear;

- (NSDateComponents *) dateWithNow;

- (NSDate *)dateWithYMD;

@end
