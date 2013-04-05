//
//  ismWebApi.m
//  WebApiTest5
//
//  Created by kanade on 13/03/31.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismWebApi.h"

@implementation ismWebApi

@synthesize time;


-(id)init{
	if ([super init]) {
		self.time = @"0";
		self.mailAddress = @"test@test.com";
		self.password = @"password";
		self.userId = @"unknown";
		self.groupId = @"0";
		self.memberId = @"0";
		self.threadId = @"0";
		self.commentId = @"0";
	}
	return self;
}

-(id)initWithAddress:(NSString *)mail password:(NSString *)pass{
	if ([super init]) {
		self.time = @"0";
		self.mailAddress = mail;
		self.password = pass;
		self.userId = @"unknown";
		self.groupId = @"0";
		self.memberId = @"0";
		self.threadId = @"0";
		self.commentId = @"0";

	}
	return self;
}


-(NSDictionary*) getTime{
	NSArray* vars = [NSArray arrayWithObjects:@"GetTime", nil];
	NSArray* keys = [NSArray arrayWithObjects:@"command", nil];
	
	NSDictionary* resDict = [self useApi:API_COMMON varList:vars keyList:keys];

	NSString *errorCode = [NSString stringWithFormat:@"%@",[resDict objectForKey:@"code"]];
	if ([errorCode isEqual:@"0"]) {
		self.time = [resDict objectForKey:@"time"];
		return resDict;
	}else{
		self.time = @"0";
		return  nil;
	}
	//return [self useApi:API_COMMON varList:vars keyList:keys];
}


-(NSDictionary*) getUserId{
	//[self getTime];
	NSArray* vars = [NSArray arrayWithObjects:@"GetUserId",self.mailAddress,self.time,[self getSha1withPassword], nil];
	NSArray* keys = [NSArray arrayWithObjects:@"command",@"email",@"unixtimestamp",@"onetimepassword", nil];
	
	NSDictionary* resDict =[[NSDictionary alloc] initWithDictionary:[self useApi:API_COMMON varList:vars keyList:keys]];
	
	NSString *errorCode = [NSString stringWithFormat:@"%@",[resDict objectForKey:@"code"]];
	if ([errorCode isEqual:@"0"]) {
		self.userId = [resDict objectForKey:@"user_id"];
		return resDict;
	}else{
		self.userId = @"still unknown";
		return nil;
	}
}


// group


-(NSDictionary*)getGroups{
	[self getTime];
	NSArray* vars = [NSArray arrayWithObjects:@"GetGroups",[self getAuthtoken], nil];
	NSArray* keys = [NSArray arrayWithObjects:@"command",@"authtoken", nil];
	
	NSDictionary* resDict =[[NSDictionary alloc] initWithDictionary:[self useApi:API_GROUPS varList:vars keyList:keys]];
	
	NSString *errorCode = [NSString stringWithFormat:@"%@",[resDict objectForKey:@"code"]];
	if ([errorCode isEqual:@"0"]) {
		NSLog(@"get groups.%@",resDict);
		return resDict;
	}else{
		return nil;
	}
}

-(NSDictionary*)getRegCode:(NSString*)groupId{
	[self getTime];
	NSArray* vars = [NSArray arrayWithObjects:@"GetRegCode", [self getAuthtoken], self.groupId, nil];
	NSArray* keys = [NSArray arrayWithObjects:@"command",@"authtoken",@"group_id", nil];
	
	NSDictionary* resDict =[[NSDictionary alloc] initWithDictionary:[self useApi:API_GROUPS varList:vars keyList:keys]];
	
	NSString *errorCode = [NSString stringWithFormat:@"%@",[resDict objectForKey:@"code"]];
	if ([errorCode isEqual:@"0"]) {
		//trueの処理
		return resDict;
	}else{
		//エラーの処理
		return nil;
	}
}

