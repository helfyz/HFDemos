//
//  HFAverageDrawModel.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HFAverageDrawModel : NSObject

@property(nonatomic,strong) UIColor *color;   //均线颜色
@property(nonatomic,assign) NSInteger number;  //几日的均线 例： 5日均线为5
@property(nonatomic,strong) NSMutableArray *prices;  //均线的价格集合
@property(nonatomic,strong) NSMutableArray *drawPoints;   //实际坐标点集合
@end
