//
//  HFRequstCenter.m
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "HFRequstCenter.h"
#import <AFHTTPSessionManager.h>


@implementation HFReustConfig

+ (instancetype )appearance
{
    static HFReustConfig *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[HFReustConfig alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        
        NSDictionary *defaultParameters = ((HFReustConfig *)[[self class] appearance]).parameters;
        _parameters = defaultParameters ? defaultParameters : [NSMutableDictionary dictionary];
        
        NSDictionary *defaultSerializer = ((HFReustConfig *)[[self class] appearance]).serializer;
        _serializer = defaultSerializer ? defaultSerializer : [NSMutableDictionary dictionary];
        
    }
    return self;
}
@end

@implementation HFAPIRequst

@end



@implementation HFRequstCenter {
    NSMutableArray *_requstArray;
    dispatch_semaphore_t _lock;
}

- (void)setupData {
    
    _requstArray = [NSMutableArray array];
    _lock = dispatch_semaphore_create(1);
}

- (void)sendRequst:(HFAPIRequst *)requst {
    
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_requstArray addObject:requst];
    dispatch_semaphore_signal(_lock);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    for (NSString *key in requst.config.serializer.allValues) {
        [manager.responseSerializer setValue:requst.config.serializer[key] forKey:key];
    }
    
    switch (requst.requstMethod) {
        case HFRequstMethodGET: {
           requst.task = [manager GET:requst.url parameters:requst.parameters progress:requst.progress success:requst.success failure:requst.failure];
            break;
        }
        case HFRequstMethodPOST: {
            requst.task =  [manager POST:requst.url parameters:requst.parameters progress:requst.progress success:requst.success failure:requst.failure];
            break;
        }
        case HFRequstMethodPUT: {
            requst.task = [manager PUT:requst.url parameters:requst.parameters success:requst.success failure:requst.failure];
            break;
        }
        case HFRequstMethodHEAD: {
            requst.task =  [manager HEAD:requst.url parameters:requst.parameters success:^(NSURLSessionDataTask * _Nonnull task) {
                 !requst.success?:requst.success(task,nil);
             } failure:requst.failure];
            break;
        }
        case HFRequstMethodPATCH: {
            requst.task = [manager PATCH:requst.url parameters:requst.parameters success:requst.success failure:requst.failure];
            break;
        }
        case HFRequstMethodDELETE: {
             requst.task = [manager DELETE:requst.url parameters:requst.parameters success:requst.success failure:requst.failure];
            break;
        }
    }
  
 }


@end
