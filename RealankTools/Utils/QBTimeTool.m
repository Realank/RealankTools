//
//  QBTimeTool.m
//  enjoyStroll
//
//  Created by kaixuan on 15/2/10.
//  Copyright (c) 2015年 kaixuan. All rights reserved.
//

#import "QBTimeTool.h"
#import "NSDate+QB.h"
@implementation QBTimeTool

+(NSString *)timeFromTime:(NSDate *)date withExactTime:(BOOL)showExactTime{
//    NSString *data = [self dataWithWebuserData:[NSString stringWithFormat:@"%@",timeStr]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"yyyy.MM.dd HH:mm:ss";
//    NSDate *date = [formatter dateFromString:timeStr];
    if ([date isThisYear]) {
        //如果是今年
        if ([date isToday]) {
            NSDateComponents *cmp = [date dateWithNow];
            if (cmp.hour >=1) {
                formatter.dateFormat = [NSString stringWithFormat:@"%ld小时前",(long)cmp.hour];
            }else if (cmp.minute >=1){
                formatter.dateFormat = [NSString stringWithFormat:@"%ld分钟前",(long)cmp.minute];
            }else{
                formatter.dateFormat = [NSString stringWithFormat:@"刚刚"];
            }
        }else if ([date isYesterday]){
            if (showExactTime) {
                formatter.dateFormat = @"昨天 HH:mm";
            }else {
                return @"昨天";
            }
            
        }else{
            //其他天
            if (showExactTime) {
                formatter.dateFormat = @"MM/dd HH:mm";
            }else {
                formatter.dateFormat = @"MM/dd";
            }
            
        }
    }else{
        if (showExactTime) {
            formatter.dateFormat = @"yy/MM/dd HH:mm";
        }else {
            formatter.dateFormat = @"yy/MM/dd";
        }
        
    }
    NSString *creatDate = [formatter stringFromDate:date];
    return creatDate;
}
+(NSString *)dataWithWebuserData:(NSString *)str{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyy.MM.dd HH:mm:ss";
    NSString *orgStr = [str substringWithRange:NSMakeRange(0, [str length]-3)];
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[orgStr integerValue]];
    NSString *d = [formatter stringFromDate:dt];
    return d;
}
@end
