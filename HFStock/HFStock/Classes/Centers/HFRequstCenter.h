//
//  HFRequstCenter.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFReustConfig : NSObject

@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) NSDictionary *serializer;

+ (instancetype)appearance;

@end

typedef NS_ENUM(NSInteger,HFRequstMethod) {
    HFRequstMethodGET = 0,  //default
    HFRequstMethodPOST,
    HFRequstMethodPUT,
    HFRequstMethodHEAD,
    HFRequstMethodPATCH,
    HFRequstMethodDELETE,
};
@interface HFAPIRequst : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) HFRequstMethod requstMethod;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) NSString *modelName;  //返回数据的model类型。设置后。返回该类型数据
@property (nonatomic, strong) HFReustConfig *config;   //配置
@property (nonatomic, strong) void (^progress)(NSProgress * progress);
@property (nonatomic, strong) void (^success)(NSURLSessionDataTask *task, id respone);
@property (nonatomic, strong) void (^failure)(NSURLSessionDataTask *task,NSError *error);

@property (nonatomic, strong) NSURLSessionDataTask *task;

@property (nonatomic, weak) id target;  //持有或者回调的对象 。。设置后 target 被释放后。会自动cancel
@end



@interface HFRequstCenter : NSObject

-(void)sendRequst:(HFAPIRequst *)requst;

@end
