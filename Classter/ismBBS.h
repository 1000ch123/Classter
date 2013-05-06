//
//  ismBBS.h
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ismBBSCommentList.h"
#import "ismBBSThreadAdd.h"

@interface ismBBS : UITableViewController

@property NSArray* threadList;

@property ismWebApi *api;
@property NSUserDefaults *ud;


@end
