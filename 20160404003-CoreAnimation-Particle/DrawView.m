//
//  DrawView.m
//  20160404003-CoreAnimation-Particle
//
//  Created by Rainer on 16/4/5.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()

@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, weak) CALayer *userlayer;
@property (nonatomic, weak) CAReplicatorLayer *replicatorLayer;
@property (nonatomic, strong) CAKeyframeAnimation *keyframeAnimation;

@end

@implementation DrawView

// 这里用来记录移动的点
static int indexDot = 0;

/**
 *  触摸事件开始
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInView:self];
    
    [self.bezierPath moveToPoint:currentPoint];
}

/**
 *  手指移动中
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInView:self];
    
    [self.bezierPath addLineToPoint:currentPoint];
    
    indexDot ++;
    
    [self setNeedsDisplay];
}

/**
 *  开始动画
 */
- (void)startAnimation {
    [self.userlayer addAnimation:self.keyframeAnimation forKey:nil];
    
    [self.replicatorLayer addSublayer:self.userlayer];
    
    [self.layer addSublayer:self.replicatorLayer];
}

/**
 *  结束动画
 */
- (void)endAnimation {
    [self.userlayer removeFromSuperlayer];
    [self.replicatorLayer removeFromSuperlayer];
    
    self.keyframeAnimation = nil;
    
    self.userlayer = nil;
    
    self.replicatorLayer = nil;
    
    self.bezierPath = nil;
    
    [self setNeedsDisplay];
}

#pragma mark - 属性懒加载
/**
 *  贝赛尔路径懒加载
 */
- (UIBezierPath *)bezierPath {
    if (nil == _bezierPath) {
        _bezierPath = [UIBezierPath bezierPath];
    }
    
    return _bezierPath;
}

/**
 *  帧动画懒加载
 */
- (CAKeyframeAnimation *)keyframeAnimation {
    if (nil == _keyframeAnimation) {
        _keyframeAnimation = [CAKeyframeAnimation animation];
        
        _keyframeAnimation.keyPath = @"position";
        _keyframeAnimation.path = self.bezierPath.CGPath;
        _keyframeAnimation.duration = 3;
        _keyframeAnimation.repeatCount = MAXFLOAT;
    }
    
    return _keyframeAnimation;
}

/**
 *  动画点图层懒加载
 */
- (CALayer *)userlayer {
    if (nil == _userlayer) {
        CALayer *userlayer = [CALayer layer];
        
        CGFloat userlayerWH = 10;
        userlayer.frame = CGRectMake(0, -10000, userlayerWH, userlayerWH);
        userlayer.cornerRadius = userlayerWH * 0.5;
        userlayer.backgroundColor = [UIColor greenColor].CGColor;

        _userlayer = userlayer;
    }
    
    return _userlayer;
}

/**
 *  复制图层懒加载
 */
- (CAReplicatorLayer *)replicatorLayer {
    if (nil == _replicatorLayer) {
        CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
        
        replicatorLayer.instanceCount = indexDot;
        replicatorLayer.instanceDelay = 0.1;
        
        _replicatorLayer = replicatorLayer;
    }
    
    return _replicatorLayer;
}

/**
 *  绘图方法
 */
- (void)drawRect:(CGRect)rect {
    [self.bezierPath stroke];
}


@end
