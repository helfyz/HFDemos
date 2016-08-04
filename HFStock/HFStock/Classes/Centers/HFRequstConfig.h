//
//  HFRequstConfig.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFRequstConfig : NSObject

@property (nonatomic, strong) NSDictionary *defaultParameters;  //参数配置。比如token，版本号等
@property (nonatomic, strong) NSDictionary *headers;            //head信息
@property (nonatomic, strong) NSString *domain;                 //域名，



@property (nonatomic, strong) NSError * (^workHandel)(id respone);   //业务处理  返回nil 表示符合数据需求



@end
