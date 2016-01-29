//
//  RootTableViewController.m
//  RealankTools
//
//  Created by Realank on 16/1/29.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "RootTableViewController.h"

#import "Chinese2PinyinViewController.h"

NS_ENUM(NSInteger, TOOLS_ENTRY) {
    ChineseToPinyin = 0,
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
    NSInteger row = indexPath.row;
    switch (row) {
        case ChineseToPinyin:
        {
            cell.textLabel.text = @"汉字转拼音";
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
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}




@end
