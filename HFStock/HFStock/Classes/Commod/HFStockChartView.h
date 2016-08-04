//
//  HFStockChartView.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFStockChartView : UIView

@property (nonatomic,assign) CGPoint startPoint; // 线条起点
@property (nonatomic,assign) CGPoint endPoint; // 线条终点

@property (nonatomic,retain) NSArray *kLineDrawArrays; // 每条k线的drawModel
@property (nonatomic,retain) NSArray *averageModels; // 均线model

@property (nonatomic,assign) CGFloat lineWidth; // 线条宽度
@property (nonatomic,assign) CGFloat linePadding; // 线条间隔

@property (nonatomic,assign)CGFloat maxPrice;  //最大价格
@property (nonatomic,assign)CGFloat minPrice;  //最低价格


@end
