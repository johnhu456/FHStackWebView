//
//  FHWebStackManager.m
//  FHStackWebViewDemo
//
//  Created by MADAO on 16/6/15.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FHWebStackManager.h"

@interface FHWebStackManager()

@property (nonatomic, strong, readwrite) NSMutableArray *webStackArray;

@end

@implementation FHWebStackManager

- (NSMutableArray *)webStackArray
{
    if (_webStackArray == nil) {
        _webStackArray = [[NSMutableArray alloc] init];
    }
    return _webStackArray;
}

- (void)pushNewWebStackWithImage:(UIImage *)image;
{
    FHWebStack *newStack = [[FHWebStack alloc] initWithWebShot:image webURL:self.webView.request.URL webContentOffset:self.webView.scrollView.contentOffset];
    [self.webStackArray insertObject:newStack atIndex:0];
}

- (FHWebStack *)popWebStack
{
    return _webStackArray[0];
}

- (void)cleanWebStack
{
    [self.webStackArray removeAllObjects];
}

@end
