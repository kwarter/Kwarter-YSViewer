//
//  YSViewController.h
//  DemoApp
//
//  Created by taiki on 1/11/14.
//  Copyright (c) 2014 yashigani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSViewer;

@protocol YSViewerDelegate <NSObject>

@optional
- (void)viewerWillDisappear:(YSViewer *)viewer;

@end

@interface YSViewController : UIViewController
@property (weak, nonatomic) YSViewer *viewer;
@property (weak, nonatomic) id<YSViewerDelegate> delegate;

@end
