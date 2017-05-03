//
//  SimpleLocalViewController.m
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/10.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "SimpleLocalViewController.h"

@interface SimpleLocalViewController ()

@end

@implementation SimpleLocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildNotificationDes:@"这是一个最简单的本地通知，只包括最简单的部分。创建5秒后触发。建议回到桌面。"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createNotification:(UIButton *)sender {
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.body = @"Hello,world!";
    
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5
                                                                                                    repeats:NO];
    NSString* requestIdentifer = @"Request";
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:requestIdentifer
                                                                          content:content
                                                                          trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request
                                                           withCompletionHandler:^(NSError * _Nullable error) {
                                                               NSLog(@"Error%@", error);
                                                           }];
}

@end
