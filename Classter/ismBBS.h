//
//  ismBBS.h
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ismCommentBBS.h"

@interface ismBBS : UITableViewController

@property NSMutableArray* array;

@property ismWebApi *api;
@property NSUserDefaults *ud;


@end
