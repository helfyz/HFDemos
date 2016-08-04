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


- (void)sendRequst:(HFApiRequst *)requst
          progress:(void (^)(NSProgress * progress))progress
           success:(void (^)(HFApiRequst *requst, id respone))success
           failure:(void (^)(HFApiRequst *requst, NSError * respone))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    void (^successHandel) (NSURLSessionDataTask * task, id respone) = ^(NSURLSessionDataTask * task, id respone){
       
        NSError*error = requst.config.workHandel(respone);
        if(error) {
            failure(requst,error);
        }
        else {
            success(requst,respone);
        }
    };
    void (^failureHandel) (NSURLSessionDataTask * task, id respone) = ^(NSURLSessionDataTask * task, NSError *error){
         failure(requst,error);
    };


    NSString *fullUrl;
    
    switch (requst.requstMethod) {
        case HFRequstMethodGET: {
            requst.task =[manager GET:fullUrl parameters:requst.parameters progress:progress success:successHandel failure:failureHandel];
            break;
        }
        case HFRequstMethodPOST: {
            requst.task =[manager POST:fullUrl parameters:requst.parameters progress:progress success:successHandel failure:failureHandel];
            break;
        }
        case HFRequstMethodPUT: {
            requst.task =[manager PUT:fullUrl parameters:requst.parameters success:successHandel failure:failureHandel];
            break;
        }
        case HFRequstMethodHEAD: {
            requst.task =[manager HEAD:fullUrl parameters:requst.parameters success:^(NSURLSessionDataTask *task) {
                !successHandel?:successHandel(task,nil);
            } failure:failureHandel];
            break;
        }
        case HFRequstMethodPATCH: {
            requst.task =[manager PATCH:fullUrl parameters:requst.parameters success:successHandel failure:failureHandel];
            break;
        }
        case HFRequstMethodDELETE: {
            requst.task =[manager DELETE:fullUrl parameters:requst.parameters success:successHandel failure:failureHandel];
            break;
        }
    }

}
@end
