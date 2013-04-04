//
//  ismTimeTableCommentPost.m
//  Classter
//
//  Created by kanade on 13/04/03.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismTimeTableCommentPost.h"

@interface ismTimeTableCommentPost ()

@end

@implementation ismTimeTableCommentPost

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		// Custom initialization
		self.ud = [NSUserDefaults standardUserDefaults];
		//API使う準備
		self.api = [[ismWebApi alloc]init];
		self.api.mailAddress = [self.ud objectForKey:@"mailaddress"];
		self.api.password = [self.ud objectForKey:@"password"];
		self.api.userId = [self.ud objectForKey:@"user_id"];
		self.api.groupId = [self.ud objectForKey:@"group_id"];
		self.api.memberId = [self.ud objectForKey:@"member_id"];
		self.api.threadId = [self.ud objectForKey:@"thread_id"];
		
		NSLog(@"post to thread:%@",self.api.threadId);

		//背景色
		[self.view setBackgroundColor:[UIColor whiteColor]];

		//タイトルラベル
		CGRect rect = CGRectMake(20, 20, 100, 20);
		UILabel* titleLabel = [[UILabel alloc]initWithFrame:rect];
		titleLabel.text = @"タイトル";
		[titleLabel sizeToFit];
		
		//タイトルフィールド
		rect.origin.y += 30;
		rect.size.width = 250;
		UITextField* titleField = [[UITextField alloc]initWithFrame:rect];
		titleField.placeholder = @"タイトルを入力してください";
		titleField.borderStyle = UITextBorderStyleRoundedRect;
		titleField.keyboardType = UIKeyboardTypeDefault;
		titleField.returnKeyType = UIReturnKeyDefault;
		titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
		
		titleField.delegate = self;
		titleField.tag = TITLE_FIELD;
		
		//本文ラベル
		rect.origin.y += 30;
		UILabel* contentLabel = [[UILabel alloc]initWithFrame:rect];
		contentLabel.text = @"本文";
		[contentLabel sizeToFit];
		
		
		//本文フィールド
		rect.origin.y += 30;
		rect.size.height = 130;
		contentField = [[UITextView alloc]initWithFrame:rect];
		contentField.text = @"本文を入力してください";
		
		
		contentField.keyboardType = UIKeyboardTypeDefault;
		contentField.returnKeyType = UIReturnKeyDefault;
		
		UIView* accessoryView =[[UIView alloc] initWithFrame:CGRectMake(0,0,320,50)];
		accessoryView.backgroundColor = [UIColor clearColor];
		
		// ボタンを作成する。
		UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		closeButton.frame = CGRectMake(210,10,100,30);
		[closeButton setTitle:@"close" forState:UIControlStateNormal];
		// ボタンを押したときによばれる動作を設定する。
		[closeButton addTarget:self
						action:@selector(closeKeyboard:)
			  forControlEvents:UIControlEventTouchUpInside];
		// ボタンをViewに貼る
		[accessoryView addSubview:closeButton];
		
		contentField.inputAccessoryView = accessoryView;
		
//		contentField.delegate
		
		
		//添付ファイルラベル
		rect.origin.y += 130;
		UILabel* fileLabel = [[UILabel alloc]initWithFrame:rect];
		fileLabel.text = @"添付ファイル -comming soon-";
		[fileLabel sizeToFit];
		
		//添付ファイルフィールド
		
		
		//ポストボタン
		rect.origin.x = 200;
		rect.origin.y += 40;
		rect.size.width = 50;
		rect.size.height = 30;
		UIButton* pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		pushButton.frame = rect;
		[pushButton setTitle:@"post" forState:UIControlStateNormal];
		[pushButton addTarget:self
					   action:@selector(postComment:)
			 forControlEvents:UIControlEventTouchUpInside];
		
		//キャンセルボタン
		rect.origin.x = 20;
		UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		cancelButton.frame = rect;
		[cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
		[cancelButton addTarget:self
						 action:@selector(cancelPost:)
			   forControlEvents:UIControlEventTouchUpInside];
		
		//ビューに追加
		[self.view addSubview:titleLabel];
		[self.view addSubview:titleField];
		[self.view addSubview:contentLabel];
		[self.view addSubview:contentField];
		[self.view addSubview:fileLabel];
		[self.view addSubview:pushButton];
		[self.view addSubview:cancelButton];
		
		[titleField becomeFirstResponder];
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

-(void)textFieldDidEndEditing:(UITextField*)textField{
	title = textField.text;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
	title = textField.text;
	[textField resignFirstResponder];
	//[self.view endEditing:YES];
	return YES;
}

-(void)closeKeyboard:(id)sender{
	NSLog(@"close!");
	[contentField resignFirstResponder];
}


-(void)postComment:(id)sender{
	if (title == nil) {
		title = @"";
	}
	if (contentField == nil) {
		contentField = @"";
	}
	
	NSLog(@"post pushed");
	NSLog(@"title:%@¥ncontent:%@",title,contentField.text);
	
	NSLog(@"thread_id:%@",[self.ud objectForKey:@"thread_id"]);
	NSLog(@"thread_id_tmp:%@",self.api.threadId);
	[self.api createCommentWithTitle:title content:contentField.text];
	
	//[self.navigationController popToRootViewControllerAnimated:YES];
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancelPost:(id)sender{
	NSLog(@"post cancel");
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
