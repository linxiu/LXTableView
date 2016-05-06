//
//  ViewController.m
//  LXTableView
//
//  Created by linxiu on 16/5/5.
//  Copyright © 2016年 甘真辉. All rights reserved.
//

#import "ViewController.h"
#import "PictureScrollView.h"
#import "publicTableView.h"
#import "ManagerAddressViewController.h"
#import "AboutUsViewController.h"
#import "SDImageCache.h"
#import "MyCollectViewController.h"
#import "FeedBackViewController.h"


@interface ViewController ()

@property(nonatomic,strong)publicTableView *tableView;
@property(nonatomic,strong) PictureScrollView *jView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人中心";
    [self createInterface];
}
-(void)createInterface{

    self.jView = [[PictureScrollView alloc] initWithFrame:CGRectMake(0,64, DMScreenWidth, 200)];
    
    NSArray *imgUrlArr = @[@"http://www.blisscake.cn/Upload/Product/Show/Source/ps_1507201119031647109.jpg",
                           
                           @"http://www.blisscake.cn/Upload/Product/Show/Source/ps_1507201116215754685.jpg",
                           
                           @"http://www.blisscake.cn/Upload/Product/Show/Source/ps_1507201115524758041.jpg",
                           
                           @"http://www.blisscake.cn/Upload/Product/Show/Source/ps_1507201114495822068.jpg",
                           
                           @"http://www.blisscake.cn/Upload/Product/Show/Source/ps_1507201107522493367.jpg"];
    [self.jView configArr:imgUrlArr];
    
    NSLog(@"%@",imgUrlArr);
    
    [self.view addSubview:self.jView];
    
    
    publicTableView *tableView = [[publicTableView alloc]initWithFrame:CGRectMake(0, _jView.frame.origin.y+_jView.frame.size.height, DMScreenWidth,DMScreenHeight-_jView.frame.origin.y-_jView.frame.size.height)];
    [self.view addSubview:tableView];

    __weak id weakSelf = self;
    
    tableView.cellAction = ^(UITableView *myTableView,NSIndexPath *indexPath){
    
        NSLog(@"----%ld---",(long)indexPath.row);
        if (indexPath.row == 0) {
            ManagerAddressViewController *addressVC = [[ManagerAddressViewController alloc]init];
            
            [self.navigationController pushViewController:addressVC animated:YES];
            
        } else if (indexPath.row == 1){
            
           MyCollectViewController *collectVC = [[MyCollectViewController alloc] init];
            [self.navigationController pushViewController:collectVC animated:YES];
        }else if (indexPath.row == 2){
            
            FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
            [self.navigationController pushViewController:feedBackVC animated:YES];
            
        }else if (indexPath.row == 3){
        
            NSString *tel = @"telprompt://18513583329";//telprompt://%@
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:tel]];
        
        }else if (indexPath.row == 4){
            
            //评价
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1017244804&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
        }else if (indexPath.row == 5){  //清除缓存
         //iOS8以上的版本使用
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存？"preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //清除缓存所需要做的处理
                [self clearFile];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertController addAction:okAction];
            [alertController addAction:cancelAction];
            
        [self presentViewController:alertController animated:YES completion:nil];
            
            
        }else if (indexPath.row == 6){  //关于
        
            AboutUsViewController *aboutVC = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
};

}
#pragma mark ---action---

//1:首先我们计算一下 单个文件的大小
-(long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        
        return [[manager attributesOfItemAtPath:filePath error:nil]fileSize];
    }

    return 0;

}

//2: 遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}

// 清理缓存

- ( void )clearFile

{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
        
    }
    
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject :nil waitUntilDone : YES ];
    
}

- ( void )clearCachSuccess
{
    
    NSLog ( @" 清理成功 " );

    //iOS8以上的版本使用
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"缓存清理完毕"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
       
    }];
   
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
   [self.tableView reloadInputViews];//清理完之后重新导入数据
    
}
@end
