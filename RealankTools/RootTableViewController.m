//
//  RootTableViewController.m
//  RealankTools
//
//  Created by Realank on 16/1/29.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "RootTableViewController.h"

#import "Chinese2PinyinViewController.h"

#import "SysFontTableViewController.h"

NS_ENUM(NSInteger, TOOLS_ENTRY) {
    ChineseToPinyin = 0,
    SysFont,
    EntryMax
};

@interface RootTableViewController ()

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 60;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return EntryMax;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.detailTextLabel.text = @"";
    NSInteger row = indexPath.row;
    switch (row) {
        case ChineseToPinyin:
        {
            cell.textLabel.text = @"汉字转拼音";
        }
            break;
        case SysFont:
        {
            cell.textLabel.text = @"系统字体大全";
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    switch (row) {
        case ChineseToPinyin:
        {
            //汉字转拼音
            Chinese2PinyinViewController *vc = [[Chinese2PinyinViewController alloc]init];
            vc.title = @"汉字转拼音";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SysFont:
        {
            //系统字体大全
            SysFontTableViewController *vc = [[SysFontTableViewController alloc]init];
            vc.title = @"系统字体大全";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}




@end
