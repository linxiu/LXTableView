//
//  SuggestionTextView.h
//  LXTableView
//
//  Created by linxiu on 16/5/6.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import <UIKit/UIKit.h>


static const CGFloat ButtonHeight = 50;

typedef void(^clickButton)(UIButton *commitBtn);

@interface SuggestionTextView : UIView

@property (nonatomic,strong)clickButton buttonAction;

@end
