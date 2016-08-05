//
//  HFApiRequst.m
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "HFApiRequst.h"
#import <NSObject+YYModel.h>
@implementation HFApiDataMapper

+ (HFApiDataMapper *)mapperForKeyPath: (NSString *)dataKeyPath modelName:(NSString *)modelName {
    
    HFApiDataMapper *mapper = [[HFApiDataMapper alloc] init];
    mapper.dataKeyPath = dataKeyPath;
    mapper.modelName = modelName;
    return mapper;
}
- (id)handelRespone:(id)respone {
    
    id newRespone = nil;
    
    if ([respone isKindOfClass:[NSDictionary class]]) {
        id data = [respone valueForKeyPath:self.dataKeyPath];
        Class modleClass = NSClassFromString(self.modelName);
        
        if(modleClass && data) {
            if([data isKindOfClass:[NSDictionary class]]) {
                
                return [modleClass modelWithJSON:data];
            }
            if([data isKindOfClass:[NSArray class]]) {
                
                return [NSArray modelArrayWithClass:modleClass json:data];
            }
        }
        newRespone = data;
    }
    else {
        newRespone = respone;
    }
    
    return newRespone;
}
@end

@implementation HFApiRequst

+ (instancetype)requstForMethod:(HFRequstMethod)requstMethod urlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters {  // 不需要config
    
    return [self requstForMethod:requstMethod urlPath:urlPath parameters:parameters config:nil];
}

+ (instancetype)requstForMethod:(HFRequstMethod)requstMethod urlPath:(NSString *)urlPath parameters:(NSDictionary *)parameters config:(HFRequstConfig *)config {
    HFApiRequst *apiRequst = [[HFApiRequst alloc] init];
    apiRequst.requstMethod = requstMethod;
    apiRequst.urlPath = urlPath;
    apiRequst.parameters = parameters;
    apiRequst.config = config;
    
    return apiRequst;
}
- (NSString *)fullUrl {
    
    NSString *fullUrl = self.urlPath?self.urlPath:self.config.server;
    if (self.config) {
        if(self.config.server && self.urlPath) {
            fullUrl = [self.config.server stringByAppendingPathComponent:self.urlPath];
        }
    }
    return fullUrl;
}
- (NSDictionary *)fullParameters {
    
    NSDictionary * fullParameters = self.parameters;
    if (self.config) {
        if(self.config.defaultParameters) {
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:self.config.defaultParameters];
            [tempDic addEntriesFromDictionary:self.parameters];
            fullParameters = tempDic;
        }
    }
    return fullParameters;
}

- (void)setUrlPath:(NSString *)urlPath {
    if([urlPath hasPrefix:@"/"]) {
        urlPath = [urlPath substringFromIndex:1];
    }
    _urlPath = urlPath;
}
@end
