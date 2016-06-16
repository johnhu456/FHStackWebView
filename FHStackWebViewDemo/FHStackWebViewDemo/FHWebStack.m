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

@property (nonatomic, copy, readwrite) NSURL *webURL;

@end

@implementation FHWebStack

- (instancetype)initWithWebShot:(UIImage *)screenShoot webURL:(NSURL *)url webContentOffset:(CGPoint)contentOffSet{
    if (self = [super init]) {
        _webScreenShot = screenShoot;
        _webURL = url;
        _webContentOffset = contentOffSet;
    }
    return self;
}

@end
