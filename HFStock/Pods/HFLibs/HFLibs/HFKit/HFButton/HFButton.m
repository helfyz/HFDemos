//
//  HFButton.m
//  HFKitDemo
//
//  Created by helfy  on 15/8/17.
//  Copyright (c) 2015年 helfy. All rights reserved.
//

#import "HFButton.h"
#import "UIView+HFCGRect.h"
@interface HFButton ()
@property (nonatomic, strong) UIColor *normallColor;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, assign) CGSize imageSize;
@end

@implementation HFButton
#define mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setupView];
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if(self)
    {
        [self setupView];
    }
    return self;
}

#pragma mark setup
- (void)setupView {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font          = [UIFont systemFontOfSize:16.0];
    self.space                      = 5;
}
// 快捷设置
- (void)setTitile:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}
// 默认状态:UIControlStateNormal
- (void)setTitile:(NSString *)title textColor:(UIColor *)textColor {
    [self setTitile:title];
    [self setTitleColor:textColor forState:UIControlStateNormal];
}
// 默认事件:UIControlEventTouchUpInside
- (void)addTarget:(id)target action:(SEL)action {
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
//设置默认背景色 & 高亮背景色
- (void)setNormalBgColor:(UIColor *)normalColor highlightedBgColor:(UIColor *)highlightedColor {
    self.normallColor = normalColor;
    self.highlightedColor = highlightedColor;
    [self setCustomHighligth:self.highlighted];
    
}

- (void)setImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;

}

- (void)setImageSize:(CGSize)imagSize {
    _imageSize = imagSize;
}

- (void)setImage:(UIImage *)image imagesize:(CGSize)imageSize {
    self.imageSize = imageSize;
    [self setImage:image];
}

-(void)setCustomHighligth:(BOOL)highlight {
    if(!(self.normallColor &&  self.highlightedColor))return;
    if(highlight)
    {
        self.backgroundColor = self.highlightedColor;
    }
    else{
        self.backgroundColor = self.normallColor;
    }
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setCustomHighligth:highlighted];
}

#pragma mark 重写父类UIButton的方法
//根据button的rect设定并返回文本label的rect
- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    contentRect = UIEdgeInsetsInsetRect(contentRect, self.contentInsets);
    
    NSString *titleStr = [self titleForState:self.state];
    UIFont *textFont =  [UIFont systemFontOfSize:16];//self.titleLabel.font;
    
    switch (self.imageContentMode) {
        case HFButtonImageContentModeBackgroud: {
//            contentRect = contentRect;
            break;
        }
        case HFButtonImageContentModeTop: {
            contentRect.size.width = contentRect.size.width;
            CGSize textSize = [titleStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                            textFont, NSFontAttributeName,
                                                            nil]];
            textSize.width =MIN(contentRect.size.width, textSize.width);
            contentRect.size = textSize;
            contentRect.origin.y =self.imageSize.height + self.space + (self.hf_SizeHeight - (textSize.height+ self.imageSize.height+self.space))/2.0;
            contentRect.origin.x   = (self.hf_SizeWidth-textSize.width)/2.0;
            break;
        }
        case HFButtonImageContentModeBottom: {
            contentRect.size.width = contentRect.size.width;
           CGSize textSize = [titleStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                            textFont, NSFontAttributeName,
                                                            nil]];
            textSize.width =MIN(contentRect.size.width, textSize.width);
            contentRect.size = textSize;
            contentRect.origin.y = (self.hf_SizeHeight-(textSize.height+ self.imageSize.height+self.space))/2.0;
            contentRect.origin.x   = (self.hf_SizeWidth-textSize.width)/2.0;
            break;
        }
        case HFButtonImageContentModeLeft: {
            contentRect.size.width = contentRect.size.width - self.imageSize.width;
            NSString *titleStr     = [self titleForState:self.state];
            CGSize textSize        = [titleStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           textFont, NSFontAttributeName,
                                                            nil]];
            textSize.width         = MIN(contentRect.size.width-self.imageSize.width, textSize.width);
            contentRect.size       = textSize;
            contentRect.origin.x   = self.space + (self.hf_SizeWidth-(textSize.width+self.imageSize.width + self.space))/2.0+ self.imageSize.width;
            contentRect.origin.y = (self.hf_SizeHeight-textSize.height)/2.0;
            break;
        }
        case HFButtonImageContentModeRight: {
            contentRect.size.width = contentRect.size.width - self.imageSize.width;
            NSString *titleStr     = [self titleForState:self.state];
            CGSize textSize        = [titleStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                            textFont, NSFontAttributeName,
                                                            nil]];
            textSize.width         = MIN(contentRect.size.width-self.imageSize.width, textSize.width);
            contentRect.size       = textSize;
            contentRect.origin.x   = (self.hf_SizeWidth-(textSize.width+self.imageSize.width + self.space))/2.0;
            contentRect.origin.y = (self.hf_SizeHeight-textSize.height)/2.0;
            break;
        }
        default: {
            break;
        }
    }
    return contentRect;
}

