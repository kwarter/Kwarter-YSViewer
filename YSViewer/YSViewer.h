//
//  YSViewer.h
//  DemoApp
//
//  Created by taiki on 12/5/13.
//  Copyright (c) 2013 yashigani. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YSViewer;

@protocol YSViewerDelegate <NSObject>

@optional
- (void)viewerWillDisappear:(YSViewer *)viewer;

@end

@interface YSViewer : NSObject
@property (nonatomic) UIImage *image;
@property (nonatomic) UIView *view;
@property UIView *backgroundView;
@property (readonly) UIWindow *parentWindow;

@property (nonatomic, weak) id<YSViewerDelegate> delegate;

- (void)show;
- (void)hide;

@end
