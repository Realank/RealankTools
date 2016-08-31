//
//  RLKUserDefault.m
//  CustomUserDefault
//
//  Created by Realank on 16/8/31.
//  Copyright © 2016年 Realank. All rights reserved.
//

#import "RLKUserDefault.h"

#if 1
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

@interface RLKUserDefault ()

@property (nonatomic, strong) NSString* plistFilePath;
@property (nonatomic, strong) NSMutableDictionary* cacheDictionary;
@property (nonatomic, strong) NSDate* lastSyncDate;
@property (nonatomic, assign) BOOL isDirty;
@property (nonatomic, strong) NSTimer* flushTimer;
@end

@implementation RLKUserDefault

+(instancetype) standardUserDefault{
    return [self customUserDefaultWithDomain:@"standard"];
}
+(instancetype) customUserDefaultWithDomain:(NSString*)domain{
    static dispatch_once_t pred;
    static id shared = nil; //设置成id类型的目的，是为了继承
    dispatch_once(&pred, ^{
        shared = [[super alloc] initUniqueInstanceWithDomain:domain];
    });
    return shared;
}


-(instancetype) initUniqueInstanceWithDomain:(NSString*)domain {
    
    if (self = [super init]) {
        domain = [@"com.realank." stringByAppendingString:domain];
        NSString* cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        _plistFilePath = [[[cachePath stringByAppendingPathComponent:@"realankPreference"] stringByAppendingPathComponent:domain] stringByAppendingPathComponent:@"Preference.plist"];
        _cacheDictionary = [[NSDictionary dictionaryWithContentsOfFile:_plistFilePath] mutableCopy];
        if (!_cacheDictionary) {

            _cacheDictionary = [NSMutableDictionary dictionary];
            
        }
    }
    
    return self;
}

- (id)objectForKey:(NSString *)defaultName{
    return [_cacheDictionary objectForKey:defaultName];
}

- (BOOL)setObject:(id)value forKey:(NSString *)defaultName{
    @synchronized (self) {
        if ([self canStoreObject:value]) {
            [_cacheDictionary setObject:value forKey:defaultName];
            [self updateROM];
            return YES;
        }else{
            return NO;
        }
    }
    
    
}

- (void)removeObjectForKey:(NSString *)defaultName{
    [_cacheDictionary removeObjectForKey:defaultName];
    [self updateROM];
}


- (BOOL)canStoreObject:(id)object{
    
    if ([object isKindOfClass:[NSNumber class]]) {
        return YES;
    }else if ([object isKindOfClass:[NSString class]]) {
        return YES;
    }else if ([object isKindOfClass:[NSDate class]]) {
        return YES;
    }else if ([object isKindOfClass:[NSData class]]) {
        return YES;
    }else if ([object isKindOfClass:[NSDictionary class]]) {
        for (NSString* key in [(NSDictionary*)object allKeys]) {
            id value = [object objectForKey:key];
            if (![self canStoreObject:value]) {
                return NO;
            }
        }
        return YES;
    }else if ([object isKindOfClass:[NSArray class]]) {
        for (id value in object) {
            if (![self canStoreObject:value]) {
                return NO;
            }
        }
        return YES;
    }
    
    return NO;
}

- (void)removeAllCache{
    if (_flushTimer) {
        [_flushTimer invalidate];
        _flushTimer = nil;
    }
    [[NSFileManager defaultManager] removeItemAtPath:[_plistFilePath stringByDeletingLastPathComponent] error:nil];
    _cacheDictionary = [NSMutableDictionary dictionary];
    _lastSyncDate = nil;
    _isDirty = NO;
    
}

- (void)updateROM{
    
    DLog(@"-update rom");
    self.isDirty = YES;
    if (!_lastSyncDate) {
        [self synchronize];
    }else if([[NSDate date] timeIntervalSinceDate:_lastSyncDate] > 5){
        [self synchronize];

    }else{
        if (!_flushTimer) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _flushTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(synchronize) userInfo:nil repeats:NO];
            });
            
        }
        
    }
    
    
}

- (void)synchronize{
    
    
    
    if (self.isDirty ) {
        DLog(@"---sync in rom");
        if(![[NSFileManager defaultManager] fileExistsAtPath:_plistFilePath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:[_plistFilePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        [self.cacheDictionary writeToFile:_plistFilePath atomically:YES];
        self.isDirty  = NO;
    }
    _lastSyncDate = [NSDate date];
    if (_flushTimer) {
        [_flushTimer invalidate];
        _flushTimer = nil;
    }

}

@end
