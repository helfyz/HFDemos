//
//  ViewController.m
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "ViewController.h"
#import "HFRequstConfig.h"
#import "HFNetworking.h"
#import "HFTencentApiCenter.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
//    [self.view addSubview:[UIView appearance]];
//    NSDictionary *ddd = @{@"data":@{@"user":@"1"}};
//   NSLog(@"%@", [ddd valueForKeyPath:@"data.user11"]);
//    
    HFApiRequst *requst = [HFTencentApiCenter getKLineForCycle:HFKLineCycleDay stockCode:@"sh601567" count:0];// [HFTencentApiCenter searchSocketForString:@"XYZCAAA"];
    [[HFNetworking shared] sendRequst:requst progress:NULL
                              success:^(HFApiRequst *requst, id respone) {
                                  NSLog(@"%@",respone);
    }
                              failure:^(HFApiRequst *requst, NSError *error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
