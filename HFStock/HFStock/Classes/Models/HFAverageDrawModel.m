//
//  HFAverageDrawModel.m
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "HFAverageDrawModel.h"

@implementation HFAverageDrawModel

- (NSMutableArray *)prices {
    
    if(_prices == nil) {
        _prices = [NSMutableArray array];
    }
    return _prices;
}

-(NSMutableArray *)drawPoints {
    
    if(_drawPoints == nil) {
        _drawPoints = [NSMutableArray array];
    }
    return _drawPoints;
}

@end
