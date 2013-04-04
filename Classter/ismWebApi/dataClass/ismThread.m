//
//  ismThread.m
//  webApiTest5_2
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismThread.h"

@implementation ismThread

-(id)init{
	if ([super init]) {
		self.thread_id		= @"0";
		self.term			= @"0";
		self.category		= @"0";
		self.subcategory	= @"0";
		self.name			= @"0";
		self.created		= @"0";
		self.modified		= @"0";
	}
	return self;
}

-(void)showData{
	NSLog(@"data:%@",self);
}

-(BOOL)setDataWithDict:(NSDictionary *)srcDict{
	NSArray* keyList = [NSArray arrayWithObjects:@"thread_id",@"term",@"category",@"subcategory",@"name",@"created",@"modified", nil];
	
	for(NSString* key in keyList){
		if (![srcDict objectForKey:key]) {
			NSLog(@"have no key %@",key);
			return NO;
		}
	}
	
	self.thread_id		= [srcDict objectForKey:@"thread_id"];
	self.term			= [srcDict objectForKey:@"term"];
	self.category		= [srcDict objectForKey:@"category"];
	self.subcategory	= [srcDict objectForKey:@"subcategory"];
	self.name			= [srcDict objectForKey:@"name"];
	self.created		= [srcDict objectForKey:@"created"];
	self.modified		= [srcDict objectForKey:@"modified"];

	return YES;
}

@end
