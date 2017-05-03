//
//  NotificationViewController.m
//  NotificationExtern
//
//  Created by 王恒求 on 2017/4/13.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property IBOutlet UILabel *datelabel;
@property IBOutlet UILabel *deslabel;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
    
    self.deslabel.numberOfLines=0;
    self.deslabel.lineBreakMode=NSLineBreakByCharWrapping;
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.title;
    self.datelabel.text=notification.request.content.subtitle;
    self.deslabel.text = notification.request.content.body;
    
    /** 此时定义的UNNotificationActionOptionForeground不知道为何没有效果，在用户点击的时候，通知不会自动消失*/
    NSMutableArray* actionMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
    UNNotificationAction* actionA = [UNNotificationAction actionWithIdentifier:@"IdentifierJoinAppA" title:@"这个是controller中的A" options: UNNotificationActionOptionDestructive];
    UNNotificationAction* actionB = [UNNotificationAction actionWithIdentifier:@"IdentifierJoinAppB" title:@"这个是controller中的B" options: UNNotificationActionOptionForeground];
    [actionMutableArray addObjectsFromArray:@[actionA, actionB]];
    UNNotificationCategory* categoryNotification = [UNNotificationCategory categoryWithIdentifier:@"myNotificationCategory" actions:actionMutableArray intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:categoryNotification]];
}

/** 用户行为反馈，当用户点击下方的action时会被调用*/
- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption option))completion{
    NSString* actionIdentifierStr = response.actionIdentifier;
    if ([actionIdentifierStr isEqualToString:@"IdentifierJoinAppA"]) {
        //  do anything
    } else if ([actionIdentifierStr isEqualToString:@"IdentifierJoinAppB"]) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    //  必须设置completion，否则通知不会消失。
    //  直接让该通知消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion(UNNotificationContentExtensionResponseOptionDismiss);
    });
    //  消失并传递按钮信息给AppDelegate，是否进入App看Att的设置。
//    completion(UNNotificationContentExtensionResponseOptionDismissAndForwardAction);
}

@end
