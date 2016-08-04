//
//  HFKlineDrwaModel.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "HFEnumeration.h"
@interface HFKLineDrwaModel : NSObject
//绘制model  kline 需要转换成drawLineModel（实际的坐标） 才能进行绘制

@property (nonatomic,assign) CGPoint maxPoint;
@property (nonatomic,assign) CGPoint minPoint;

@property (nonatomic,assign) CGPoint startPoint;
@property (nonatomic,assign) CGPoint endPoint;

@property (nonatomic,assign) HFKLineType kLineType;

@end
