//
//  HFTencentApiCenter.h
//  HFStock
//
//  Created by helfy on 16/8/5.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFApiRequst.h"
#import "HFEnumeration.h"
@interface HFTencentApiCenter : NSObject

+ (void)setupConfigs;   //最开始配置


+ (HFApiRequst *)getKLineForCycle:(HFKLineCycle)cycle stockCode:(NSString *)stockCode count:(NSUInteger)count;

+ (HFApiRequst *)searchSocketForString:(NSString *)searchText;
@end
