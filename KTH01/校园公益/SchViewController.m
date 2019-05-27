//
//  SchViewController.m
//  KTH01
//
//  Created by 帅颖 on 2019/5/5.
//  Copyright © 2019 帅颖. All rights reserved.
//

#import "SchViewController.h"
#import "ActivityViewController.h"
#import "NewsViewController.h"

@interface SchViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self setup];
}

- (void)setup {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    //设置cell右边指示样式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    //选中后背景变蓝
//    UIView *selectedBg = [[UIView alloc] init];
//    selectedBg.backgroundColor = [UIColor blueColor];
//    cell.selectedBackgroundView = selectedBg;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"活动介绍";
        cell.imageView.image = [UIImage imageNamed:@"活动介绍"];
    }else {
        cell.textLabel.text = @"新闻动态";
        cell.imageView.image = [UIImage imageNamed:@"新闻动态"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        ActivityViewController *actVc = [[ActivityViewController alloc] init];
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:actVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else {
        NewsViewController *newsVc = [[NewsViewController alloc] init];

        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newsVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

@end
