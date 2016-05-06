//
//  SuggestionTextView.m
//  LXTableView
//
//  Created by linxiu on 16/5/6.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "SuggestionTextView.h"


@interface SuggestionTextView ()<UITextViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)UITextView *suggestTextView;
@property (nonatomic,strong)UIButton *commitBtn;
@property (nonatomic,strong)UIAlertView *alert;

@end

@implementation SuggestionTextView

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        _alert = [[UIAlertView alloc] initWithTitle:@"提交成功！" message:@"感谢您的宝贵意见，我们会尽快完善产品" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [self createSuggestTextView];
        [self createBtn];
    }
    return self;
}

-(void)createSuggestTextView{

    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height / 8 * 7+5)];

    
    textView.layer.borderWidth = 0.5;
    textView.layer.borderColor = [[UIColor grayColor] CGColor];
    textView.layer.cornerRadius = 5;
    textView.delegate = self;
    textView.scrollEnabled = NO;
    textView.backgroundColor = [UIColor whiteColor];
    [self addSubview:textView];
    _suggestTextView = textView;
    
    UIPanGestureRecognizer  *panGestureRecognizer= [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestures:)];
    panGestureRecognizer.minimumNumberOfTouches = 1;
    panGestureRecognizer.maximumNumberOfTouches = 5;
    [_suggestTextView addGestureRecognizer:panGestureRecognizer];

}
-(void)createBtn{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, self.frame.size.height / 8 * 7+20+5, self.frame.size.width, self.frame.size.height / 8);
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
     _commitBtn = button;
    button.userInteractionEnabled = YES;
    [button addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_commitBtn];
   
}
#pragma mark ---action----
-(void)commitAction:(UIButton *)btn{
    
    NSLog(@"hhaha%@hahahha",btn);
    
        self.buttonAction = ^(UIButton *commitBtn){
    
            NSLog(@"%@hhhhhhh",commitBtn);
    
        };

    if (_suggestTextView.text.length==0) {
        [[[UIAlertView alloc] initWithTitle:@"提交失败！" message:@"您还未键入任何内容。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }else
    {
        [_alert show];
    }
}
//收起键盘
-(void)handlePanGestures:(UIPanGestureRecognizer *)sender{
    
    [self endEditing:YES];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _alert)
    {
        if (buttonIndex == 0)
        {
            return;
        }
    }
}
#pragma mark ---delegate----
-(void)textViewDidEndEditing:(UITextView *)textView{

//    [self.suggestTextView resignFirstResponder];
}
@end
