//
//  NewsTableViewCell.m
//  KTH01
//
//  Created by 帅颖 on 2019/5/8.
//  Copyright © 2019 帅颖. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "News.h"

@interface NewsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *newsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

//设置子控件的数据
- (void)setNews:(News *)news
{
    _news = news;
    
    self.iconImageView.image = [UIImage imageNamed:news.image];
    self.newsLabel.text = news.title;
}

@end
