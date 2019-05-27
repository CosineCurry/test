//
//  News.h
//  KTH01
//
//  Created by 帅颖 on 2019/5/10.
//  Copyright © 2019 帅颖. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface News : NSObject

@property (copy, nonatomic) NSString *image;

@property (copy, nonatomic) NSString *title;

+ (instancetype)newsWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
