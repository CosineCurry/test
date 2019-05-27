//
//  SerViewController.m
//  KTH01
//
//  Created by 帅颖 on 2019/5/5.
//  Copyright © 2019 帅颖. All rights reserved.
//

#import "SerViewController.h"

@interface SerViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
}

#pragma mark - UITableViewDataSource
//一共多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if(section ==1) {
        return 2;
    }else {
        return 1;
    }
}

//cell
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    //设置cell右边指示样式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    //选中后背景变蓝
//    UIView *selectedBg = [[UIView alloc] init];
//    selectedBg.backgroundColor = [UIColor colorWithRed:187.0/255 green:255.0/255 blue:255.0/255 alpha:1];
//    cell.selectedBackgroundView = selectedBg;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"专家解读";
        cell.imageView.image = [UIImage imageNamed:@"专家解读"];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"预约门诊";
            cell.imageView.image = [UIImage imageNamed:@"预约门诊"];
        } else {
            cell.textLabel.text = @"预约检测";
            cell.imageView.image = [UIImage imageNamed:@"预约检测"];
        }
    }else {
        cell.textLabel.text = @"快速咨询";
        cell.imageView.image = [UIImage imageNamed:@"快速咨询"];
    }
    return cell;
}

@end
