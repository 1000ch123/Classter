//
//  ismTimeTableComments.h
//  Classter
//
//  Created by kanade on 13/04/03.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ismTimeTableCommentDetail.h"
#import "ismTimeTableCommentPost.h"

@interface ismTimeTableComments : UITableViewController{
	NSMutableArray* commentList;
	
}



@property ismWebApi *api;
@property NSUserDefaults *ud;

@end
