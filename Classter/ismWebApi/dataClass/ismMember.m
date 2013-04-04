//
//  ismMember.m
//  webApiTest5_2
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismMember.h"

@implementation ismMember


-(id)init{
	if ([super init]) {
		self.group_id = @"0";
		self.member_id = @"0";
		self.member_name = @"unknown";
		self.tel_number = @"000-0000-000";
		self.notes = @"hogehoge";
		self.isAdmin = NO;
		self.isEnabled = YES;
	}
	return self;
}

-(void)showData{
	NSLog(@"MemberData:%@",self);
}

-(BOOL)setDataWithDict:(NSDictionary *)srcDict{
	NSArray* keyList = [NSArray arrayWithObjects:@"group_id",@"member_id",@"name",@"tel_no",@"notes",@"admin",@"enabled",nil];
	
	for(NSString* key in keyList){
		if (![srcDict objectForKey:key]) {
			NSLog(@"have no key %@",key);
			return NO;
		}
	}
	
	self.group_id		= [srcDict objectForKey:@"group_id"];
	self.member_id		= [srcDict objectForKey:@"member_id"];
	self.member_name	= [srcDict objectForKey:@"name"];
	self.tel_number		= [srcDict objectForKey:@"tel_no"];
	self.notes			= [srcDict objectForKey:@"notes"];
	self.isAdmin		= [srcDict objectForKey:@"admin"];
	self.isEnabled		= [srcDict objectForKey:@"enabled"];
	return YES;
}

@end
