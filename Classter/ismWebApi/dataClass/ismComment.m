//
//  ismComment.m
//  webApiTest5_2
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismComment.h"

@implementation ismComment

-(id)init{
	if ([super init]) {
		self.thread_id		= @"0";
		self.member_id		= @"0";
		self.membername		= @"0";
		self.title			= @"0";
		self.content		= @"0";
		self.hasfile		= NO;
		self.filename		= @"unknown";
		self.filesize		= 0;
		self.created		= @"0";
		self.modified		= @"0";
		self.likes			= 0;
		self.youlike		= NO;
	}
	return self;
}

-(void)showData{
	NSLog(@"data:%@",self);
}

-(BOOL)setDataWithDict:(NSDictionary *)srcDict{
	NSArray* keyList = [NSArray arrayWithObjects:@"thread_id",@"member_id",@"membername",@"title",@"content",@"hasfile",@"filename",@"filesize",@"created",@"modified",@"likes",@"youlike", nil];
	
	for(NSString* key in keyList){
		if (![srcDict objectForKey:key]) {
			NSLog(@"have no key %@",key);
			return NO;
		}
	}
	
	self.thread_id		= [srcDict objectForKey:@"thread_id"];
	self.member_id		= [srcDict objectForKey:@"member_id"];
	self.membername		= [srcDict objectForKey:@"membername"];
	self.title			= [srcDict objectForKey:@"title"];
	self.content		= [srcDict objectForKey:@"content"];
	self.hasfile		= [srcDict objectForKey:@"hasfile"];
	self.filename		= [srcDict objectForKey:@"filename"];
	self.filesize		= [srcDict objectForKey:@"filesize"];
	self.created		= [srcDict objectForKey:@"created"];
	self.modified		= [srcDict objectForKey:@"modified"];
	self.likes			= [srcDict objectForKey:@"likes"];
	self.youlike		= [srcDict objectForKey:@"youlike"];
	
	return YES;
}

@end
