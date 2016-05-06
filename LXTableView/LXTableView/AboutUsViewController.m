//
//  AboutUsViewController.m
//  LXTableView
//
//  Created by linxiu on 16/5/6.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "AboutUsViewController.h"

#define DMScreenWidth [UIScreen mainScreen].bounds.size.width
#define DMScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation AboutUsViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.title = @"关于";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((DMScreenWidth - 112.5)/2.0, 184 , 112.5, 152)];
    logoImageView.image = [UIImage imageNamed:@"company LOGO_icon"];
    
    UILabel *companyName = [[UILabel alloc] initWithFrame:CGRectMake(10, DMScreenHeight - 60,DMScreenWidth - 20, 40)];
    companyName.font = [UIFont systemFontOfSize:15];
    companyName.textAlignment = NSTextAlignmentCenter;
    companyName.textColor = [UIColor grayColor];
    companyName.text = @"深圳市XXXXXXX有限公司.";
    
    [self.view addSubview:logoImageView];
    [self.view addSubview:companyName];
}
@end
