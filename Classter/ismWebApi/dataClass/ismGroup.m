//
//  ismGroup.m
//  webApiTest5_2
//
//  Created by kanade on 13/03/31.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismGroup.h"

@implementation ismGroup

-(id)init{
	if ([super init]) {
		self.Id = @"0";
		self.name = @"no name";
	}
	return self;
}

-(void)showData{
	NSLog(@"No.%@: %@",self.Id,self.name);
}

-(BOOL)setDataWithDict:(NSDictionary *)srcDict{
	NSArray* keyList = [NSArray arrayWithObjects:@"group_id",@"groupname", nil];
	
	for(NSString* key in keyList){
		if (![srcDict objectForKey:key]) {
			NSLog(@"have no key %@",key);
			return NO;
		}
	}
	
	self.Id = [srcDict objectForKey:@"group_id"];
	self.name = [srcDict objectForKey:@"groupname"];
	return YES;
}

@end
