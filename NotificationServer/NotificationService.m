//
//  NotificationService.m
//  NotificationServer
//
//  Created by 王恒求 on 2017/4/12.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "NotificationService.h"
#import <UIKit/UIKit.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    self.bestAttemptContent.title = self.bestAttemptContent.title;
    
    /** 建议将所有的action都放在controller中，如果不需要自定义的通知界面，并且需要action，那么可以放在这里*/
//    NSMutableArray* actionMutableArray = [[NSMutableArray alloc] initWithCapacity:1];
//    UNNotificationAction* actionA = [UNNotificationAction actionWithIdentifier:@"IdentifierJoinAppA" title:@"这是server中的A" options: UNNotificationActionOptionForeground];
//    UNNotificationAction* actionB = [UNNotificationAction actionWithIdentifier:@"IdentifierJoinAppB" title:@"这是server中的B" options: UNNotificationActionOptionForeground];
//    [actionMutableArray addObjectsFromArray:@[actionA, actionB]];
//    
//    UNNotificationCategory* categoryNotification = [UNNotificationCategory categoryWithIdentifier:@"myNotificationCategory" actions:actionMutableArray intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
//    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:categoryNotification]];
    
    NSDictionary *apsDic = [request.content.userInfo objectForKey:@"aps"];
    
    /** 判断是否需要使用自定义的通知界面*/
    NSString *category = [apsDic objectForKey:@"category"];
    if (category.length != 0) {
        if ([category isEqualToString:@"myNotificationCategory"]) {
            self.bestAttemptContent.categoryIdentifier = @"myNotificationCategory";
        } else {
            self.bestAttemptContent.categoryIdentifier = @"myNotificationCategoryWithInput";
        }
    }
    
    NSString *attachUrl = [apsDic objectForKey:@"image"];
    NSLog(@"%@",attachUrl);
    if (attachUrl.length != 0) {
        [self getAttachMent:attachUrl];
    }

    self.contentHandler(self.bestAttemptContent);
}

-(void)getAttachMent:(NSString*)attachUrl
{
    //下载图片，放到本地
    UIImage * imageFromURL = [self getImageFromURL:attachUrl];
    
    //获取document目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES );
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSLog(@"document path: %@",documentsDirectoryPath);
    
    NSString *localPath = [self saveImage:imageFromURL withFileName:@"MyImage" ofType:@"png" inDirectory:documentsDirectoryPath];
    if (localPath && ![localPath  isEqualToString: @""])
    {
        UNNotificationAttachment *attch= [UNNotificationAttachment attachmentWithIdentifier:@"photo" URL:[NSURL URLWithString:[@"file://" stringByAppendingString:localPath]] options:nil error:nil];
        
        if(attch)
        {
            self.bestAttemptContent.attachments = @[attch];
        }
    }
}

- (UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

//将所下载的图片保存到本地
-(NSString *) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    NSString *urlStr = @"";
    if ([[extension lowercaseString] isEqualToString:@"png"])
    {
        urlStr = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]];
        [UIImagePNGRepresentation(image) writeToFile:urlStr options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] ||
               [[extension lowercaseString] isEqualToString:@"jpeg"])
    {
        urlStr = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]];
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:urlStr options:NSAtomicWrite error:nil];
    } else
    {
        NSLog(@"extension error");
    }
    return urlStr;
}

- (void)serviceExtensionTimeWillExpire {
    self.contentHandler(self.bestAttemptContent);
}

@end
