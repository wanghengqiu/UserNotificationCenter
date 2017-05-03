//
//  AppDelegate.m
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/10.
//  Copyright © 2017年 王恒求. All rights reserved.
//

/** 远程通知范本，在ios10中如果需要使用UNUserNotification，需要将mutable-content置为1*/
//{
//    "aps":
//    {
//        "alert":
//        {
//            "title":"hello",
//            "subtitle" : "Session 01",
//            "body":"it is a beautiful day"
//        },
//        "category":"myNotificationCategory",
//        "badge":1,
//        "mutable-content":1,
//        "sound":"default",
//        "image":"https://picjumbo.imgix.net/HNCK8461.jpg?q=40&w=200&sharp=30"
//    }
//}

#import "AppDelegate.h"
#import "ViewController.h"
#import "LXFrameUtil.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController* vc = [[ViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setTintColor:[UIColor whiteColor]];
    [bar setBackgroundImage:[LXFrameUtil imageofColor:HEX2RGB(@"db3f34")] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *dicBar = [NSMutableDictionary dictionary];
    dicBar[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dicBar[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [bar setTitleTextAttributes:dicBar];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    [self registApns];
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.lingshengdaquan"];
    [shared setObject:@"这是来自主程序的数据" forKey:@"test"];
    [shared synchronize];
    
    return YES;
}

-(void)registApns
{
    CGFloat currentSystemVersion = [[[UIDevice currentDevice] systemVersion]floatValue];
    
    [[UIApplication sharedApplication]registerForRemoteNotifications];
    
    if (currentSystemVersion >= 10.0) {
        [[UNUserNotificationCenter currentNotificationCenter]setDelegate:self];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"Notification center Open success");
            } else {
                NSLog(@"Notification center Open failed");
            }
        }];
    } else {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound ) categories:nil]];
    }
//    else {
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                         UIRemoteNotificationTypeAlert |
//                                                         UIRemoteNotificationTypeSound)];
//    }
}

// iOS 10收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
/** 只有在客户端启动的时候才会调用*/
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

//  iOS10特性。点击通知进入App
/** 如果通知界面不是自定义的，那么action的响应是这里处理，如果用到了自定义的通知界面，那么是在对应的自定义界面的controller中的didReceiveNotificationResponse处理*/
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    
    //  UNNotificationResponse 是普通按钮的Response
    NSString* actionIdentifierStr = response.actionIdentifier;
    if (actionIdentifierStr) {

        if ([actionIdentifierStr isEqualToString:@"IdentifierJoinAppA"]) {
            //  do anything
        } else if ([actionIdentifierStr isEqualToString:@"IdentifierJoinAppB"]) {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        }
    }
    
    //  UNTextInputNotificationResponse 是带文本输入框按钮的Response
    if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
        NSString* userSayStr = [(UNTextInputNotificationResponse *)response userText];
        if (userSayStr) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
            });
        }
    }
    
    completionHandler();
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    NSMutableString *mutableToken = [NSMutableString stringWithString:token];
    if ([mutableToken hasPrefix:@"<"]) {
        [mutableToken deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    if ([mutableToken hasSuffix:@">"]) {
        [mutableToken deleteCharactersInRange:NSMakeRange(mutableToken.length - 1, 1)];
    }
    NSLog(@"My token is:%@", mutableToken);

}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}

// 接送push推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Receive remote notification : %@",userInfo);
}

// 接送本地推送
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{

    NSDictionary *userinfo = [notification userInfo];
    NSLog(@"applcation didReceiveLocalNotification : %@",userinfo);

}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"UserNotiDemo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {

                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {

        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
