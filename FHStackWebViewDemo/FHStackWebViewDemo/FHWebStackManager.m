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

- (void)pushNewWebStackWithRequest:(NSURLRequest *)reqeust andImage:(UIImage *)image;
{
    FHWebStack *newStack = [[FHWebStack alloc] initWithWebShot:image webURLRequest:reqeust   webContentOffset:self.webView.scrollView.contentOffset];
    [self.webStackArray addObject:newStack];
}

- (FHWebStack *)popWebStack
{
    FHWebStack *popedStack = [_webStackArray lastObject];
    [self.webView goBack];
    [self.webView goBack];
    [_webStackArray removeLastObject];
    return popedStack;
}

- (void)cleanWebStack
{
    [self.webStackArray removeAllObjects];
}

- (FHWebStack *)headStack
{
    return [self.webStackArray lastObject];
}

- (CGPoint)secondStackContentoffSet{
    FHWebStack *secondStack = [self.webStackArray objectAtIndex:self.webStackArray.count - 2];
    return secondStack.webContentOffset;
}
@end
