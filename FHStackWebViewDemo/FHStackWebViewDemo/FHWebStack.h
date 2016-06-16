//
//  FHWebStack.h
//  FHStackWebViewDemo
//
//  Created by MADAO on 16/6/15.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FHWebStack : NSObject

@property (nonatomic, strong, readonly) UIImage *webScreenShot;

@property (nonatomic, assign, readonly) CGPoint webContentOffset;

@property (nonatomic, copy, readonly) NSURLRequest *webURLRequest;

- (instancetype)init __attribute__((unavailable("init方法不可用，请用initWithWebShot...")));
- (instancetype)initWithWebShot:(UIImage *)screenShoot webURLRequest:(NSURLRequest *)request webContentOffset:(CGPoint)contentOffSet NS_DESIGNATED_INITIALIZER;

@end
