//
//  HFKLineDataModel.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFEnumeration.h"
#import "HFKLineDrwaModel.h"
@interface HFKLineDataModel : NSObject

@property (nonatomic,strong) NSString *dateString;  //时间
@property (nonatomic,strong) NSString *startPrice;  //开盘价
@property (nonatomic,strong) NSString *endPrice;    //收盘价
@property (nonatomic,strong) NSString *maxPrice;    //最高价
@property (nonatomic,strong) NSString *minPrice;    //最低价
@property (nonatomic,strong) NSString *volume;      //交易量

@property (nonatomic,assign) HFKLineType kLineType;


-(HFKLineDrwaModel *)drawModelWithMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice drawSize:(CGSize)size startX:(CGFloat)startX;

@end
