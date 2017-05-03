//
//  NotificationViewController.m
//  NotificationWithInput
//
//  Created by 王恒求 on 2017/4/13.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property IBOutlet UIImageView *tipImage;
@property IBOutlet UILabel *commentLabel;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
    self.label.numberOfLines = 0;
    self.label.lineBreakMode = NSLineBreakByCharWrapping;
    
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.lineBreakMode = NSLineBreakByCharWrapping;
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    
    NSMutableArray* actionMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
    UNNotificationAction* actionA = [UNNotificationAction actionWithIdentifier:@"cancelAction" title:@"取消" options: UNNotificationActionOptionDestructive];
    UNTextInputNotificationAction* actionB = [UNTextInputNotificationAction actionWithIdentifier:@"commentAction" title:@"评论" options:UNNotificationActionOptionDestructive textInputButtonTitle:@"Send" textInputPlaceholder:@"What your name."];
    [actionMutableArray addObjectsFromArray:@[actionA, actionB]];
    /** 这里的Identifier必须是我们想要绑定的那个category，和自定义的通知界面的info.plist中的UNNotificationExtension一致*/
    UNNotificationCategory* categoryNotification = [UNNotificationCategory categoryWithIdentifier:@"myNotificationCategoryWithInput" actions:actionMutableArray intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:categoryNotification]];
    
    NSDictionary *apsDic = [notification.request.content.userInfo objectForKey:@"aps"];
    NSString *attachUrl = [apsDic objectForKey:@"image"];
    self.tipImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:attachUrl]]];
}

/** 用户行为反馈，当用户点击下方的action时会被调用*/
- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption option))completion{

    if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
        NSString* userSayStr = [(UNTextInputNotificationResponse *)response userText];
        NSLog(@"%@",userSayStr);
        self.commentLabel.text = [NSString stringWithFormat:@"你的评论是：%@",userSayStr];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

@end
