//
//  ViewController.m
//  20160404003-CoreAnimation-Particle
//
//  Created by Rainer on 16/4/5.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  开始动画按钮点击事件
 */
- (IBAction)startAnimationClickAction:(id)sender {
    DrawView *drawView = (DrawView *)self.view;
    
    [drawView startAnimation];
}

/**
 *  结束动画按钮点击事件
 */
- (IBAction)endAnimationClickAction:(id)sender {
    DrawView *drawView = (DrawView *)self.view;
    
    [drawView endAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
