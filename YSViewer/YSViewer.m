//
//  YSViewer.m
//  DemoApp
//
//  Created by taiki on 12/5/13.
//  Copyright (c) 2013 yashigani. All rights reserved.
//

#import "YSViewer.h"

#import "YSViewerWindow.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@interface YSViewer ()
@property YSViewerWindow *window;
@property (readwrite) UIWindow *parentWindow;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation YSViewer
@synthesize view = _view;

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    return  self;
}

- (void)show
{
    if (!_window) {
        _parentWindow = UIApplication.sharedApplication.keyWindow;
        _window = [YSViewerWindow new];

        _window.viewer = self;

        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(windowDidBecomeKey:)
                                                   name:UIWindowDidBecomeKeyNotification
                                                 object:_window];
        [_window makeKeyAndVisible];
    }
}

- (void)hide
{
    __weak __typeof(self) wself = self;
    [UIView transitionWithView:_window
                      duration:.25
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ [wself.view removeFromSuperview]; }
                    completion: ^(BOOL finished) {
                        [NSNotificationCenter.defaultCenter removeObserver:self
                                                                      name:UIWindowDidBecomeKeyNotification
                                                                    object:wself.window];
                        wself.window = nil;
                        if (!IS_IPAD) {
                            [UIView animateWithDuration:.25
                                             animations:^{
                                                 wself.parentWindow.transform = CGAffineTransformIdentity;
                                             }];
                        }
                        [wself.parentWindow makeKeyAndVisible];
                        wself.view.transform = CGAffineTransformIdentity;
                    }];
}

- (UIView *)view
{
    if (!_view) {
        _imageView = [[UIImageView alloc] initWithImage:_image];
        if (!CGRectContainsRect(_window.bounds, _imageView.bounds)) {
            _imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            if (_image.size.width >= _image.size.height) {
                _imageView.bounds = CGRectMake(0, 0, _window.bounds.size.width, (_image.size.height/_image.size.width)*_window.bounds.size.width);
            } else {
                _imageView.bounds = CGRectMake(0, 0, (_image.size.width/_image.size.height)*_window.bounds.size.height, _window.bounds.size.height);
            }
            
            _imageView.center = _window.center;
        }
        _view = _imageView;
    }
    return _view;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = _image;
    
    if (_image.size.width >= _image.size.height) {
        _imageView.bounds = CGRectMake(0, 0, _window.bounds.size.width, (_image.size.height/_image.size.width)*_window.bounds.size.width);
    } else {
        _imageView.bounds = CGRectMake(0, 0, (_image.size.width/_image.size.height)*_window.bounds.size.height, _window.bounds.size.height);
    }
    
    _imageView.center = _window.center;
}

#pragma mark - UIWindow Notifications

- (void)windowDidBecomeKey:(NSNotification *)notification
{
    _view.alpha = 0;
    _view.transform = CGAffineTransformMakeScale(.9, .9);
    __weak __typeof(self) wself = self;
    [UIView transitionWithView:_window
                      duration:.25
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        wself.view.alpha = 1;
                        wself.view.transform = CGAffineTransformIdentity;
                        if (!IS_IPAD) {
                            wself.parentWindow.transform = CGAffineTransformMakeScale(.9, .9);
                        }
                    }
                    completion:nil];
}

@end
