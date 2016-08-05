//
//  HFNetworking.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFApiRequst.h"
@interface HFNetworking : NSObject

+ (instancetype )shared;

- (void)sendRequst:(HFApiRequst *)requst
          progress:(void (^)(NSProgress * progress))progress
           success:(void (^)(HFApiRequst *requst, id respone))success
           failure:(void (^)(HFApiRequst *requst, NSError * error))failure;
@end
