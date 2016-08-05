//
//  HFRequstConfigManger.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFRequstConfig.h"
@interface HFRequstConfigManger : NSObject
+ (instancetype )shareConfigManger;

- (HFRequstConfig *)defaultConfig;   //默认的统一配置

- (HFRequstConfig *)configForKey:(NSString *)key;   //多种config 并存情况下使用

@end
