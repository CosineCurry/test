//
//  PersonViewController.m
//  KTH01
//
//  Created by 帅颖 on 2019/5/6.
//  Copyright © 2019 帅颖. All rights reserved.
//

#import "PersonViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

@interface PersonViewController ()<UITextFieldDelegate>
{
    //全局变量存储服务器传的状态码
    NSString *SMSStr;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *SMSTextField;
@property (weak, nonatomic) IBOutlet UIButton *SMSBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (weak, nonatomic) IBOutlet UIView *phoneNumView;
@property (weak, nonatomic) IBOutlet UIView *SMSView;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phoneNumTextField.delegate = self;
    self.SMSTextField.delegate = self;
    
    [self setup];
    
    [self setNavigationBar];
}

- (void)setup {
    
    //调整phoneNumView的圆角和边框
    self.phoneNumView.layer.masksToBounds = YES;
    self.phoneNumView.layer.cornerRadius = 20.0;
    self.phoneNumView.layer.borderWidth = 1;
    self.phoneNumView.layer.borderColor = [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1].CGColor;
    
    //调整SMSView的圆角和边框
    self.SMSView.layer.masksToBounds = YES;
    self.SMSView.layer.cornerRadius = 20.0;
    self.SMSView.layer.borderWidth = 1;
    self.SMSView.layer.borderColor = [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1].CGColor;
    
    
    //调整SMSBtn为圆角
    self.SMSBtn.layer.cornerRadius = 10;
    //设置渐变
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(0, 0, 89, 22);
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 0);
//    gradientLayer.locations = @[@(0.5),@(1.0)];
//    //[gradientLayer setColors:@[(id)[RGB(200, 187, 255) CGColor], (id)[RGB(200, 187, 255) CGColor]]];
//    gradientLayer.colors = @[(id)[[UIColor blueColor].CGColor, (id)[UIColor redColor].CGColor];

 //   [self.SMSBtn.layer addSublayer:gradientLayer];
    
    //调整loginBtn为圆角
    self.loginBtn.layer.cornerRadius = 20;
    
    //设置行间距为17pt
    NSString *str = @"“校园公益行”由中国青少年学生体质和生长发育健康工程主办,浙江康体汇科技有限公司承办，计划进入每个中小学，为5-17岁儿童青少年进行骨龄、身体成分、脊柱等检测。检查现阶段儿童青少年性早熟，发育迟缓、脊柱侧弯的状况。建立儿童青少年生长发育健康档案，提供针对儿童青少年人群的生长发育健康大数据分析报告，对存在的健康问题提供专业解决方案。";
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4.0;
    paragraphStyle.alignment = NSTextAlignmentJustified;//设置两端对齐
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
    self.explainLabel.attributedText = attributedStr;
    
}

- (void)setNavigationBar {
    self.navigationItem.title = @"登录";
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
}

- (void)cancelAction {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginBtnClick:(id)sender {
    if ([SMSStr isEqualToString:@"000"]) {
        
        [self.view endEditing:YES];
        
        //存储用户信息，下次直接登陆
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"isLogin"];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (![SMSStr isEqualToString:@"000"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆异常！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
    }
}

- (IBAction)getSMSBtnClick:(id)sender {
    //t如果手机号长度不为11位，提示号码不正确
    if (self.phoneNumTextField.text.length != 11) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您所输入的手机号码有误，请重新输入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
    }else {
        //上传数据到服务端
        [self AFPostData];
        
        [self openCountdown];
    }
}

- (void)AFPostData {
    //创建HTTP连接管理对象
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    //服务器url对象
    NSString *pathStr = @"http://192.168.0.122:8088/wx/login/sendcode.do";
    NSString *testStr = @"http://192.168.0.122:8088/sms/login.do";
    
    //上传的数据
    NSString *phoneStr = self.phoneNumTextField.text;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phoneStr forKey:@"mobile"];
    
    //测试数据
    NSString *SMSTextStr = self.SMSTextField.text;
    [param setValue:pathStr forKey:@"code"];
    
    //Post方法上传数据
    [session POST:SMSTextStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"mobilephone num上传成功！ %@", responseObject);
        //解析数据
        NSLog(@"%@", [responseObject valueForKey:@"returnNo"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"mobilephone num上传失败！");
    }];
    
}

//开启倒计时效果
- (void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    self.SMSBtn.alpha = 0.4;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                self.SMSBtn.alpha = 1;
                [self.SMSBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                self.SMSBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.SMSBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                self.SMSBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - UITextFieldDelegate
//手机号长度限制为11位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.phoneNumTextField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    
    else if (textField == self.SMSTextField) {
        if (self.phoneNumTextField.text.length == 0) return NO;
    }
    
    return YES;
}



@end