-(NSDictionary*)createGroupWithName:(NSString *)groupName{
	[self getTime];
	
	NSArray* vars = @[@"CreateGroup",[self getAuthtoken],groupName];
	NSArray* keys = @[@"command",@"authtoken",@"name"];
	
	return [self useApi:API_GROUPS varList:vars keyList:keys];
}

-(NSDictionary*)joinGroupWithRegCode:(NSString*)RegCode{
	[self getTime];
	
	NSArray* vars = @[@"JoinGroup",[self getAuthtoken],RegCode];
	NSArray* keys = @[@"command",@"authtoken",@"regcode"];
	
	return [self useApi:API_MEMBERS varList:vars keyList:keys];
}


// members
-(NSDictionary*)getMembers{
	NSLog(@"called get Members");
	[self getTime];
	
	NSArray* vars = @[@"GetMembers",[self getAuthtoken],self.groupId];
	NSArray* keys = @[@"command",@"authtoken",@"group_id"];
	
	//return [[NSDictionary alloc] initWithDictionary:[self useApi:API_MEMBERS varList:vars keyList:keys]];
	return [self useApi:API_MEMBERS varList:vars keyList:keys];
}

-(NSDictionary*)getMemberProfile{
	[self getTime];
	
	NSArray* vars = @[@"GetMemberProfile",[self getAuthtoken],self.memberId];
	NSArray* keys = @[@"command",@"authtoken",@"member_id"];
	
	//return [[NSDictionary alloc] initWithDictionary:[self useApi:API_MEMBERS varList:vars keyList:keys]];
	return [self useApi:API_MEMBERS varList:vars keyList:keys];

}

// notifications

-(NSDictionary*)getNotifications{
	
	[self getTime];
	NSArray* vars = [NSArray arrayWithObjects:@"GetNotifications",[self getAuthtoken],self.memberId, nil];
	NSArray* keys = [NSArray arrayWithObjects:@"command",@"authtoken",@"member_id", nil];
	
	NSDictionary* resdict = [[NSDictionary alloc] initWithDictionary:[self useApi:API_NOTIFICATIONS varList:vars keyList:keys]];
	NSLog(@"%@",resdict);
	return resdict;
}


//thread
-(NSDictionary*)getThreads{
	[self getTime];
	NSArray* vars = @[@"GetThreads",[self getAuthtoken],self.groupId];
	NSArray* keys = @[@"command",@"authtoken",@"group_id"];
	
	return [[NSDictionary alloc] initWithDictionary:[self useApi:API_THREADS varList:vars keyList:keys]];
}


//comment
-(NSDictionary*)getComments:(int)offset limit:(int)limit{
	[self getTime];
	
	NSString* off = [NSString stringWithFormat:@"%d",offset];
	NSString* lim = [NSString stringWithFormat:@"%d",limit];
	NSArray* vars = @[@"GetComments",[self getAuthtoken],self.threadId,off,lim];
	NSArray* keys = @[@"command",@"authtoken",@"thread_id",@"offset",@"limit"];
	
	
	return [[NSDictionary alloc] initWithDictionary:[self useApi:API_COMMENTS varList:vars keyList:keys]];
}


-(NSDictionary*)getCommentDetail{
	[self getTime];
	
	NSArray* vars = @[@"GetCommentDetail",[self getAuthtoken],self.commentId];
	NSArray* keys = @[@"command",@"authtoken",@"comment_id"];
	
	return [[NSDictionary alloc] initWithDictionary:[self useApi:API_COMMENTS varList:vars keyList:keys]];

}

-(NSDictionary*)createCommentWithTitle:(NSString *)title content:(NSString *)content{
	[self getTime];
	
	NSArray* vars = @[@"CreateComment",[self getAuthtoken],self.threadId,title,content,@"",@"",@""];
	NSArray* keys = @[@"command",@"authtoken",@"thread_id",@"title",@"content",@"filesize",@"filename",@"file"];
	
	return [[NSDictionary alloc] initWithDictionary:[self useApi:API_COMMENTS varList:vars keyList:keys]];

}

