//
//  ismComment.h
//  webApiTest5_2
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismDataClassBase.h"

@interface ismComment : ismDataClassBase

@property NSString* thread_id;
@property NSString* member_id;
@property NSString* membername;
@property NSString* title;
@property NSString* content;
@property BOOL		hasfile;
@property NSString* filename;
@property NSInteger filesize;
@property NSString* created;
@property NSString* modified;
@property NSInteger likes;
@property BOOL		youlike;

@end
