//
//  ismMember.h
//  webApiTest5_2
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ismDataClassBase.h"

@interface ismMember : ismDataClassBase

@property NSString* group_id;
@property NSString* member_id;
@property NSString* member_name;
@property NSString* tel_number;
@property NSString* notes;
@property BOOL isAdmin;
@property BOOL isEnabled;

@end
