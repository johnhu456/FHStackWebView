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
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.stackWebView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
