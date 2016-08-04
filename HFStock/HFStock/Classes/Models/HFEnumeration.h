//
//  HFEnumeration.h
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#ifndef HFEnumeration_h
#define HFEnumeration_h

typedef NS_ENUM(NSInteger, HFKLineType) {
    HFKLineTypeFlat,             //一字板 停牌 情况下的k线
    HFKLineTypeHatching,         //阴线
    HFKLineTypeHzsunmoon,        //阳线
};

typedef NS_ENUM(NSInteger, HFKLineCycle) {
    HFKLineCycleDay,            //日线
    HFKLineCycleWeek,           //周
    HFKLineCycleMonth,          //月线
};

typedef NS_ENUM(NSInteger, HFRealTimeLineCrycel) {
    HFRealTimeLineCrycelMin,        //每分钟
    HFRealTimeLineCrycel5Min,        // 5分钟线
    HFRealTimeLineCrycel15Min,        // 15分钟线
    HFRealTimeLineCrycel30Min,        // 30分钟线
    HFRealTimeLineCrycel60Min,        // 60分钟线
    HFRealTimeLineCrycel5DayMin,        //5日 分钟线  最近5天的分钟线
};




typedef NS_ENUM(NSInteger, HFCheckVolumType) {
    HFCheckVolumTypeSame,        //和昨天一样
    HFCheckVolumTypeEnlarge,     //放量
    HFCheckVolumTypeNarrow,      //缩量
};
typedef NS_ENUM(NSInteger, HFCheckShadowType) {
    HFCheckShadowTypeSame,      //一样
    HFCheckShadowTypeUpper,     //上影线大于下影线
    HFCheckShadowTypeLow,     //下影线大于上影线
};

typedef NS_ENUM(NSInteger, HFCheckAverageType) {
    HFCheckAverageTypeUpper,            //价格在均线之上
    HFCheckAverageTypeUpperAcross,      //价格从上往下穿过
    HFCheckAverageTypeLow,              //价格在均线之下
    HFCheckAverageTypeLowAcross,        //价格上穿
};

#endif /* HFEnumeration_h */
