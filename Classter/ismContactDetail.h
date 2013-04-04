//
//  ismContactDetail.h
//  Classter
//
//  Created by kanade on 13/04/04.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ismContactDetail : UITableViewController

@property NSDictionary* memberDataDict;
@property NSArray* memberDataKeys;

@property ismWebApi* api;
@property NSUserDefaults* ud;

@end
