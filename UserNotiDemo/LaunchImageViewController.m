//
//  LaunchImageViewController.m
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/11.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "LaunchImageViewController.h"

@interface LaunchImageViewController ()

@end

@implementation LaunchImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildNotificationDes:@"这是一个新的本地通知，带两个Title，分别为title和subtitle。同时在点击进入App的时候更改启动图。创建5秒后触发。建议回到桌面。"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNotification:(UIButton *)sender {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    
    content.title=@"酷音";
    content.subtitle=@"酷音铃声真牛逼";
    content.body=@"改变App的启动图";
    content.launchImageName=@"notification_launch";
    
    UNTimeIntervalNotificationTrigger *trigger=[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    UNNotificationRequest *request=[UNNotificationRequest requestWithIdentifier:@"测试" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter]addNotificationRequest:request withCompletionHandler:nil];
}




@end
