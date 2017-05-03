//
//  LXFrameUtil.m
//  LXFrameWork
//
//  Created by 王恒求 on 16/9/28.
//  Copyright © 2016年 LXCommonTool. All rights reserved.
//

#import "LXFrameUtil.h"

@implementation LXFrameUtil

+ (UIColor *)hex2RGB:(NSString *)hexColor
{
    NSString *str = nil;
    if([hexColor rangeOfString:@"#"].location!=NSNotFound){
        
        str = [hexColor substringFromIndex:1];
    }else{
        str = hexColor;
    }
    
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[str substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[str substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[str substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}

+ (UIImage*)imageOfColor:(UIColor*)color withSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageofColor:(UIColor *)color{
    return [LXFrameUtil imageOfColor:color withSize:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithName:(NSString *)name
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"LXFrameWork.bundle/%@",name]];
}

@end
