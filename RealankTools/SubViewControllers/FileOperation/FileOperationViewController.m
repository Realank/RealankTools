//
//  FileOperationViewController.m
//  RealankTools
//
//  Created by Realank on 16/8/31.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "FileOperationViewController.h"
#import "RLKUserDefault.h"
#import "RACCodingDemo.h"
#import "RACFileManager.h"
#import "RACSQLiteDemo.h"

@interface FileOperationViewController ()

@end

@implementation FileOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)fileManager:(id)sender {
    NSLog(@"home directory:%@",[RACFileManager homeDirectory]);
    
    NSLog(@"document directory:%@",[RACFileManager documentDirectory]);
    
    NSString* cachePath = [RACFileManager cacheDirectory];
    NSLog(@"cache directory:%@",cachePath);
    
    NSLog(@"tmp directory:%@",[RACFileManager tmpDirectory]);
    
    NSString* directoryName = @"myDirectory";
    BOOL createResult = [RACFileManager createDirectoryInPath:cachePath directoryName:directoryName];
    if (createResult) {
        NSLog(@"创建%@成功",directoryName);
    }else {
        NSLog(@"创建%@失败",directoryName);
    }
    
    
    
    NSString* fileName = @"myFile.txt";
    createResult = [RACFileManager createFileInPath:cachePath fileName:fileName];
    if (createResult) {
        NSLog(@"创建%@成功",fileName);
    }else {
        NSLog(@"创建%@失败",fileName);
    }
    NSString* filePath = [cachePath stringByAppendingPathComponent:fileName];
    
    BOOL isDirectory;
    BOOL fileExist = [RACFileManager fileExistInPath:filePath isDirectory:&isDirectory];
    NSLog(@"是否存在：%@  是否是目录：%@",fileExist?@"是":@"否",isDirectory?@"是":@"否");
    
    
    NSString* content = @"hello world";
    //    BOOL writeResult = [RACFileManager writeString:content toPath:filePath];
    //    BOOL writeResult = [RACFileManager writeStringUsingFileHandle:content toPath:filePath];
    BOOL writeResult = [RACFileManager appendStringUsingFileHandle:content toPath:filePath];
    if (writeResult) {
        NSLog(@"写入%@成功",fileName);
    }else {
        NSLog(@"写入%@失败",fileName);
    }
    
    //    content = [RACFileManager readFileFromPath:filePath];
    content = [RACFileManager readFileUsingFileHandleFromPath:filePath];
    NSLog(@"%@",content);
    
    //删除文件
    BOOL deleteResult = [RACFileManager deleteFileInPath:filePath];
    if (deleteResult) {
        NSLog(@"删除%@成功",fileName);
    }else {
        NSLog(@"删除%@失败",fileName);
    }
    //删除文件夹
    NSString *directoryPath = [cachePath stringByAppendingPathComponent:directoryName];
    deleteResult = [RACFileManager deleteFileInPath:directoryPath];
    if (deleteResult) {
        NSLog(@"删除%@成功",directoryName);
    }else {
        NSLog(@"删除%@失败",directoryName);
    }
    
}

- (IBAction)rlkUserDefault:(id)sender {
    
    [[RLKUserDefault standardUserDefault] setObject:@[@1,@2,@3] forKey:@"number"];
    [[RLKUserDefault standardUserDefault] setObject:@[@1,@2,@3] forKey:@"number1"];
    [[RLKUserDefault standardUserDefault] setObject:@[@1,@2,@3] forKey:@"number2"];
    
    [[RLKUserDefault standardUserDefault] synchronize];
    
//    [[RLKUserDefault standardUserDefault] removeAllCache];
}

- (IBAction)secureCoding:(id)sender {
    
    
    RACCodingDemo *demoObj = [[RACCodingDemo alloc] init];

    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver setRequiresSecureCoding:YES];
    [archiver encodeObject:demoObj forKey:NSKeyedArchiveRootObjectKey];
    [archiver finishEncoding];
    
    // now data can use
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [unarchiver setRequiresSecureCoding:YES];
    RACCodingDemo *demoObjNew = [unarchiver decodeObjectOfClass:[RACCodingDemo class] forKey:NSKeyedArchiveRootObjectKey];
    NSLog(@"%@ %ld",demoObjNew.name,(long)demoObjNew.age);
    
}

- (IBAction)sqlite:(id)sender {
    
    [RACSQLiteDemo operation];
}
@end
