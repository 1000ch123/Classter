//
//  ismWebApi.h
//  WebApiTest5
//
//  Created by kanade on 13/03/31.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <Foundation/Foundation.h>

#import"R9HTTPRequest/R9HTTPRequest.h"
#import <CommonCrypto//CommonDigest.h>

#import "ismGroup.h"
#import "ismMember.h"
#import "ismThread.h"
#import "ismComment.h"

#define API_COMMON			@"http://devnextversion.classter.jp/api/common"
#define API_GROUPS			@"http://devnextversion.classter.jp/api/groups"
#define API_MEMBERS			@"http://devnextversion.classter.jp/api/members"
#define API_NOTIFICATIONS	@"http://devnextversion.classter.jp/api/notifications"
#define API_THREADS			@"http://devnextversion.classter.jp/api/threads"
#define API_COMMENTS		@"http://devnextversion.classter.jp/api/comments"


@interface ismWebApi : NSObject

//state data
@property NSString* time;

//user data
@property NSString* userId;
@property NSString* password;
@property NSString* mailAddress;
@property NSString* groupId;
@property NSString* memberId;
@property NSString* threadId;
@property NSString* commentId;

-(id)initWithAddress:(NSString*)mail password:(NSString*)pass;

//common
-(NSDictionary*)getTime;
-(NSDictionary*)getUserId;

//group
-(NSDictionary*)getGroups;
-(NSDictionary*)createGroupWithName:(NSString*)groupName;
-(NSDictionary*)joinGroupWithRegCode:(NSString*)RegCode;
-(NSDictionary*)getRegCode;
-(NSDictionary*)changeRegCode;

//member

//memberIdをupdateしてからよぶこと．
-(NSDictionary*)getMembers;
-(NSDictionary*)getMemberProfile;
-(NSDictionary*)updateMemberProfile;
-(NSDictionary*)enableMember;
-(NSDictionary*)disableMember;
-(NSDictionary*)setAdmin;
-(NSDictionary*)unsetAdmin;

//notification
-(NSDictionary*)getNotifications;

//thread

-(NSDictionary*)getThreads;//掲示板ページ遷移時.グループIDからスレッド特定
-(NSDictionary*)getThreadDetail; //いつよぶ？
-(NSDictionary*)createThreadWithName:(NSString*)threadName
								term:(NSString*)term
							category:(NSString*)cat
						  subcaegory:(NSString*)subcat;
-(NSDictionary*)updateThread;
-(NSDictionary*)removeThread;


//comment
-(NSDictionary*)getComments:(int) offset limit:(int) limit;
-(NSDictionary*)getCommentDetail;
-(NSDictionary*)createCommentWithTitle:(NSString*)title content:(NSString*)content;
-(NSDictionary*)updateCommentWithTitle:(NSString*)title content:(NSString*)content;
-(NSDictionary*)removeComment;
-(NSDictionary*)likeComment;

//util

-(NSDictionary*)useApi:(NSString*)apiAddress varList:(NSArray*)vars keyList:(NSArray*)keys;

-(NSString *)sha1fromString:(NSString *)inputStr;
-(NSString*)getSha1withPassword;
-(NSString*)getAuthtoken;

-(void)showUserData;

@end
