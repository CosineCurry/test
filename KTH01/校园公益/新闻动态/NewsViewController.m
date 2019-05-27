//
//  NewsViewController.m
//  KTH01
//
//  Created by 帅颖 on 2019/5/8.
//  Copyright © 2019 帅颖. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"
#import "Masonry.h"
#import "News.h"
#import "NewsInfoViewController.h"

@interface NewsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *newsArray;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NewsViewController

//懒加载
- (NSArray *)newsArray {
    if (!_newsArray) {
        //1.获得plist的全路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"newsPlist.plist" ofType:nil];
        //2.加载数据
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        //3.将dictArray里面的所有字典数据放到新的dictArray数组中，dictArray里面存的是都是NSDictionary数据
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *newsDict in dictArray) {
            [temp addObject:[News newsWithDict:newsDict]];
        }
        // 4.赋值,(可变数组赋值给不可变数组)
        _newsArray = temp;
    }
    return _newsArray;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

}

- (void)setup {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    self.tableView.rowHeight = 114.5;
    
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).equalTo(@0);
        make.left.equalTo(self.view).equalTo(@0);
        make.right.equalTo(self.view).equalTo(@0);
        make.bottom.equalTo(self.view).equalTo(@0);
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsInfoViewController *newsInfoVc = [[NewsInfoViewController alloc] init];

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newsInfoVc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //定义一个重用标识
    static NSString *cellID = @"NewsTableViewCell";
    //去缓存池中取是否有可循环利用的cell
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    //如果缓存池没有可循环利用的cell，自己创建
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil] lastObject];
    }
    
    //设置数据（传递模型）
    cell.news = self.newsArray[indexPath.row];

    return cell;
}

@end
