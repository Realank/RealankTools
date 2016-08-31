//
//  BTConnectionViewController.m
//  RealankTools
//
//  Created by Realank on 16/8/31.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "BTConnectionViewController.h"
#import "BTLEConnectUtil.h"

@interface BTConnectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *btList;
@property (strong, nonatomic) NSArray* btDevicesArray;
@property (strong, nonatomic) NSMutableArray* btConnectedDevicesArray;
@end

@implementation BTConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _btList.delegate = self;
    _btList.dataSource = self;
    
    _btConnectedDevicesArray = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    [[BTLEConnectUtil sharedInstance] startSearchBTDeviceForServices:nil withUpdate:^(NSArray *searchedBTDevices) {
        weakSelf.btDevicesArray = searchedBTDevices;
        [weakSelf.btList reloadData];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CBPeripheral* device = [_btDevicesArray objectAtIndex:indexPath.row];
    UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.textLabel.text = device.name;
    if ([_btConnectedDevicesArray containsObject:device]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_btDevicesArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CBPeripheral* device = [_btDevicesArray objectAtIndex:indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    [[BTLEConnectUtil sharedInstance] tryConnectBTDevice:device WithConnectBlock:^(CBPeripheral *btDevice) {
        [weakSelf.btConnectedDevicesArray addObject:btDevice];
        [weakSelf.btList reloadData];
    } failBlock:^(CBPeripheral *btDevice, NSError *error) {
        if ([weakSelf.btConnectedDevicesArray containsObject:btDevice]) {
            [weakSelf.btConnectedDevicesArray removeObject:btDevice];
            [weakSelf.btList reloadData];
        }
    } disconnectBlock:^(CBPeripheral *btDevice, NSError *error) {
        if ([weakSelf.btConnectedDevicesArray containsObject:btDevice]) {
            [weakSelf.btConnectedDevicesArray removeObject:btDevice];
            [weakSelf.btList reloadData];
        }
    }];
}

- (void)dealloc{
    for (CBPeripheral* device in _btConnectedDevicesArray) {
        [[BTLEConnectUtil sharedInstance] disconnectBTDevice:device];
    }
    
}

@end
