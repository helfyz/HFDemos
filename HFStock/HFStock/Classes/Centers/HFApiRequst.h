//
//
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

typedef NS_ENUM(NSInteger,HFResponeType) {
    HFResponeTypeJson = 0,  //default
    HFResponeTypeXML,
    HFResponeTypeString,
    HFResponeTypePropertyList,
    HFResponeTypeImage,
    HFResponeTypeCompound,
    HFResponeTypeData,      //会直接返回data
};

@interface HFApiDataMapper : NSObject
@property (nonatomic, strong) NSString *modelName;       //不设置或者设置错误 则返回dic 或者 Array 。。。
@property (nonatomic, strong) NSString *dataKeyPath;     // 如 @"data.user" 只会返回user 的数据，如设置错误会返回nil

+ (HFApiDataMapper *)mapperForKeyPath: (NSString *)dataKeyPath modelName:(NSString *)modelName;

- (id)handelRespone:(id)respone;

@end

@interface HFApiRequst : NSObject

@property (nonatomic, strong) NSString *urlPath;            // 去掉域名后的相对path  如果不使用config。。urlPath就是完整的url
@property (nonatomic, strong) NSDictionary *parameters;     //参数
@property (nonatomic, assign) HFRequstMethod requstMethod;  //请求方式
@property (nonatomic, assign) HFResponeType responeType;    // 默认json
@property (nonatomic, strong) HFRequstConfig *config;       //若无特殊情况。传入defultConfig 即可。。

@property (nonatomic, strong) HFApiDataMapper *mapper;       //对返回数据的处理。不设置会返回源数据


@property (nonatomic, strong) NSURLSessionDataTask *task;

+ (instancetype)requstForMethod:(HFRequstMethod)requstMethod urlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters;    // 不需要config

+ (instancetype)requstForMethod:(HFRequstMethod)requstMethod urlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters config:(HFRequstConfig *)config;

- (NSString *)fullUrl;

- (NSDictionary *)fullParameters;
@end
