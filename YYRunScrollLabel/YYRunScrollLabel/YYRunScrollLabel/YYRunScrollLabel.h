//
//  YYRunScrollLabel.h
//  YYRunScrollLabel
//
//  Created by HZYL_FM3 on 2017/8/21.
//  Copyright © 2017年 HZYL_FM3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYRunScrollLabel : UIScrollView

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont   *font;
@property (nonatomic, strong) UIColor  *textColor;

- (void)startAnimation;
- (void)stopAnimation;

@end
