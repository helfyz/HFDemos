//
//  HFConfigCenter.m
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "HFConfigCenter.h"
#import <HFLibs/UIColor+HFUtils.h>
@implementation HFConfigCenter
+(HFConfigCenter *)shareCenter {
    static HFConfigCenter *center;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[HFConfigCenter alloc] init];
        [center setupData];
    });
    return center;
}

-(void)setupData {
    self.flatColor = [UIColor whiteColor];
    self.hatchingColor = [UIColor hf_ColorWithHex:0x00FFFF alpha:1];
    self.hzsunmoonColor = [UIColor redColor];
}


- (UIColor *)colorForKLineType:(HFKLineType)kLineType {
    UIColor *color = nil;
    switch (kLineType) {
        case HFKLineTypeFlat:
            color = self.flatColor;
            break;
        case HFKLineTypeHatching:
            color = self.hatchingColor;
            break;
        case HFKLineTypeHzsunmoon:
            color = self.hzsunmoonColor;
            break;
            
        default:
            color = [UIColor clearColor];
            break;
    }
    return color;
}

@end
