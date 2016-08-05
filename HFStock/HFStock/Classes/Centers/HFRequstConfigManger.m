//
//  HFRequstConfigManger.m
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "HFRequstConfigManger.h"
@interface  HFRequstConfigManger ()
@property(nonatomic,strong) NSMutableDictionary *configDictionary;
@end

@implementation HFRequstConfigManger {
    dispatch_semaphore_t _lock;
}

+ (instancetype )shareConfigManger
{
    static HFRequstConfigManger *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[HFRequstConfigManger alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        _lock = dispatch_semaphore_create(1);
        _configDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (HFRequstConfig * )defaultConfig {
    return [self configForKey:@"defaultConfig"];
}

- (HFRequstConfig *)configForKey:(NSString *)key {
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    HFRequstConfig *config = self.configDictionary[key];
    if (config == nil) {
        config = [[HFRequstConfig alloc] init];
        self.configDictionary[key] = config;
    }
    dispatch_semaphore_signal(_lock);
   return  config;
}

@end
