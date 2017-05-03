//
//  SoundAndBadgeViewController.m
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/11.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "SoundAndBadgeViewController.h"

@interface SoundAndBadgeViewController ()

@end

@implementation SoundAndBadgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildNotificationDes:@"这是一个简单的本地通知，带两个Title，分别为title和subtitle。同时带有sound和badge。badge在iOS10中得到保留，。创建5秒后触发。建议回到桌面。"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNotification:(UIButton *)sender
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title=@"酷音";
    content.subtitle=@"酷音真牛逼";
    content.body=@"来测试一下";
    content.sound=[UNNotificationSound soundNamed:@"notification_sound"];
    
    UNTimeIntervalNotificationTrigger *triggle = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    UNNotificationRequest *request=[UNNotificationRequest requestWithIdentifier:@"测试" content:content trigger:triggle];
    
    [[UNUserNotificationCenter currentNotificationCenter]addNotificationRequest:request withCompletionHandler:nil];
}

@end
