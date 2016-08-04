//
//  HFKLineDataModel.m
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "HFKLineDataModel.h"

@implementation HFKLineDataModel

-(HFKLineDrwaModel *)drawModelWithMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice drawSize:(CGSize)size startX:(CGFloat)startX
{
    CGFloat heightvalue = [self.maxPrice floatValue];// 得到最高价
    CGFloat lowvalue = [self.minPrice floatValue];// 得到最低价
    CGFloat openvalue = [self.startPrice floatValue];// 得到开盘价
    CGFloat closevalue = [self.endPrice floatValue];// 得到收盘价
    
    CGFloat yHeight =   maxPrice - minPrice ; // y的价格高度
    CGFloat yViewHeight = size.height ;// y的实际像素高度
    // 换算成实际的坐标
    
    HFKLineDrwaModel *drawModel = [[HFKLineDrwaModel alloc] init];

    CGFloat heightPointY = yViewHeight * (1 - (heightvalue - minPrice) / yHeight);
    drawModel.maxPoint =  CGPointMake(startX, heightPointY); // 最高价换算为实际坐标值
    CGFloat lowPointY = yViewHeight * (1 - (lowvalue - minPrice) / yHeight);;
    drawModel.minPoint =  CGPointMake(startX, lowPointY); // 最低价换算为实际坐标值
    CGFloat openPointY = yViewHeight * (1 - (openvalue - minPrice) / yHeight);;
    drawModel.startPoint =  CGPointMake(startX, openPointY); // 开盘价换算为实际坐标值
    CGFloat closePointY = yViewHeight * (1 - (closevalue - minPrice) / yHeight);;
    drawModel.endPoint =  CGPointMake(startX, closePointY); // 收盘价换算为实际坐标值
    
    
    drawModel.kLineType = self.kLineType;
    return drawModel;
}
@end
