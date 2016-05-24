//
//  publicTableView.m
//  LXTableView
//
//  Created by linxiu on 16/5/5.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "publicTableView.h"

#define sScreenWidth [UIScreen mainScreen].bounds.size.width
#define sScreenHeight [UIScreen mainScreen].bounds.size.height

static CGFloat KcellHeight = 50.0f;
static CGFloat ktableViewHeight = 350;

@interface publicTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property(nonatomic ,assign)CGRect myTableViewFrame;//大小

@end

@implementation publicTableView


+(CGFloat)cellHeight
{
    return KcellHeight;
}

-(id)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    
    
    if (self) {
        
        self.myTableViewFrame = frame;
        [self _initVars];
    }
    
    return self;
}
#pragma mark --- 方法---
-(void)_initVars{
    
    _imageNameArr = @[@"List_Delivery address_icon",@"List_Select Park_icon",@"List_Feedback_icon",@"List_Contact customer service_icon",@"List_Praise_icon",@"List_Change password_icon",@"List_About_icon"];
    
    _ImgTextArr = @[@"送餐地址",@"我的收藏",@"意见反馈",@"联系客服",@"鼓励一下!",@"清除缓存",@"关于"];
    
    
    [self addSubview:self.tableView];
}

-(CGFloat)tableViewHeight
{
    if (self.frame.origin.y<64) {
        return 64.0f;
    }else {
        return self.myTableViewFrame.origin.y;
    }
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,sScreenWidth , ktableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor whiteColor];
        
        _tableView.scrollEnabled = NO; //设置cell不能被滑动
          [self setExtraCellLineHidden:_tableView]; //去掉tableview底部多余的分割线
        
    }
    return _tableView;
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_tableView setTableFooterView:view];
 
}
-(void)setDataSource:(NSMutableArray *)dataSource
{
    _imageNameArr = dataSource;

    [self.tableView reloadData];

}

#pragma mark --- delegate ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ImgTextArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"tableViewCell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    cell.textLabel.text= _ImgTextArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[_imageNameArr objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KcellHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

        self.cellAction(tableView,indexPath);
    
}
@end
