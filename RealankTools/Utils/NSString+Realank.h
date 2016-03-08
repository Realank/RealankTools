//
//  NSString+iFore.h
//  qianyan
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 WhiZenBJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (iFore)
+ (id)serializeJsonString:(NSString *)json;
+(CGSize)textToSize:(NSString *)text fontSize:(CGFloat)fontSize height:(CGFloat)height;
+(CGSize)textToSize:(NSString *)text fontSize:(CGFloat)fontSize width:(CGFloat)width;
+(CGSize)textToSize:(NSString *)text fontSize:(CGFloat)fontSize;
+ (NSString *)replaceEmojiWithString:(NSString *)emojiString;
@end
