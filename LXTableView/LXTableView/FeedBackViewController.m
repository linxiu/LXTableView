//
//  FeedBackViewController.m
//  LXTableView
//
//  Created by linxiu on 16/5/6.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "FeedBackViewController.h"
#import "SuggestionTextView.h"


@interface FeedBackViewController ()

@property (nonatomic,strong)SuggestionTextView *suggestTextView;
@property (nonatomic,strong)UIAlertView *alert;
@end
@implementation FeedBackViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"意见反馈";
    self.view.userInteractionEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;//解决iOS7导航栏发生偏移的问题，也就是textView起始光标向下发生偏移了
    _suggestTextView = [[SuggestionTextView alloc]initWithFrame:CGRectMake(textViewX,textViewY, DMScreenWidth-textViewX*2,textViewHeight)];
    [self.view addSubview:_suggestTextView];
    
//    self.suggestTextView.buttonAction = ^(UIButton *commitBtn){
//        
//        NSLog(@"%@hhhhhhh",commitBtn);
//    
//    };
    
}
@end
