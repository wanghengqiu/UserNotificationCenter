//
//  TodayViewController.m
//  Widget
//
//  Created by 王恒求 on 2017/4/30.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "LXFrameUtil.h"

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic,retain)UILabel* testLabel;
@property (nonatomic,retain)UIButton* testBtn;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor=[UIColor yellowColor];
    self.preferredContentSize = CGSizeMake(self.view.frame.size.width, 150);
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.lingshengdaquan"];
    NSString* testInfo=[shared objectForKey:@"test"];
    
    self.testLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 30)];
    self.testLabel.font = [UIFont systemFontOfSize:15];
    self.testLabel.text = testInfo;
    [self.view addSubview:self.testLabel];
    
    self.testBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.testLabel.frame)+15, self.view.frame.size.width-40, 40)];
    self.testBtn.center = CGPointMake(self.view.center.x, self.testBtn.center.y);
    self.testBtn.backgroundColor=[UIColor redColor];
    self.testBtn.layer.cornerRadius = 5;
    [self.testBtn setTitle:@"测试页面跳转" forState:UIControlStateNormal];
    [self.testBtn addTarget:self action:@selector(testBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {

    completionHandler(NCUpdateResultNewData);
}

-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)testBtnClicked
{
    [self.extensionContext openURL:[NSURL URLWithString:@"widgetSheme://"] completionHandler:nil];
}

@end
