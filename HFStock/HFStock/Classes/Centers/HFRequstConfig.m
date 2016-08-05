//
//  HFRequstConfig.m
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "HFRequstConfig.h"

@implementation HFRequstConfig
- (instancetype)init {
    self = [super init];
    if(self) {
        _defaultParameters = [NSMutableDictionary dictionary];
        _headers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setServer:(NSString *)server {
    if([server hasSuffix:@"/"]) {
        server = [server substringToIndex:server.length - 1];
    }
    _server = server;
}
@end
