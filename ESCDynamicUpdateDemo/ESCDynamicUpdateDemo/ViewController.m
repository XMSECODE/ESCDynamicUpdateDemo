//
//  ViewController.m
//  ESCDynamicUpdateDemo
//
//  Created by xiang on 2018/11/30.
//  Copyright © 2018 xiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSBundle* boundle;

@property(nonatomic,copy)NSString* libPath;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //iOS 10后真机不可用,模拟器可用
    
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"%@",libPath);
    
    //    ESCViewControllerDynamic.framework
    libPath = [NSString stringWithFormat:@"%@/%@",libPath,@"ESCViewControllerDynamic.framework"];
    
    self.libPath = libPath;

}



- (IBAction)push:(id)sender {
   
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:self.libPath];
    if (exists == NO) {
        NSLog(@"动态库不存在");
        return;
    }
    
    NSBundle *libBundle = [NSBundle bundleWithPath:self.libPath];
    if (libBundle == nil) {
        NSLog(@"生成bundle失败");
        return;
    }
    
    self.boundle = libBundle;
    NSError *error;
    [libBundle loadAndReturnError:&error];
    NSLog(@"eooro ==== %@=======",error);
    BOOL loadResult = [libBundle load];
    if (loadResult == NO) {
        NSLog(@"已经load");
    }else {
        NSLog(@"加载成功");
    }
    Class vClass = [libBundle classNamed:@"ESCViewController"];
    
    if (vClass == nil) {
        NSLog(@"加载类失败");
    }else{
        UIViewController *viewController = [[vClass alloc] init];
        if (viewController) {
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
    
}

@end
