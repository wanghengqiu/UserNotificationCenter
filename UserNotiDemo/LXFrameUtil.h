//
//  LXFrameUtil.h
//  LXFrameWork
//
//  Created by 王恒求 on 16/9/28.
//  Copyright © 2016年 LXCommonTool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LXFrameUtil : NSObject

#define HEX2RGB(string) [LXFrameUtil hex2RGB:string]
+ (UIColor *)hex2RGB:(NSString *)hexColor;

+ (UIImage *)imageofColor:(UIColor *)color;

+ (UIImage *)imageWithName:(NSString *)name;

@end
