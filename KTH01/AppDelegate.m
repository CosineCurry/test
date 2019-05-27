//
//  AppDelegate.m
//  KTH01
//
//  Created by 帅颖 on 2019/5/5.
//  Copyright © 2019 帅颖. All rights reserved.
//

#import "AppDelegate.h"
#import "PerViewController.h"
#import "SerViewController.h"
#import "SchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize isLogin = isLogin;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    SchViewController *sch = [[SchViewController alloc] init];
    UINavigationController *schNav = [[UINavigationController alloc] initWithRootViewController:sch];
    sch.title = @"校园公益";
    sch.tabBarItem.image = [UIImage imageNamed:@"校园公益"];
    
    SerViewController *ser = [[SerViewController alloc] init];
    UINavigationController *serNav = [[UINavigationController alloc] initWithRootViewController:ser];
    ser.title = @"服务中心";
    ser.tabBarItem.image = [UIImage imageNamed:@"服务中心"];
    
    PerViewController *person = [[PerViewController alloc] init];
    UINavigationController *perNav = [[UINavigationController alloc] initWithRootViewController:person];
    person.title = @"个人中心";
    person.tabBarItem.image = [UIImage imageNamed:@"个人中心"];
    
    NSArray *array = [NSArray arrayWithObjects:schNav,serNav,perNav, nil];
   
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    tabBar.viewControllers = array;
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = tabBar;
    [self.window makeKeyAndVisible];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"] == true) {
    /*
     isLogin == true 登陆成功
     */
    }else{
        /*
         未登陆
         */
    }
 
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