//根据根据button的rect设定并返回UIImageView的rect
- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    //iOS 7 会出现多个imageView
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if(version >= 7.0 && version < 8.0) {
        NSMutableArray *imageViews = [NSMutableArray array];
        for (UIView *view in self.subviews) {
            if([view isKindOfClass:[UIImageView class]]) {
                [imageViews addObject:view];
            }
        }
        for (int index = 1; index < imageViews.count; index++) {
            UIImageView *imageView = imageViews[index];
            [imageView removeFromSuperview];
        }
    }
    
    contentRect = UIEdgeInsetsInsetRect(contentRect, self.contentInsets);
    if(CGSizeEqualToSize(self.imageSize, CGSizeZero)) {//如果未设置
        self.imageSize = contentRect.size;
    }
    switch (self.imageContentMode) {
        case HFButtonImageContentModeBackgroud: {
            contentRect.origin.x    = (int)(contentRect.size.width - self.imageSize.width )/2;
            contentRect.origin.y    = (int)(contentRect.size.height - self.imageSize.height )/2;
            contentRect.size.width  = self.imageSize.width;
            contentRect.size.height = self.imageSize.height;
            break;
        }
        case HFButtonImageContentModeTop: {
            CGFloat imageX = (self.hf_SizeWidth - self.imageSize.width)/2.0;
            CGFloat imageY = (self.hf_SizeHeight - (self.titleLabel.hf_SizeHeight + self.imageSize.height + self.space))/2.0;
            contentRect = (CGRect){{imageX, imageY}, self.imageSize};
            break;
        }
        case HFButtonImageContentModeBottom: {
            CGFloat imageX = (self.hf_SizeWidth - self.imageSize.width)/2.0 ;
            CGFloat imageY = (self.hf_SizeHeight - (self.titleLabel.hf_SizeHeight + self.imageSize.height + self.space))/2.0 + self.titleLabel.hf_SizeHeight+self.space;
            contentRect = (CGRect){{imageX,imageY},self.imageSize};
            break;
        }
        case HFButtonImageContentModeLeft: {
            CGFloat imageX = (self.hf_SizeWidth - (self.titleLabel.hf_SizeWidth + self.imageSize.width + self.space))/2.0;
            CGFloat imageY = (self.hf_SizeHeight - self.imageSize.height)/2.0;
            contentRect = (CGRect){{imageX,imageY}, self.imageSize};
            break;
        }
        case HFButtonImageContentModeRight: {
            CGFloat imageX = (self.hf_SizeWidth - (self.titleLabel.hf_SizeWidth + self.imageSize.width+self.space))/2.0 + self.titleLabel.hf_SizeWidth + self.space;
            CGFloat imageY = (self.hf_SizeHeight - self.imageSize.height )/2.0;
            contentRect = (CGRect){{imageX,imageY}, self.imageSize};
            break;
        }
        default: {
            break;
        }
    }
    
    return contentRect;
}
@end
