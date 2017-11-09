//
//  ViewController.m
//  YYRunScrollLabel
//
//  Created by HZYL_FM3 on 2017/8/21.
//  Copyright © 2017年 HZYL_FM3. All rights reserved.
//

#import "ViewController.h"
#import "YYRunScrollLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YYRunScrollLabel *runLabel = [[YYRunScrollLabel alloc] initWithFrame:CGRectMake(50.0, 100.0, self.view.frame.size.width-50.0*2, 30.0)];
    runLabel.text = @"ABCDEFGHIJKLMNOPQRSTUVWXYdfdfdfdf";
    runLabel.font = [UIFont systemFontOfSize:16.0];
    runLabel.textColor = [UIColor redColor];
    [self.view addSubview:runLabel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
