//
//  QBTimeTool.h
//  enjoyStroll
//
//  Created by kaixuan on 15/2/10.
//  Copyright (c) 2015年 kaixuan. All rights reserved.
//

#import "NSDate+QB.h"

@implementation NSDate (QB)

- (BOOL)isToday{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    BOOL result = (nowComponents.year ==selfComponents.year && nowComponents.month == selfComponents.month && nowComponents.day ==selfComponents.day);
    return result;
}
- (NSDate *)dateWithYMD{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}
//是否是昨天
- (BOOL)isYesterday{
    NSDate *nowDate =[[NSDate date] dateWithYMD];
    NSDate *selfDate = [self dateWithYMD];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}
// 是否为今年
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    NSDateComponents *dateComponent = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComponent = [calendar components:unit fromDate:self];
    return dateComponent.year == selfComponent.year;
}
- (NSDateComponents *)dateWithNow{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
@end
