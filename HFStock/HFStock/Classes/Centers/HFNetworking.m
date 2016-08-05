//
//  HFNetworking.m
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "HFNetworking.h"
#import <AFHTTPSessionManager.h>
#import "HFRequstConfig.h"
@implementation HFNetworking

+ (instancetype )shared
{
    static HFNetworking *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[HFNetworking alloc] init];
    });
    return shared;
}


- (void)sendRequst:(HFApiRequst *)requst
          progress:(void (^)(NSProgress * progress))progress
           success:(void (^)(HFApiRequst *requst, id respone))success
           failure:(void (^)(HFApiRequst *requst, NSError * error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    switch (requst.responeType) {
        case HFResponeTypeJson: {
              manager.responseSerializer    = [AFJSONResponseSerializer serializer];
            break;
        }
        case HFResponeTypeXML: {
              manager.responseSerializer    = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case HFResponeTypeString: {
            manager.responseSerializer      = [AFHTTPResponseSerializer serializer];
           break;
        }
        case HFResponeTypePropertyList: {
              manager.responseSerializer    = [AFPropertyListResponseSerializer serializer];
            break;
        }
        case HFResponeTypeImage: {
              manager.responseSerializer    = [AFImageResponseSerializer serializer];
            break;
        }
        case HFResponeTypeCompound: {
              manager.responseSerializer    = [AFCompoundResponseSerializer serializer];
            break;
        }
        case HFResponeTypeData: {
              manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
            break;
        }
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    if(requst.config) {
      
        for (NSString *key in requst.config.headers.allKeys) {
            [manager.requestSerializer setValue:requst.config.headers[key] forHTTPHeaderField:key];
        }
    }
    
    void (^successHandel) (NSURLSessionDataTask * task, id respone) = ^(NSURLSessionDataTask * task, id respone){
       NSString *responeStr = @"";
        if(requst.responeType == HFResponeTypeString) {
            responeStr = [[NSString alloc] initWithData:respone encoding:NSUTF8StringEncoding];
            respone = responeStr;
        }
        
        //验证
        if(requst.config.workHandel) {
            NSError*error = requst.config.workHandel(respone);
            if(error) {
                failure(requst,error);
                return ;
            }
            
        }
        if(requst.mapper) {
           respone = [requst.mapper handelRespone:respone];
        }

        success(requst,respone);
    
    };
    void (^failureHandel) (NSURLSessionDataTask * task, id respone) = ^(NSURLSessionDataTask * task, NSError *error){
         failure(requst,error);
    };


    NSString *fullUrl = requst.fullUrl;
    
    switch (requst.requstMethod) {
        case HFRequstMethodGET: {
            requst.task =[manager GET:fullUrl parameters:requst.fullParameters progress:progress success:successHandel failure:failureHandel];
            break;
        }
        case HFRequstMethodPOST: {
            requst.task =[manager POST:fullUrl parameters:requst.fullParameters progress:progress success:successHandel failure:failureHandel];
            break;
        }
        case HFRequstMethodPUT: {
            requst.task =[manager PUT:fullUrl parameters:requst.fullParameters success:successHandel failure:failureHandel];
            break;
        }
        case HFRequstMethodHEAD: {
            requst.task =[manager HEAD:fullUrl parameters:requst.fullParameters success:^(NSURLSessionDataTask *task) {
                !successHandel?:successHandel(task,nil);
            } failure:failureHandel];
            break;
        }
        case HFRequstMethodPATCH: {
            requst.task =[manager PATCH:fullUrl parameters:requst.fullParameters success:successHandel failure:failureHandel];
            break;
        }
        case HFRequstMethodDELETE: {
            requst.task =[manager DELETE:fullUrl parameters:requst.fullParameters success:successHandel failure:failureHandel];
            break;
        }
    }

}


@end
