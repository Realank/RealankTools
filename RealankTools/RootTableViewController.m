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

#import "WandoujiaViewController.h"

#import "TouchIDViewController.h"
#import "PolygonButtonViewController.h"

NS_ENUM(NSInteger, TOOLS_ENTRY) {
    ChineseToPinyin = 0,
    SysFont,
    SeguePracLineWandoujia,
    TouchID,
    PolygonBtn,
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
        case SeguePracLineWandoujia:
        {
            cell.textLabel.text = @"豌豆荚一览转场";
        }
            break;
        case TouchID:
        {
            cell.textLabel.text = @"Touch ID";
        }
            break;
        case PolygonBtn:
        {
            cell.textLabel.text = @"多边形按键";
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
        case SeguePracLineWandoujia:
        {
            //豌豆荚转场
            WandoujiaViewController *vc = [[WandoujiaViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case TouchID:
        {
            //TouchID
            TouchIDViewController *vc = [[TouchIDViewController alloc]init];
            vc.title = @"Touch ID";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case PolygonBtn:
        {
            //多边形按键
            PolygonButtonViewController *vc = [[PolygonButtonViewController alloc]init];
            vc.title = @"多边形按键";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}




@end
