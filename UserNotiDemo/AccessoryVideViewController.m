//
//  AccessoryVideViewController.m
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/11.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "AccessoryVideViewController.h"

@interface AccessoryVideViewController ()

@end

@implementation AccessoryVideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self buildNotificationDes:@"这是一个新的本地通知，带两个Title，分别为title和subtitle。同时带一个辅助视频。下拉该通知，放大图像并准备播放。创建5秒后触发。建议回到桌面。"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNotification:(UIButton *)sender
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    
    content.title = @"酷音";
    content.subtitle = @"酷音真牛逼";
    content.body = @"下拉放大图片，并准备播放";
    
    NSString *videoPath = [[NSBundle mainBundle]pathForResource:@"notification_video" ofType:@"m4v"];
    if (videoPath) {
        NSError* error;
        UNNotificationAttachment *attatchMent = [UNNotificationAttachment attachmentWithIdentifier:@"videoAttatchMent" URL:[NSURL fileURLWithPath:videoPath] options:nil error:&error];
        if (attatchMent) {
            content.attachments = @[attatchMent];
        }
    }
    
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
