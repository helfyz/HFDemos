//
//  HFTencentApiCenter.m
//  HFStock
//
//  Created by helfy on 16/8/5.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "HFTencentApiCenter.h"
#import "HFRequstConfigManger.h"
@implementation HFTencentApiCenter


+ (NSString *)cycleStringForCycle:(HFKLineCycle)cycle
{
    NSString *cycleString = @"";
    switch (cycle) {
        case HFKLineCycleDay:
            cycleString = @"day";
            break;
        case HFKLineCycleWeek:
            cycleString = @"week";
            break;
        case HFKLineCycleMonth:
            cycleString = @"moth";
            break;
        default:
            break;
    }
    return cycleString;
}

+ (void)setupConfigs {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        HFRequstConfig *webIfzqConfig = [[HFRequstConfigManger shareConfigManger] configForKey:@"webIfzq"];
        if(webIfzqConfig.server == nil) {
            webIfzqConfig.server = @"http://web.ifzq.gtimg.cn";
            [webIfzqConfig setWorkHandel:^NSError *(id respone) {
                if([respone isKindOfClass:[NSDictionary class]]) {
                    if(![[respone valueForKeyPath:@"code"] integerValue])
                    {
                        return nil;
                    }
                }
                return [NSError errorWithDomain:@"返回数据格式错误" code:NSURLErrorBadServerResponse userInfo:@{@"respone":respone}];
            }];
        }
        
        //
        HFRequstConfig *smartboxConfig = [[HFRequstConfigManger shareConfigManger] configForKey:@"smartbox"];
        if(smartboxConfig.server == nil) {
            smartboxConfig.server = @"http://smartbox.gtimg.cn";
            [smartboxConfig setWorkHandel:^NSError *(id respone) {
                if([(NSString *)respone hasPrefix:@"v_hint"] && [(NSString *)respone length] >20) {
                    return nil;
                }
                return [NSError errorWithDomain:@"参数错误" code:NSURLErrorBadServerResponse userInfo:@{@"respone":respone}];
            }];
        }
        
    });
    
}

    
+ (HFApiRequst *)getKLineForCycle:(HFKLineCycle)cycle stockCode:(NSString *)stockCode count:(NSUInteger)count {
    //  http://web.ifzq.gtimg.cn/appstock/app/fqkline/get?param=sh601567,week,,,99999,hfq  //复权
    //  http://web.ifzq.gtimg.cn/appstock/app/kline/kline 不复权
    if (count == 0) {
        count = 99999;
    }

    HFRequstConfig *config = [[HFRequstConfigManger shareConfigManger] configForKey:@"webIfzq"];
    HFApiRequst *requst = [HFApiRequst requstForMethod:HFRequstMethodGET urlPath:@"appstock/app/fqkline/get" parameters:@{@"param":[NSString stringWithFormat:@"%@,%@,,,%lu,qfq",stockCode,[self cycleStringForCycle:cycle],(unsigned long)count]} config:config];
    requst.mapper = [HFApiDataMapper mapperForKeyPath:[NSString stringWithFormat:@"data.%@",stockCode] modelName:nil];

    return requst;

}

+ (HFApiRequst *)searchSocketForString:(NSString *)searchText {
    
    HFRequstConfig *config = [[HFRequstConfigManger shareConfigManger] configForKey:@"smartbox"];
    HFApiRequst *requst = [HFApiRequst requstForMethod:HFRequstMethodGET urlPath:@"s3" parameters:@{@"q":searchText,@"t":@"all"} config:config];
    requst.responeType = HFResponeTypeString;

    return requst;
}

@end
