//
//  HFRequstCenter.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFReustConfig : NSObject

@property (nonatomic, strong) NSDictionary *defaultParameters;
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

@property (nonatomic, strong) HFReustConfig *config;   //配置

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, assign) HFRequstMethod requstMethod;


@property (nonatomic, strong) void (^progress)(NSProgress * progress);
@property (nonatomic, strong) void (^success)(NSURLSessionDataTask *task, id respone);
@property (nonatomic, strong) void (^failure)(NSURLSessionDataTask *task,NSError *error);

//@property (nonatomic, strong) NSURLSessionDataTask *task;
//@property (nonatomic, weak) id target;  //持有或者 回调的处理的对象 。。设置后 若target被释放后。会自动cancel
@end



@interface HFRequstCenter : NSObject

-(void)sendRequst:(HFAPIRequst *)requst;

@end
