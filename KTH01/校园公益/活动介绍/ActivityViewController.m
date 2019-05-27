//
//  ActivityViewController.m
//  KTH01
//
//  Created by 帅颖 on 2019/5/8.
//  Copyright © 2019 帅颖. All rights reserved.
//

#import "ActivityViewController.h"
#import "Masonry.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    //scrollView = self.scrollView;
    scrollView.frame = CGRectMake(0, 78, 375, 609);
    //保持水平方向不回弹
    scrollView.alwaysBounceHorizontal = NO;
    [self.view addSubview:scrollView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 328, 81)];
    titleLabel.text = @"校园公益行“-生长发育健康检测进校园大型公益活动";
    titleLabel.font = [UIFont systemFontOfSize:21.0f];
    titleLabel.numberOfLines = 0;
    [scrollView addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 81, 328, 328)];
    imageView.image = [UIImage imageNamed:@"校园公益行"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:imageView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(23, 409, 328, 237)];
    textLabel.text = @"“校园公益行”由中国青少年学生体质和生长发育健康工程主办，浙江康体汇科技有限公司承办，计划进入每个中小学，为5-17岁儿童青少年进行骨龄、身体成分、脊柱等检测。检查现阶段儿童青少年性早熟、发育迟缓、脊柱侧弯的状况。建立儿童青少年生长发育健康档案，提供针对儿童青少年人群的生长发育健康大数据分析报告，对存在的健康问题提供专业解决方案。";
    textLabel.numberOfLines = 0;
    [scrollView addSubview:textLabel];
    
    scrollView.contentSize = CGSizeMake(375, 646);
    
    //利用Masonry添加约束
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).equalTo(@78);
        make.bottom.equalTo(self.view).equalTo(@0);
        make.left.equalTo(self.view).equalTo(@0);
        make.right.equalTo(self.view).equalTo(@0);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView).equalTo(@0);
        make.centerX.equalTo(scrollView.mas_centerX).equalTo(@0);
        make.width.equalTo(@328);
        make.height.equalTo(@81);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(scrollView.mas_centerX).equalTo(@0);
        make.height.equalTo(@328);
        make.width.equalTo(@328);
        make.top.equalTo(titleLabel.mas_bottom).equalTo(@0);
    }];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(scrollView.mas_centerX).equalTo(@0);
        make.top.equalTo(imageView.mas_bottom).equalTo(@0);
        make.width.equalTo(imageView.mas_width);
        make.height.equalTo(@237);
    }];
}

- (IBAction)bacBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
