//
//  YSViewerWindow.h
//  DemoApp
//
//  Created by taiki on 12/5/13.
//  Copyright (c) 2013 yashigani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSViewController.h"

@class YSViewer;

@interface YSViewerWindow : UIWindow
@property (weak, nonatomic) YSViewer *viewer;
@property (strong, nonatomic, readonly) YSViewController *viewController;

@end
