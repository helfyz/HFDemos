//
//  HFConfigCenter.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HFEnumeration.h"

@interface HFConfigCenter : NSObject

@property (nonatomic,strong) UIColor *hatchingColor;   //阴线颜色  默认：绿
@property (nonatomic,strong) UIColor *hzsunmoonColor;  //阳线颜色  默认: 红
@property (nonatomic,strong) UIColor *flatColor;    //横盘颜色  默认: 白色

+(HFConfigCenter *)shareCenter;

- (UIColor *)colorForKLineType:(HFKLineType)kLineType;

@end
