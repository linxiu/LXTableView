//
//  PictureScrollView.m
//  LXTableView
//
//  Created by linxiu on 16/5/5.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "PictureScrollView.h"
#import "UIImageView+WebCache.h"

#define waitForSwitchImgMaxTime 5  //默认5秒训转图片一次,可以根据需要改变

typedef NS_ENUM(NSInteger,SwitchDirection){
    
    //未轮播
    
    SwitchDirectionNone = -1,
    
    //向右轮播图片
    
    SwitchDirectionRight = 0,
    
    //向左轮播图片
    
    SwitchDirectionLeft = 1,
    
};

@interface PictureScrollView ()<UIScrollViewDelegate>

@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,weak)UIPageControl *pageControl;
//UIScrollView上的三个UIImgaView这里通过3个UIImageView实现无限循环图片轮转
@property(nonatomic,weak)UIImageView *imgView1;

@property(nonatomic,weak)UIImageView *imgView2;

@property(nonatomic,weak)UIImageView *imgView3;

//用保存当前UIPageControl控件显示的当前位置

@property(nonatomic,assign)NSInteger currentPage;
//用于保存当前显示图片在图片arrayPic数组中的索引

@property(nonatomic,assign)NSInteger currentImgIndex;

//SwitchDirection类型，用于保存滑动的方向

@property(nonatomic,assign)SwitchDirection swDirection;

@property(nonatomic,assign)BOOL isDragImgView; //是否手动滑动动图片
@end

@implementation PictureScrollView


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createContentScrollView];
        
        [self createPageControlView];
        
        //默认第一页
        
        _currentPage = 0;
        
        //默认显示第一张图片
        
        _currentImgIndex = 0;
        
        _isDragImgView = NO;
        
        _swDirection = SwitchDirectionNone;
        
    }
    
    return self;
}


#pragma mark 属性

-(void)createContentScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    scrollView.delegate = self;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.shouldGroupAccessibilityChildren = NO;
   
    scrollView.pagingEnabled = YES;
    
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.contentSize = CGSizeMake(DMScreenWidth * 5, 200);
    [self addSubview:scrollView];
    
    _scrollView = scrollView;
    
}
-(void)createPageControlView{
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    pageControl.frame = CGRectMake(0, 0, 80, 20);
    
    pageControl.center = CGPointMake(self.center.x, self.bounds.size.height - 20);
    
    pageControl.backgroundColor = [UIColor redColor];
    
    pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    
    [self addSubview:pageControl];
    
    _pageControl = pageControl;
}

- (void)configArr:(NSArray *)arrPic
{
    self.arrayPic = arrPic;
    NSInteger count = arrPic.count;
    
    if (count <= 0) {
        return;
    }
    
    if (count==1) { //如果只显示一张图片,那就没有轮播情况
        
        UIImageView *imgView = [[UIImageView alloc]init];
        
        imgView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        
        [_scrollView addSubview:imgView];
        
        _pageControl.numberOfPages = 1;
        
        _pageControl.currentPage = 0;
        
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        
        NSURL *imgUrl = [NSURL URLWithString:arrPic[0]];
        
        [imgView sd_setImageWithURL:imgUrl placeholderImage:nil];
        return;
    }
    
    if (count > 1) {
        
        for (int i=0; i< 5; i++) {//这里只使用3个ImgView轮转多张图片，数量2,3,4,5,6...
            
            
            UIImageView *imgView = [[UIImageView alloc] init];
            
//            imgView.frame = CGRectMake(i * 375, 0, 375, 200);
            imgView.frame = CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
            
            imgView.layer.masksToBounds = YES;
            
            
            [self.scrollView addSubview:imgView];
            NSString *urlStr = urlStr = _arrayPic[[self switchToValue:i-1 Count:count]];
            
            NSURL *imgUrl = [NSURL URLWithString:urlStr];
            
            [imgView sd_setImageWithURL:imgUrl placeholderImage:nil];
            if (i == 0)
                
            {
                
                _imgView1 = imgView;
                
            }
            
            else if (i == 1)
                
            {
                
                _imgView2 = imgView;
                
            }
            
            else if (i == 2)
                
            {
                
                _imgView3 = imgView;
                
            }
            
            [_scrollView addSubview:imgView];
            
        }
        
        _pageControl.numberOfPages = count;
        
        _pageControl.currentPage = 0;
        
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3,   self.bounds.size.height);
        
        _currentImgIndex = 0;
        
        [_scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),  ^{
            
            //循环轮转图片
            
            [self switchImg];
            
        });
        
    }
    
}

