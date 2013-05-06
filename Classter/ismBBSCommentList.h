//
//  ismBBSCommentList.h
//  Classter
//
//  Created by kanade on 13/04/06.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ismBBSCommentDetail.h"
#import "ismBBSCommentPost.h"

@interface ismBBSCommentList : UITableViewController{
	int offset;
	int limit;
}


@property NSArray* commentList;

@property ismWebApi *api;
@property NSUserDefaults *ud;

@end
