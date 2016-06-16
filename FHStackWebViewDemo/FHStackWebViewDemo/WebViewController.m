//
//  WebViewController.m
//  FHStackWebViewDemo
//
//  Created by MADAO on 16/6/15.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "WebViewController.h"
#import "FHStackWebView.h"
#import "FHWebStackManager.h"

@interface WebViewController ()

@property (strong, nonatomic) FHStackWebView *stackWebView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stackWebView = [[FHStackWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.stackWebView];
    
    FHWebStackManager *manager = [[FHWebStackManager alloc] init];
    manager.webView = self.stackWebView;
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.163.com"]];
    [self.stackWebView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
