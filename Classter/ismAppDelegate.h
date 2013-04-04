//
//  ismAppDelegate.h
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ismWebApi.h"

@class ismViewController;

@interface ismAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ismViewController *viewController;
@property (strong, nonatomic) UINavigationController *rootcontroller;
@property (strong, nonatomic) ismWebApi *webApi;

@end
