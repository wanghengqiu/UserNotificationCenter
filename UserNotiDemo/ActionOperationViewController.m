//
//  ActionOperationViewController.m
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/11.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "ActionOperationViewController.h"

@interface ActionOperationViewController ()

@end

@implementation ActionOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildNotificationDes:@"这是一个新的本地通知，带两个Title，分别为title和subtitle。同时带一个辅助图像。下拉该通知，放大图像。有两个点击按钮，点击会进入App。创建5秒后触发。建议回到桌面。"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNotification:(UIButton *)sender {
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = @"酷音";
    content.subtitle = @"酷音真牛逼";
    content.body = @"下拉放大图片";
    content.badge = @1;
    
    NSString* imageFilePath = [[NSBundle mainBundle] pathForResource:@"accessory_icon"
                                                              ofType:@"png"];
    if (imageFilePath) {
        NSError* error = nil;
        
        UNNotificationAttachment *imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttachment" URL:[NSURL fileURLWithPath:imageFilePath] options:nil error:&error];
        if (imageAttachment) {
            //  这里设置的是Array，但是只会取lastObject
            content.attachments = @[imageAttachment];
            
        }
    }
    
    NSMutableArray* actionMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
    UNNotificationAction* actionA = [UNNotificationAction actionWithIdentifier:@"IdentifierJoinAppA" title:@"进入应用A-保留badge" options: UNNotificationActionOptionForeground];
    UNNotificationAction* actionB = [UNNotificationAction actionWithIdentifier:@"IdentifierJoinAppB" title:@"进入应用B-清除badge" options: UNNotificationActionOptionForeground];
    [actionMutableArray addObjectsFromArray:@[actionA, actionB]];
    
    if ([actionMutableArray count] > 1) {
        UNNotificationCategory* categoryNotification = [UNNotificationCategory categoryWithIdentifier:@"categoryOperationAction"actions:actionMutableArray intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:categoryNotification]];
        content.categoryIdentifier = @"categoryOperationAction";
    }
    
    
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    NSString* requestIdentifer = @"Request";
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {NSLog(@"Error%@", error); }];
}

@end
