//
//  BaseViewController.h
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/10.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "LXFrameUtil.h"

@import UserNotifications;

@interface BaseViewController : UIViewController

- (void)buildNotificationDes:(NSString *)desStr;
- (void)createNotification:(UIButton *)sender;

- (id)initWithTitle:(NSString*)title;

@end