#pragma mark 各种方法

-(void)switchImg{  //5秒轮播图片
    while (1)
        
    {
        
        [NSThread sleepForTimeInterval:waitForSwitchImgMaxTime];
        
        //如果正在拖拽图片，此次作废
        
        if (_isDragImgView) {
            
            continue;
            
        }
        
        _currentPage = [self switchToValue:_currentPage + 1 Count:_arrayPic.count];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _pageControl.currentPage = _currentPage;
            
            _scrollView.contentOffset = CGPointMake(2 * self.bounds.size.width, 0);
            
            [self reSetImgUrlWithDirection:SwitchDirectionLeft];
            
        });
        
    }
    
    
}
//value对Count取模,并保证为正值

//这里很重要，是实现无限循环的重要的一步，比如现在显示的是第一张图片，_currentImgIndex=0,向左滑动后就显示_currentImgIndex+1张图片，可是_currentImgIndex+1可能回大于_imgUrlArr的数组count，这里取模，其次还要保证为正数，比如，如果向右边滑动是就显示_currentImgIndex-1张图片，
-(NSInteger)switchToValue:(NSInteger)value Count:(NSInteger)count{
    
    NSInteger result = value % count;
    
    return result >=0 ? result : result + count;
    
}
//手动轮播图片
-(void)switchImgByDirection:(SwitchDirection)direction

{
    
    if (direction == SwitchDirectionNone) {
        
        return;
        
    }
    
    [self reSetImgUrlWithDirection:direction];
    
    [_scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    
}
//旋转图片后重新调整3个UIImageView显示的内容
-(void)reSetImgUrlWithDirection:(SwitchDirection)direction{
    
    if (direction == SwitchDirectionRight) {
        
        [_imgView1 sd_setImageWithURL:[NSURL URLWithString:_arrayPic[[self switchToValue:_currentImgIndex - 2 Count:_arrayPic.count]]] placeholderImage:nil];
        
        [_imgView2 sd_setImageWithURL:[NSURL URLWithString:_arrayPic[[self switchToValue:_currentImgIndex - 1 Count:_arrayPic.count]]] placeholderImage:nil];
        
        [_imgView3 sd_setImageWithURL:[NSURL URLWithString:_arrayPic[[self switchToValue:_currentImgIndex Count:_arrayPic.count]]] placeholderImage:nil];
        
        
        _currentImgIndex = [self switchToValue:_currentImgIndex - 1 Count:_arrayPic.count];
        
    }
    
    else if(direction == SwitchDirectionLeft)
        
    {
        
        [_imgView1 sd_setImageWithURL:[NSURL URLWithString:_arrayPic[[self switchToValue:_currentImgIndex Count:_arrayPic.count]]] placeholderImage:nil];
        
        [_imgView2 sd_setImageWithURL:[NSURL URLWithString:_arrayPic[[self switchToValue:_currentImgIndex + 1 Count:_arrayPic.count]]] placeholderImage:nil];
        
        [_imgView3 sd_setImageWithURL:[NSURL URLWithString:_arrayPic[[self switchToValue:_currentImgIndex + 2 Count:_arrayPic.count]]] placeholderImage:nil];
        
        _currentImgIndex = [self switchToValue:_currentImgIndex + 1 Count:_arrayPic.count];
        
    }
    
}
#pragma mark 代理  记住滑动的方向
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    static float newx = 0;
    
    static float oldx = 0;
    newx = _scrollView.contentOffset.x;
    if (newx != oldx) {  //旧的和新的对比
        
        if (newx > oldx) {
            _swDirection = SwitchDirectionLeft;
        }else if(newx < oldx){
            _swDirection = SwitchDirectionRight;
        }
        
        oldx = newx;
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView

{
    
    _isDragImgView = YES;
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{  //结束
    
    if (_swDirection == SwitchDirectionLeft) {  //向左轮播
        
        _currentPage = [self switchToValue:_currentPage + 1 Count:_arrayPic.count];
    }else if(_swDirection == SwitchDirectionRight){
        
        _currentPage = [self switchToValue:_currentPage - 1 Count:_arrayPic.count];
        
    }
    
    _pageControl.currentPage = _currentPage;
    
    if (_swDirection != SwitchDirectionNone) {
        
        [self switchImgByDirection:_swDirection];
        
    }
    
    _isDragImgView = NO;
    
    
}
@end
