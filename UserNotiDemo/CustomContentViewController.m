//
//  CustomContentViewController.m
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/12.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "CustomContentViewController.h"

@interface CustomContentViewController ()

@end

@implementation CustomContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildNotificationDes:@"这是一个新的本地通知。自定义通知栏，带两个Title，分别为title和subtitle。同时带一个辅助图像。下拉该通知。创建5秒后触发。建议回到桌面。"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNotification:(UIButton *)sender
{
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = @"来参加我的聚会";
    content.subtitle = @"4月30号";
    content.body = @"4月30号我在我家举行了一个盛大的party，你愿意来参加吗？";

    content.categoryIdentifier = @"myNotificationCategory";
    
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
