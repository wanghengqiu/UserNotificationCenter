//
//  ViewController.m
//  UserNotiDemo
//
//  Created by 王恒求 on 2017/4/10.
//  Copyright © 2017年 王恒求. All rights reserved.
//

#import "ViewController.h"
#import "LXFrameUtil.h"
#import "SimpleLocalViewController.h"
#import "TwoTitleLocalViewController.h"
#import "LaunchImageViewController.h"
#import "SoundAndBadgeViewController.h"
#import "AccessoryImageViewController.h"
#import "AccessoryVideViewController.h"
#import "ActionNoOperationViewController.h"
#import "ActionOperationViewController.h"
#import "CustomContentViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *contentList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Demo";
    self.view.backgroundColor = HEX2RGB(@"efeff4");
    
    _contentList = @[@"简单的本地通知",
                     @"带两个Title的本地通知",
                     @"改变启动图的本地通知",
                     @"带声音的本地通知",
                     @"带图像的本地通知",
                     @"带视频的本地通知",
                     @"不进入应用的按钮",
                     @"进入应用的按钮",
                     @"带文本输入框的按钮",
                     @"自定义的通知栏",];
    
    [self.view addSubview:self.tableView];
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)  ];
    [self.view addSubview:imageView];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES );
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSLog(@"document path: %@",documentsDirectoryPath);
    NSString* urlStr = [documentsDirectoryPath stringByAppendingPathComponent:@"MyImage.png"];
    UIImage* image=[UIImage imageWithContentsOfFile:urlStr];
    imageView.image=image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView*)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        _tableView.rowHeight=50;
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

static NSString* cellIdnetifier = @"CellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdnetifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdnetifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString* titleStr = [self.contentList objectAtIndex:indexPath.row];
    cell.textLabel.text = titleStr;
    cell.textLabel.textColor = HEX2RGB(@"888888");
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    UIViewController* viewController = nil;
    switch (indexPath.row) {
        case 0:
            viewController = [[SimpleLocalViewController alloc] initWithTitle:self.contentList[indexPath.row]];
            break;
        case 1:
            viewController = [[TwoTitleLocalViewController alloc]initWithTitle:self.contentList[indexPath.row]];
            break;
        case 2:
            viewController = [[LaunchImageViewController alloc]initWithTitle:self.contentList[indexPath.row]];
            break;
        case 3:
            viewController = [[SoundAndBadgeViewController alloc]initWithTitle:self.contentList[indexPath.row]];
            break;
        case 4:
            viewController = [[AccessoryImageViewController alloc]initWithTitle:self.contentList[indexPath.row]];
            break;
        case 5:
            viewController = [[AccessoryVideViewController alloc]initWithTitle:self.contentList[indexPath.row]];
            break;
        case 6:
            viewController = [[ActionNoOperationViewController alloc]initWithTitle:self.contentList[indexPath.row]];
            break;
        case 7:
            viewController = [[ActionOperationViewController alloc]initWithTitle:self.contentList[indexPath.row]];
            break;
        case 9:
            viewController = [[CustomContentViewController alloc]initWithTitle:self.contentList[indexPath.row]];
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
