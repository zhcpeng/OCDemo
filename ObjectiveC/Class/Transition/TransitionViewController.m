//
//  TransitionViewController.m
//  ObjectiveC
//
//  Created by zhangchunpeng1 on 2022/1/10.
//  Copyright © 2022 张春鹏. All rights reserved.
//

#import "TransitionViewController.h"
#import "JDTTransition.h"


@interface TransitionViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;           ///< transition
@property (nonatomic, strong) JDTTransition *animatedTransitioning;           ///< <#Desprition#>
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;           ///< panRecognizer

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    _animatedTransitioning = JDTTransition.new;
    self.transitioningDelegate = self;
    
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
    [self.view addGestureRecognizer:_panRecognizer];
    
}

- (void)dealloc {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// MARK: - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return JDTTransition.new;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return _interactiveTransition;
}

- (void)panGestureRecognizer: (UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    CGFloat progress = translation.y / self.view.bounds.size.height;
    progress = MIN(1, MAX(0, progress));
    
    NSLog(@"%.2f %ld", progress, gestureRecognizer.state);
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            _interactiveTransition = UIPercentDrivenInteractiveTransition.new;
            [self dismissViewControllerAnimated:true completion:nil];
//            [self.navigationController popViewControllerAnimated:true];
            break;
        case UIGestureRecognizerStateChanged:
            [_interactiveTransition updateInteractiveTransition:progress];
            break;
        default:
            if (progress > 0.1) {
                [_interactiveTransition finishInteractiveTransition];
            } else {
                [_interactiveTransition cancelInteractiveTransition];
            }
            _interactiveTransition = nil;
            break;
    }
}

@end
