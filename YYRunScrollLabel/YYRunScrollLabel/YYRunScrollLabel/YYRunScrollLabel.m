//
//  YYRunScrollLabel.m
//  YYRunScrollLabel
//
//  Created by HZYL_FM3 on 2017/8/21.
//  Copyright © 2017年 HZYL_FM3. All rights reserved.
//

/*
 * UILabel 跑马灯效果
 * 
 */

#import "YYRunScrollLabel.h"

#define TAG_LABEL       100
#define SPACE_LABEL     30.0
#define FONT_SIZE       15.0

@interface YYRunScrollLabel ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YYRunScrollLabel
{
    BOOL _needAnimation;
    CGFloat offsetX;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.scrollEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.userInteractionEnabled = YES;
        
        [self addLabelWithTag:TAG_LABEL];
    }
    return self;
}

- (void)addLabelWithTag:(int)tag
{
    UILabel *label = [[UILabel alloc] init];
    label.tag = tag;
    label.font = [UIFont systemFontOfSize:FONT_SIZE];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
}

#pragma mark - set、get
- (void)setText:(NSString *)text
{
    UILabel *label = [self viewWithTag:TAG_LABEL];
    label.text = text;
    [label sizeToFit];
    
    UILabel *otherLabel = [self viewWithTag:TAG_LABEL+1];
    if (label.frame.size.width > self.frame.size.width) {
        //长度超过，需要滚动,再加一个label
        _needAnimation = YES;
        if (otherLabel == nil) {
            otherLabel = [[UILabel alloc] init];
            otherLabel.tag = TAG_LABEL+1;
            otherLabel.font = self.font ? self.font : [UIFont systemFontOfSize:FONT_SIZE];
            otherLabel.textColor = self.textColor ? self.textColor : [UIColor whiteColor];
            [self addSubview:otherLabel];
        }
        otherLabel.text = text;
        [otherLabel sizeToFit];
        
        label.frame = CGRectMake(0, 0, label.frame.size.width, self.frame.size.height);
        otherLabel.frame = CGRectMake(CGRectGetMaxX(label.frame)+SPACE_LABEL, 0, otherLabel.frame.size.width, self.frame.size.height);
        self.contentSize = CGSizeMake(label.frame.size.width+otherLabel.frame.size.width+SPACE_LABEL, self.frame.size.height);
        
        [self startAnimation];
    }
    else
    {
        //长度未超过，不需要滚动
        _needAnimation = NO;
        [self stopAnimation];
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, label.frame.size.width, self.frame.size.height);
        [self setContentOffset:CGPointMake(0, 0)];
        label.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        if (otherLabel) {
            [otherLabel removeFromSuperview];
        }
    }
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subView;
            label.font = font;
        }
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subView;
            label.textColor = textColor;
        }
    }
}

- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

#pragma mark - animation
- (void)animation
{
    
    [self.timer fire];
}

- (void)scroll
{
    offsetX+=5.0;
    UILabel *label = [self viewWithTag:TAG_LABEL];
    if (offsetX >= label.frame.size.width+SPACE_LABEL) {
        [self setContentOffset:CGPointMake(0, 0) animated:NO];
        offsetX = 0.0;
    }
    else
    {
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

- (void)startAnimation
{
    if (!_needAnimation) {
        return;
    }
    [self.timer fire];
}

- (void)stopAnimation
{
    if (_timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


@end
