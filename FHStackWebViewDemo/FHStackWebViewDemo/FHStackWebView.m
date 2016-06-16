//
//  FHStackWebView.m
//  FHStackWebViewDemo
//
//  Created by MADAO on 16/6/15.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FHStackWebView.h"
#import "FHWebStackManager.h"

@interface FHStackWebView()<UIWebViewDelegate>
{
    __weak id<UIWebViewDelegate> _originDelegate;
}
@property (nonatomic, strong) FHWebStackManager *stackManager;

@end

@implementation FHStackWebView

#pragma mark - Init

- (FHWebStackManager *)stackManager
{
    if (_stackManager == nil) {
        _stackManager = [[FHWebStackManager alloc] init];
        _stackManager.webView = self;
    }
    return _stackManager;
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
}

- (void)setDelegate:(id<UIWebViewDelegate>)delegate
{
    _originDelegate = delegate;
}

- (id<UIWebViewDelegate>)delegate
{
    return _originDelegate;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if ([_originDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [_originDelegate webViewDidStartLoad:webView];
    }
    NSLog(@"start");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([_originDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        [_originDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    //创建WebStack并保存
    [self.stackManager pushNewWebStack];
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
