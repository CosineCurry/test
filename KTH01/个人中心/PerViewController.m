//
//  PerViewController.m
//  KTH01
//
//  Created by 帅颖 on 2019/5/8.
//  Copyright © 2019 帅颖. All rights reserved.
//

#import "PerViewController.h"
#import "PersonViewController.h"

@interface PerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation PerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setHeadImageView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}

- (void)setHeadImageView {
    self.headImageView.userInteractionEnabled = YES;
    
    self.headImageView.layer.cornerRadius = 64.0f;
    
    [self.headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTapAction)]];
}

- (void)doTapAction {
    PersonViewController *loginVc = [[PersonViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

@end
