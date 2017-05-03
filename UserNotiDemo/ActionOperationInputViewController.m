//
//  ActionOperationInputViewController.m
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/12.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "ActionOperationInputViewController.h"

@interface ActionOperationInputViewController ()

@end

@implementation ActionOperationInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildNotificationDes:@"这是一个新的本地通知，带两个Title，分别为title和subtitle。同时带一个辅助图像。下拉该通知，放大图像。有一个点击按钮，点击会进入App。有一个文本输入。创建5秒后触发。建议回到桌面。"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNotification:(UIButton *)sender
{
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = @"酷音";
    content.subtitle = @"酷音真牛逼";
    content.body = @"下拉放大图片";
    content.badge = @1;
    
    NSString* imageFilePath = [[NSBundle mainBundle] pathForResource:@"accessory_icon"
                                                              ofType:@"png"];
    
    if (imageFilePath) {
        UNNotificationAttachment *imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"imageAttachment" URL:[NSURL fileURLWithPath:imageFilePath] options:nil error:nil];
        
        content.attachments = @[imageAttachment];
    }
    
    NSMutableArray *actionArr = [[NSMutableArray alloc]initWithCapacity:5];
    UNNotificationAction* actionC = [UNNotificationAction actionWithIdentifier:@"IdentifierJoinAppC"
                                                                         title:@"进入应用C"
                                                                       options: UNNotificationActionOptionForeground];
    [actionArr addObject:actionC];
    UNTextInputNotificationAction *actionD = [UNTextInputNotificationAction actionWithIdentifier:@"textAction" title:@"文字输入" options:UNNotificationActionOptionForeground textInputButtonTitle:@"发送" textInputPlaceholder:@"写点什么"];
    [actionArr addObject:actionD];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"inputCategory" actions:actionArr intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    [[UNUserNotificationCenter currentNotificationCenter]setNotificationCategories:[NSSet setWithObject:category]];
    content.categoryIdentifier = @"inputCategory";
    
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
