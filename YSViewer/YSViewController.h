//
//  YSViewController.h
//  DemoApp
//
//  Created by taiki on 1/11/14.
//  Copyright (c) 2014 yashigani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSViewer.h"

@interface YSViewController : UIViewController
@property (weak, nonatomic) YSViewer *viewer;
@property (weak, nonatomic) id<YSViewerDelegate> delegate;

@end
