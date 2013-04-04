//
//  ismTimeTableCommentPost.h
//  Classter
//
//  Created by kanade on 13/04/03.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TITLE_FIELD 0
#define CONTENT_FIELD 1

@interface ismTimeTableCommentPost : UIViewController{
	NSString* title;
	NSString* content;
	UITextView* contentField;
}

@property NSUserDefaults* ud;
@property ismWebApi *api;

@end
