//
//  AccessoryImageViewController.m
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/11.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "AccessoryImageViewController.h"

@interface AccessoryImageViewController ()

@end

@implementation AccessoryImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildNotificationDes:@"这是一个新的本地通知，带两个Title，分别为title和subtitle。同时带一个辅助图像。下拉该通知，放大图像。创建5秒后触发。建议回到桌面。"];
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
    content.body= @"来测试一下";
    
    NSString *imageFilePath = [[NSBundle mainBundle] pathForResource:@"accessory_icon" ofType:@"png"];
    if (imageFilePath) {
        NSError *error = nil;
        UNNotificationAttachment *imageAttachMent = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttachMent" URL:[NSURL fileURLWithPath:imageFilePath] options:nil error:&error];
        
        if (imageAttachMent) {
            content.attachments = @[imageAttachMent];
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
