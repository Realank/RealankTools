//
//  NSString+iFore.m
//  qianyan
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 WhiZenBJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+Realank.h"

@implementation NSString (iFore)
+ (id)serializeJsonString:(NSString *)json{
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id ret = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        return nil;
    }
    
    return ret;
}

/**
 *  根据高度，字号，文本获取最终文本size
 *
 *  @param text     文本
 *  @param fontSize 字号
 *
 *  @return size
 */
+(CGSize)textToSize:(NSString *)text fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    CGSize sizeTemp= CGSizeMake(MAXFLOAT, height);
    
    UIFont  *font = [UIFont boldSystemFontOfSize:fontSize];
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    sizeTemp =[text boundingRectWithSize:sizeTemp options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return sizeTemp;
}
/**
 *  根据宽度，字号，文本获取最终文本size
 *
 *  @param text     文本
 *  @param fontSize 字号
 *
 *  @return size
 */
+(CGSize)textToSize:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    CGSize sizeTemp= CGSizeMake(width, 20000.0f);
    
    UIFont  *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    sizeTemp =[text boundingRectWithSize:sizeTemp options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return sizeTemp;
}
/**
 *  根据已定宽度，由字号，文本获取最终文本size
 *
 *  @param text     文本
 *  @param fontSize 字号
 *
 *  @return size
 */
+(CGSize)textToSize:(NSString *)text fontSize:(CGFloat)fontSize
{
    CGSize sizeTemp= CGSizeMake([UIScreen mainScreen].bounds.size.width, 20000.0f);
    
    UIFont  *font = [UIFont boldSystemFontOfSize:fontSize];
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    sizeTemp =[text boundingRectWithSize:sizeTemp options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return sizeTemp;
}
/**
 *  emoji字符串转码
 */

+ (NSString *)replaceEmojiWithString:(NSString *)emojiString{
    if (emojiString.length <= 0) {
        return @"";
    }
    NSError *error;
    NSRegularExpression *orderNumRegExp;
    
    NSString *orderNumRegExpStr = @"\\[emoji:[0-9abcdefABCDEF]{4,8}\\]"; //正则匹配表达式
    orderNumRegExp = [NSRegularExpression regularExpressionWithPattern:orderNumRegExpStr
                                                               options:0 error:&error];
    if (!error) {
        
        NSTextCheckingResult *matchResult = [orderNumRegExp firstMatchInString:emojiString options:0 range:NSMakeRange(0, emojiString.length)];
        
        if (matchResult) {
            NSString* hexStr = [emojiString substringWithRange:matchResult.range];
            NSUInteger hexLength = hexStr.length - 8;
            hexStr = [hexStr substringWithRange:NSMakeRange(7, hexLength)];
            //....处理hexStr的代码放在这里
            //            NSString* replacedString = [self stringFromHexString:];
            hexStr = [hexStr hexValue];
            emojiString = [emojiString stringByReplacingCharactersInRange:matchResult.range withString:hexStr];
            emojiString = [NSString replaceEmojiWithString:emojiString];
        }
    }
    return emojiString;
}

-(NSString*)hexValue{
    NSMutableArray *arr = [NSMutableArray array];
    char *myBuffer = (char *)malloc((int)[self length] / 2 + 1);
    bzero(myBuffer, sizeof(myBuffer));
    for (int i = 0; i < [self length] - 1; i += 4) {
        unsigned int anInt;
        NSString * hexCharStr = [self substringWithRange:NSMakeRange(i, 4)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        [arr addObject:[NSNumber numberWithInt:anInt]];
    }
    UTF32Char inputChar;
    if (arr.count == 1) {
        inputChar = [[arr firstObject] intValue];
    }else if (arr.count == 2){
        UInt32 fex  = [[arr firstObject] intValue];
        UInt32 let = [[arr lastObject] intValue];
        inputChar = 0x10000 + (fex -0xd800)*0x400 + (let-0xdc00);
    }else{
        return @"";
    }
    inputChar = NSSwapHostIntToLittle(inputChar);
    
    NSString *sendStr = [[NSString alloc] initWithBytes:&inputChar length:4 encoding:NSUTF32LittleEndianStringEncoding];
    if (sendStr.length > 0) {
        return sendStr;
    }else{
        return @"";
    }
}

//
//+ (NSString *)replaceEmojiWithString:(NSString *)emojiString{
//    if (emojiString.length <= 0) {
//        return @"";
//    }
//    NSError *error;
//    NSRegularExpression *orderNumRegExp;
//    
//    NSString *orderNumRegExpStr = @"\\[emoji:[0-9abcdefABCDEF]{8}\\]"; //正则匹配表达式
//    orderNumRegExp = [NSRegularExpression regularExpressionWithPattern:orderNumRegExpStr
//                                                               options:0 error:&error];
//    if (!error) {
//        
//        NSTextCheckingResult *matchResult = [orderNumRegExp firstMatchInString:emojiString options:0 range:NSMakeRange(0, emojiString.length)];
//        
//        if (matchResult) {
//            NSString* hexStr = [emojiString substringWithRange:matchResult.range];
//            hexStr = [hexStr substringWithRange:NSMakeRange(7, 8)];
//            //....处理hexStr的代码放在这里
////            NSString* replacedString = [self stringFromHexString:];
//            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//            char *myBuffer = (char *)malloc((int)[hexStr length] / 2 + 1);
//            bzero(myBuffer, [hexStr length] / 2 + 1);
//            for (int i = 0; i < [hexStr length] - 1; i += 4) {
//                unsigned int anInt;
//                NSString * hexCharStr = [hexStr substringWithRange:NSMakeRange(i, 4)];
//                NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
//                [scanner scanHexInt:&anInt];
//                NSLog(@"%d",anInt);
//                [dic setValue:[NSNumber numberWithInt:anInt] forKey:[NSString stringWithFormat:@"%d",i]];
//            }
//            int fex  = [dic[@"0"] intValue];
//            int let = [dic[@"4"] intValue];
//            int testq = 0x10000 + (fex -0xd800)*0x400 + (let-0xdc00);
//            UTF32Char inputChar = testq ;
//            
//            inputChar = NSSwapHostIntToLittle(inputChar);
//            
//            NSString *sendStr = [[NSString alloc] initWithBytes:&inputChar length:4 encoding:NSUTF32LittleEndianStringEncoding];
//            /////
//            emojiString = [emojiString stringByReplacingCharactersInRange:matchResult.range withString:sendStr];
//            emojiString = [NSString replaceEmojiWithString:emojiString];
//        }
//    }
//    return emojiString;
//}

@end
