//
//  ismContact.h
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ismContactDetail.h"

@interface ismContact : UITableViewController{
	NSDictionary* resdict;
}

@property NSMutableArray* memberList;

@property ismWebApi *api;
@property NSUserDefaults *ud;


@end
