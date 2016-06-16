//
//  FHStackWebView.m
//  FHStackWebViewDemo
//
//  Created by MADAO on 16/6/15.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FHStackWebView.h"
#import "FHWebStackManager.h"
#import <CoreGraphics/CoreGraphics.h>

@interface FHStackWebView()<UIWebViewDelegate>
{
    __weak id<UIWebViewDelegate> _originDelegate;
    BOOL _swipeBacking;
}
@property (nonatomic, strong) FHWebStackManager *stackManager;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation FHStackWebView

static NSTimeInterval const kAnimationDuration = 0.2f;
static NSString * const kMycustomBlankUrl = @"about:blank";

#pragma mark - Init

- (FHWebStackManager *)stackManager
{
    if (_stackManager == nil) {
        _stackManager = [[FHWebStackManager alloc] init];
        _stackManager.webView = self;
    }
    return _stackManager;
}

- (UIImageView *)leftImageView
{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] initWithFrame:self.frame];
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView
{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] initWithFrame:self.frame];
    }
    return _rightImageView;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [super setDelegate:self];
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self addGestureRecognizer:self.panGesture];
    _swipeBacking = NO;
}

- (void)setDelegate:(id<UIWebViewDelegate>)delegate
{
    _originDelegate = delegate;
}

- (id<UIWebViewDelegate>)delegate
{
    return _originDelegate;
}

#pragma mark - UIPanGestureRecognizer
- (void)handlePanGesture:(UIPanGestureRecognizer *)pan
{
    //判断方向
    CGPoint velocity = [pan velocityInView:self];
    if (fabs(velocity.y) < fabs(velocity.x)) {
        //处理手势
        [self nextStepWithPanGesture:pan];
    }
    else
        return;
}

- (void)nextStepWithPanGesture:(UIPanGestureRecognizer *)pan
{
    //判断是否有上级页面
    if (!self.stackManager.webStackArray.count) {
        return;
    }
    switch (pan.state) {
            case UIGestureRecognizerStateBegan:{
                //PopNewStack
                [self prepareViewTransition];
            }

            break;
            case UIGestureRecognizerStateChanged:{
                //处理动画
                [self handleViewTransitionWithCGPoint:[pan translationInView:self]];
                self.exclusiveTouch = NO;
            }
            break;
            case UIGestureRecognizerStateEnded: case UIGestureRecognizerStateCancelled:{
                [self handleCanceledOrEndedGestureWitPoint:[pan translationInView:self]];
            }
            break;
        default:
            break;
    }
}

- (void)prepareViewTransition
{
    self.leftImageView.image = [self.stackManager headStack].webScreenShot;
    [self.superview insertSubview:self.leftImageView belowSubview:self];
}

- (void)handleViewTransitionWithCGPoint:(CGPoint )point{
    if (point.x < 0)
    {
        return;
    }
    CGRect newFrame = CGRectMake(point.x, 0, self.frame.size.width, self.frame.size.height);
    self.frame = newFrame;
}

- (void)handleCanceledOrEndedGestureWitPoint:(CGPoint )point{
    _swipeBacking = YES;
    __weak typeof(self) weakSelf = self;
    //返回
    if (point.x > self.frame.size.width * 1/4.f) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            //移出边框
            weakSelf.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
            [weakSelf loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kMycustomBlankUrl]]];
        } completion:^(BOOL finished) {
            [weakSelf.stackManager popWebStack];
            weakSelf.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            [weakSelf.leftImageView removeFromSuperview];
            weakSelf.exclusiveTouch = YES;
        }];
    }
}

#pragma mark - PrivateMethod
- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0.0);
    
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    }
    else{
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([_originDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        [_originDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    switch (navigationType) {
            case UIWebViewNavigationTypeReload: case UIWebViewNavigationTypeBackForward: case UIWebViewNavigationTypeFormResubmitted:
            break;
        default:
        {
            if ([[request.URL absoluteString] isEqualToString:[[self.stackManager headStack].webURLRequest.URL absoluteString]] || [[request.URL absoluteString] isEqualToString:kMycustomBlankUrl])
            {
                break;
            }
            else{
                //PushNewStack
                [self.stackManager pushNewWebStackWithRequest:request andImage:[self snapshot:self]];
                return YES;
            }
        }
            break;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if ([_originDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [_originDelegate webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([_originDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [_originDelegate webViewDidStartLoad:webView];
    }
    NSLog(@"%@",[self.stackManager webStackArray]);
}


@end
