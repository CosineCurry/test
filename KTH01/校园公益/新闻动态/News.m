//
//  News.m
//  KTH01
//
//  Created by 帅颖 on 2019/5/10.
//  Copyright © 2019 帅颖. All rights reserved.
//

#import "News.h"

@implementation News

+ (instancetype)newsWithDict:(NSDictionary *)dict {
    News *news = [[self alloc] init];
    [news setValuesForKeysWithDictionary:dict];
    return news;
}

@end
