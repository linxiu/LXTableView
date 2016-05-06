//
//  publicTableView.h
//  LXTableView
//
//  Created by linxiu on 16/5/5.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickTableViewCell)(UITableView *myTableView,NSIndexPath *indexPath);

@interface publicTableView : UIView


+(CGFloat)cellHeight;

@property (nonatomic,strong)NSArray *imageNameArr;


@property (nonatomic,strong)NSArray *ImgTextArr;

//点击cell触发的方法
@property (nonatomic,strong)clickTableViewCell cellAction;
@end
