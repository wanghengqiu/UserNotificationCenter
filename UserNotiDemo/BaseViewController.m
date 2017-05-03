//
//  BaseViewController.m
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/10.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@property (nonatomic, strong) UITextView *tipTextView;
@property (nonatomic, strong) UIButton *createNotificationButton;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEX2RGB(@"efeff4");
    [self.view addSubview:self.tipTextView];
//    UIButton* createNotificationButton = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREENH_HEIGHT-64 -64, SCREEN_WIDTH-40, 45)];;
//    [self.view addSubview:createNotificationButton];
//    [createNotificationButton.layer setCornerRadius:22.0f];
//    [createNotificationButton setBackgroundColor:[UIColor redColor]];
//    [createNotificationButton setTitleColor:[UIColor whiteColor]
//                                   forState:UIControlStateNormal];
//    [createNotificationButton setTitleColor:[UIColor lightGrayColor]
//                                   forState:UIControlStateHighlighted];
//    [createNotificationButton setTitle:@"创建Notification"
//                              forState:UIControlStateNormal];
//    [createNotificationButton addTarget:self
//                                 action:@selector(createNotification:)
//                       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.createNotificationButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithTitle:(NSString*)title
{
    self = [[[self class] alloc]init];
    
    self.title = title;
    
    return self;
}

- (UITextView*)tipTextView
{
    if (_tipTextView==nil) {
        _tipTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 150)];
        _tipTextView.font = [UIFont systemFontOfSize:14];
        _tipTextView.textColor = [UIColor blackColor];
    }
    
    return _tipTextView;
}

-(UIButton*)createNotificationButton
{
    if (_createNotificationButton==nil) {
        _createNotificationButton = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREENH_HEIGHT-64 -64, SCREEN_WIDTH-40, 45)];;
        [_createNotificationButton.layer setCornerRadius:22.0f];
        [_createNotificationButton setBackgroundColor:HEX2RGB(@"db3f34")];
        [_createNotificationButton setTitleColor:[UIColor whiteColor]
                                       forState:UIControlStateNormal];
        [_createNotificationButton setTitleColor:[UIColor lightGrayColor]
                                       forState:UIControlStateHighlighted];
        [_createNotificationButton setTitle:@"创建Notification"
                                  forState:UIControlStateNormal];
        [_createNotificationButton addTarget:self
                                     action:@selector(createNotification:)
                           forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _createNotificationButton;
}

#pragma mark - NotificationDes
- (void)createNotification:(UIButton *)sender {
//    NSAssert(NO, @"The method need rewrite, and create diff notification with user.");
}


- (void)buildNotificationDes:(NSString *)desStr {
    NSAssert(YES, @"The method need rewrite, and create diff notification des.");
    [self.tipTextView setText:desStr];
}

@end
