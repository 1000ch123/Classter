//
//  ismTimeTableCommentDetail.m
//  Classter
//
//  Created by kanade on 13/04/03.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismTimeTableCommentDetail.h"

@interface ismTimeTableCommentDetail ()

@end

@implementation ismTimeTableCommentDetail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		[self.view setBackgroundColor:[UIColor whiteColor]];
		
		// Custom initialization
		self.ud = [NSUserDefaults standardUserDefaults];
		//API使う準備
		self.api = [[ismWebApi alloc]init];
		self.api.mailAddress = [self.ud objectForKey:@"mailaddress"];
		self.api.password = [self.ud objectForKey:@"password"];
		self.api.userId = [self.ud objectForKey:@"user_id"];
		self.api.groupId = [self.ud objectForKey:@"group_id"];
		self.api.memberId = [self.ud objectForKey:@"member_id"];
		self.api.commentId = [self.ud objectForKey:@"comment_id"];
		
		NSDictionary* tmpComment = [self.api getCommentDetail][@"comment"];
		NSLog(@"%@",tmpComment);
		
		//タイトルラベル
		CGRect rect = CGRectMake(20, 20, 100, 30);
		UILabel* titleLabel = [[UILabel alloc]initWithFrame:rect];
		//titleLabel.text = @"title";
		titleLabel.text = [NSString stringWithFormat:@"%@",tmpComment[@"title"]];
		[titleLabel sizeToFit];
		
		//本文ビュー
		rect.origin.y += 40;
		rect.size.height = 200;
		rect.size.width = 200;
		UITextView* content = [[UITextView alloc] initWithFrame:rect];
		//content.text = @"contentcontent";
		content.text = [NSString stringWithFormat:@"%@",tmpComment[@"content"]];
		[content sizeToFit];
		
		//viewに追加
		[self.view addSubview:titleLabel];
		[self.view addSubview:content];
		
		UIBarButtonItem* trashButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeButtonPushed)];
		self.navigationItem.rightBarButtonItem = trashButton;
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)removeButtonPushed{
	//アラート表示．本当に消すか確認
	[self removePost];
}

-(void)removePost{
	[self.api removeComment];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

@end