-(NSDictionary*)removeComment{
	[self getTime];
	
	NSArray* vars = @[@"RemoveComment",[self getAuthtoken],self.commentId];
	NSArray* keys = @[@"command",@"authtoken",@"comment_id"];
	
	return [[NSDictionary alloc] initWithDictionary:[self useApi:API_COMMENTS varList:vars keyList:keys]];
}






/*
 
 すべてのAPIに共通して行う処理．
 apiAddress:たたきたいAPIのアドレス，
 varList:bodyに付与するメッセージリスト(eex.@"GetTime")
 keys:対応するキーリスト（ex.@"command"）
 
 return:取得したJSONデータをそのままディクショナリにして返す．
 ex.{"code":0,"time":123123123123}
 
 *使い方テンプレ
 
 -(NSDictionary*)apiname{
 //onetimepass用に必ずtime更新
 [self getTime];
 NSArray* vars = @[@"GetThreads",[self getauthtoken],nil];
 NSArray* keys = @[@"command",@"authtoken",nil];
 
 return [[NSDictionary alloc] initWithDictionary:[self useApi:API_hoge varList:vars keyList:keys]];
 
 }
 
 */

-(NSDictionary*)useApi:(NSString *)apiAddress varList:(NSArray *)vars keyList:(NSArray *)keys
{
	//varとkeyの長さ確認
	NSLog(@"use api");
	if ([vars count] != [keys count]) {
		NSLog(@"diffrent length cars and keys.");
	}
	__block BOOL alertFinished = NO;
	__block NSDictionary *resDict;
	
	//リクエスト作成
	NSURL *url = [[NSURL alloc] initWithString:apiAddress];
	R9HTTPRequest *req = [[R9HTTPRequest alloc] initWithURL:url];
	[req setHTTPMethod:@"POST"];
	for (int i=0; i < [vars count]; i++) {
		NSLog(@"var:%@,key:%@",[vars objectAtIndex:i],[keys objectAtIndex:i]);
		[req addBody:[vars objectAtIndex:i] forKey:[keys objectAtIndex:i]];
	}
	[req setCompletionHandler:^(NSHTTPURLResponse *responseHeader, NSString *responseString){
		
		NSLog(@"response:%@",responseString);
		
		NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
		resDict = [NSJSONSerialization JSONObjectWithData:data
												  options:0
													error:nil];
		
		alertFinished = YES;
		
	}];
	
	[req startRequest];
	
	
	//loop wait
	alertFinished = NO;
	while (alertFinished == NO) {
		[[NSRunLoop currentRunLoop]
		 runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5f]]; //0.5秒
	}
	
	//コード確認
	// TODO:エラー処理もう少しキチンとしないとダメよ
	NSString *errorCode = [NSString stringWithFormat:@"%@",[resDict objectForKey:@"code"]];

	if (![errorCode isEqualToString:@"0"]) {
		NSLog(@"request error. error code %@.",[resDict objectForKey:@"code"]);
		return nil;
	}else{
		NSLog(@"request finished.");
		return resDict;
	}
}


- (NSString *)sha1fromString:(NSString *)inputStr {
    const char *str = [[inputStr lowercaseString] UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, strlen(str), result);
    return [[NSString
			 stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			 result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			 result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15],
			 result[16], result[17], result[18], result[19]] lowercaseString];
}

-(NSString*)getSha1withPassword{
	//NSString *time = [NSString stringWithFormat:@"%@",self.time];
	NSString *tmpStr = [NSString stringWithFormat:@"%@%@",self.time,[self sha1fromString:self.password]];
	return [self sha1fromString:tmpStr];
}

-(NSString*)getAuthtoken{
	NSString *authtoken = [NSString stringWithFormat:@"%@-%@-%@",self.userId,self.time,[self getSha1withPassword]];
	return  authtoken;
}

-(void)showUserData{
	NSLog(@"time:%@",self.time);
	NSLog(@"mail:%@",self.mailAddress);
	NSLog(@"pass:%@",self.password);
	NSLog(@"user:%@",self.userId);
}

@end
