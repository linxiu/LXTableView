//
//  PictureScrollView.h
//  LXTableView
//
//  Created by linxiu on 16/5/5.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DMScreenWidth [UIScreen mainScreen].bounds.size.width
#define DMScreenHeight [UIScreen mainScreen].bounds.size.height
@interface PictureScrollView : UIView

@property (nonatomic,retain)NSArray *arrayPic;

// 用这个
- (void)configArr:(NSArray *)arrPic;
@end
