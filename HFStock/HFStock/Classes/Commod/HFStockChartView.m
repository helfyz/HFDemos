//
//  HFStockChartView.m
//  HFStock
//
//  Created by helfy on 16/8/4.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "HFStockChartView.h"
#import "HFKLineDrwaModel.h"
#import "HFConfigCenter.h"
@implementation HFStockChartView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor clearColor];
    self.startPoint = self.frame.origin;
    self.endPoint = self.frame.origin;
    self.lineWidth = 3.0f;
    self.linePadding = 2;
}
-(void)setKLineDrawArrays:(NSArray *)kLineDrawArrays
{
    _kLineDrawArrays = kLineDrawArrays;
    [self setNeedsDisplay];
    
}
-(void)setAverageModels:(NSArray *)averageModels
{
    _averageModels = averageModels;
//    [self changePointWithData:self.averageModels];
    [self setNeedsDisplay];
    
}
//#pragma mark 把股市数据换算成实际的点坐标数组
//-(NSArray*)changeKPointWithData:(NSArray*)data{
//    
//    NSMutableArray *pointArray = [[NSMutableArray alloc] init];
//    CGFloat kLineWidth = self.lineWidth;
//    CGFloat  kLinePadding = self.linePadding;
//    CGFloat PointStartX = kLineWidth/2; // 起始点坐标
//    for (MSTencentKLine *item in data) {
//        HFKLineDrwaModel *drawModel = [item drawModelWithMaxPrice:self.maxPrice minPrice:self.minPrice drawSize:self.frame.size startX:PointStartX];
//        [pointArray addObject:drawModel]; // 把坐标添加进新数组
//        PointStartX += kLineWidth+kLinePadding; // 生成下一个点的x轴
//    }
//    self.sizeWidth = PointStartX + kLinePadding;
//    return pointArray;
//}
//-(void)changePointWithData:(NSArray*)data{
//    for (MSAverageModel *averageDrawModel in data) {
//        CGFloat PointStartX = 0.0f; // 起始点坐标
//        
//        for (NSString *priceVale in averageDrawModel.prices) {
//            CGFloat currentValue = [priceVale floatValue];// 得到前五天的均价价格
//            // 换算成实际的坐标
//            CGFloat currentPointY = self.sizeHeight - ((currentValue - self.minPrice) / (self.maxPrice - self.minPrice) * self.sizeHeight);
//            CGPoint currentPoint =  CGPointMake(PointStartX+self.lineWidth/2, currentPointY); // 换算到当前的坐标值
//            [averageDrawModel.drawPoints addObject:[NSValue valueWithCGPoint:currentPoint]]; // 把坐标添加进新数组
//            PointStartX += self.lineWidth + self.linePadding; // 生成下一个点的x轴
//        }
//    }
//}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();// 获取绘图上下文
    // 画k线
    for (HFKLineDrwaModel *klineModel in self.kLineDrawArrays) {
        [self drawKLineWithcontext:context klineModel:klineModel];
    }
//    //画均线
//    for (MSAverageModel *averageModel in self.averageModels) {
//        [self drawLineWithContext:context averageModel:averageModel];
//    }
}
-(void)drawKLineWithcontext:(CGContextRef)context klineModel:(HFKLineDrwaModel *)klineModel
{
    CGContextSetShouldAntialias(context, NO);
    // 设置颜色
    CGContextSetStrokeColorWithColor(context, [[HFConfigCenter shareCenter] colorForKLineType:klineModel.kLineType].CGColor);
    
    // 首先画一个垂直的线包含上影线和下影线
    // 定义两个点 画两点连线
    
    CGContextSetLineWidth(context, 1); // 上下阴影线的宽度
    if (self.lineWidth<=2) {
        CGContextSetLineWidth(context, 0.5); // 上下阴影线的宽度
    }
    const CGPoint points[] = {klineModel.maxPoint,klineModel.minPoint};
    CGContextStrokeLineSegments(context, points, 2);  //
    CGContextSetLineWidth(context, self.lineWidth); // 改变线的宽度
    CGFloat halfWidth = 0;
    
    // 纠正实体的中心点为当前坐标
    CGPoint startPoint = CGPointMake( klineModel.startPoint.x - halfWidth,  klineModel.startPoint.y);
    CGPoint endPoint = CGPointMake(klineModel.endPoint.x - halfWidth, klineModel.endPoint.y);
    
    // 开始画实体
    if(CGPointEqualToPoint(startPoint, endPoint))
    {
        const CGPoint point[] = {startPoint,CGPointMake(endPoint.x, endPoint.y + 0.5)};
        CGContextStrokeLineSegments(context, point, 2);
        
    }
    else
    {
        const CGPoint point[] = {startPoint,endPoint};
        CGContextStrokeLineSegments(context, point, 2);  // 绘制线段（默认不绘制端点）
    }
    
}
#pragma mark 画连接线
//-(void)drawLineWithContext:(CGContextRef)context averageModel:(MSAverageModel *)averageModel
//{
//    CGContextSetLineWidth(context, 0.5);
//    CGContextSetShouldAntialias(context, YES);
//    CGContextSetStrokeColorWithColor(context, [averageModel color].CGColor);
//    
//    NSInteger startIndex = averageModel.number;  //n日均线，前n日都计算不到
//    for (; startIndex < averageModel.drawPoints.count; startIndex ++) {
//        NSValue *pointValue = averageModel.drawPoints[startIndex];
//        CGPoint currentPoint = [pointValue CGPointValue];
//        if (startIndex == averageModel.number) {
//            CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
//            continue;
//        }
//        CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y); }
//    
//    CGContextStrokePath(context); //开始画线
//    
//}

@end
