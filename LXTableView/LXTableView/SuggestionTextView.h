//
//  SuggestionTextView.h
//  LXTableView
//
//  Created by linxiu on 16/5/6.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DMScreenWidth [UIScreen mainScreen].bounds.size.width
#define DMScreenHeight [UIScreen mainScreen].bounds.size.height
static const CGFloat textViewX = 15;
static const CGFloat textViewY = 90;
static const CGFloat textViewHeight = 500;
static const CGFloat ButtonHeight = 50;

typedef void(^clickButton)(UIButton *commitBtn);

@interface SuggestionTextView : UIView

@property (nonatomic,strong)clickButton buttonAction;

@end
