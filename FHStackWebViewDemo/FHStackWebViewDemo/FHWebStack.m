//
//  FHWebStack.m
//  FHStackWebViewDemo
//
//  Created by MADAO on 16/6/15.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FHWebStack.h"

@interface FHWebStack()

@property (nonatomic, strong, readwrite) UIImage *webScreenShot;

@property (nonatomic, assign, readwrite) CGPoint webContentOffset;

@property (nonatomic, copy, readwrite) NSURLRequest *webURLRequest;

@end

@implementation FHWebStack

- (instancetype)initWithWebShot:(UIImage *)screenShoot webURLRequest:(NSURLRequest *)request webContentOffset:(CGPoint)contentOffSet{
    if (self = [super init]) {
        _webScreenShot = screenShoot;
        _webURLRequest = request;
        _webContentOffset = contentOffSet;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@  contentOffSet:%@",[[_webURLRequest URL] absoluteString], NSStringFromCGPoint(_webContentOffset)];
}
@end
