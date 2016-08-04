//
//  HFApiRequst.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFRequstConfig.h"
typedef NS_ENUM(NSInteger,HFRequstMethod) {
    HFRequstMethodGET = 0,  //default
    HFRequstMethodPOST,
    HFRequstMethodPUT,
    HFRequstMethodHEAD,
    HFRequstMethodPATCH,
    HFRequstMethodDELETE,
};

@interface HFApiRequst : NSObject

@property (nonatomic, strong) NSString *urlPath;            // 去掉域名后的相对path
@property (nonatomic, strong) NSDictionary *parameters;     //参数
@property (nonatomic, assign) HFRequstMethod requstMethod;  //请求方式

@property (nonatomic, strong) HFRequstConfig *config;    //若无特殊情况。传入defult 即可。。

@property (nonatomic, strong) NSURLSessionDataTask *task;

@end
