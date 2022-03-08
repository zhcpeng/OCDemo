//
//  JDTTransition.m
//  JDTJDStockCommonUI
//
//  Created by zhangchunpeng1 on 2022/1/10.
//

#import "JDTTransition.h"

@implementation JDTTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
    return UIApplication.sharedApplication.statusBarOrientationAnimationDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = transitionContext.containerView;
    
    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect finalFrame = CGRectOffset(initFrame, 0, CGRectGetHeight(UIApplication.sharedApplication.keyWindow.bounds));
//    CGRect finalFrame = CGRectOffset(initFrame, CGRectGetWidth(UIApplication.sharedApplication.keyWindow.bounds), 0);
    
//    CGRect finalFrame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    
    [container addSubview:toVC.view];
    [container bringSubviewToFront:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
