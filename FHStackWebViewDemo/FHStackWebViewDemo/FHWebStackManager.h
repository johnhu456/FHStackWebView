//
//  FHWebStackManager.h
//  FHStackWebViewDemo
//
//  Created by MADAO on 16/6/15.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHWebStack.h"

@protocol FHWebStackProcol <NSObject>

@end

@interface FHWebStackManager : NSObject

@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong, readonly) NSMutableArray *webStackArray;

- (void)pushNewWebStackWithImage:(UIImage *)image;

- (FHWebStack *)popWebStack;

- (void)cleanWebStack;

@end
