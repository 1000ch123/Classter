//
//  ismViewController.m
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismViewController.h"

@interface ismViewController ()

@end

@implementation ismViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self.view setBackgroundColor:[UIColor whiteColor]];
	
	int dif_y  =40;
	
	self.title = @"Login";
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	
	
	//タイトルラベル
	UILabel* label_classter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
	label_classter.text = @"Classter";
	[label_classter sizeToFit];
	CGPoint pt = self.view.center;
	pt.y = 20;
	label_classter.center = pt;
	
	//メルアドラベル
	CGRect rect = CGRectMake(50, 50, 220, 30);
	UILabel* label_mail = [[UILabel alloc] initWithFrame:rect];
	label_mail.text = @"Mail Address";
	[label_mail sizeToFit];
	
	//メルアドフィールド
	rect.origin.y += dif_y;
	UITextField* field_mail = [[UITextField alloc] initWithFrame:rect];
	if ([ud objectForKey:@"mailaddress"]) {
		field_mail.text = [ud objectForKey:@"mailaddress"];
		self.mailaddress = [ud objectForKey:@"mailaddress"];
	}else{
		field_mail.placeholder = @"メールアドレスを入力してください";
	}
	field_mail.borderStyle = UITextBorderStyleRoundedRect;
    field_mail.keyboardType = UIKeyboardTypeDefault;
    field_mail.returnKeyType = UIReturnKeyDefault;
    field_mail.clearButtonMode = UITextFieldViewModeWhileEditing;
    // デリゲートを設定
    field_mail.delegate = self;
	field_mail.tag = MAILADDRESS;
	
	//パスワードラベル
	rect.origin.y += dif_y;
	UILabel* label_pass = [[UILabel alloc] initWithFrame:rect];
	label_pass.text = @"Password";
	[label_mail sizeToFit];
	
	//パスワードフィールド
	rect.origin.y += dif_y;
	UITextField* field_pass = [[UITextField alloc] initWithFrame:rect];
	field_pass.frame = rect;
	if ([ud objectForKey:@"password"]) {
		field_pass.text = [ud objectForKey:@"password"];
		self.password = [ud objectForKey:@"password"];
	}else{
		field_pass.placeholder = @"パスワードを入力してください";
	}
	field_pass.borderStyle = UITextBorderStyleRoundedRect;
	
	field_pass.keyboardType = UIKeyboardTypeDefault;
    field_pass.returnKeyType = UIReturnKeyDefault;
    field_pass.clearButtonMode = UITextFieldViewModeWhileEditing;
    // デリゲートを設定
    field_pass.delegate = self;
	field_pass.tag = PASSWORD;
	
	
	//オートログインモード表示
	if ([ud boolForKey:@"autoLogin"]) {
		UILabel* autoLogin = [[UILabel alloc]initWithFrame:CGRectMake(100, 250, 100, 20)];
		autoLogin.text = @"AutoLogin...";
		[autoLogin sizeToFit];
		CGPoint pt = CGPointMake(autoLogin.center.x, self.view.center.y);
		autoLogin.center =  pt;
		[self.view addSubview:autoLogin];
	}
	
	//ログインボタン
	rect.origin.y += dif_y;
	//rect.origin.x += 0;
	UIButton* button_login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button_login setTitle:@"Login" forState:UIControlStateNormal];
	[button_login sizeToFit];
	
	pt = self.view.center;
	pt.y += 100;
	button_login.center = pt;
	
	[button_login addTarget:self
						  action:@selector(button_login_pushed)
				forControlEvents:UIControlEventTouchUpInside];
	
	
	//ビューに追加！
	[self.view addSubview:label_classter];
	[self.view addSubview:label_mail];
	[self.view addSubview:field_mail];
	[self.view addSubview:label_pass];
	[self.view addSubview:field_pass];
	[self.view addSubview:button_login];
	
}


-(void)viewDidAppear:(BOOL)animated{
	//オートログイン
	NSUserDefaults* ud = [[NSUserDefaults alloc]init];
	
	NSLog(@"autologin:%@",[ud objectForKey:@"autoLogin"]);
	NSLog(@"autologinAlreadySet:%@",[ud objectForKey:@"autoLoginAlreadySet"]);
	
	if (![ud boolForKey:@"autoLoginAlreadySet"]) {
		NSLog(@"set auto login:true");
		[ud setBool:YES forKey:@"autoLogin"];
		[ud setBool:YES forKey:@"autoLoginAlreadySet"];
	}
	
	if (([ud boolForKey:@"autoLogin"]) && (self.mailaddress && self.password)) {
		[self button_login_pushed];
	}
}

-(void)button_login_pushed{
	
	// エラー表示用アラートビュー準備
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ログインエラー"
													message:@""
												   delegate:self
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	
	//メルアド，パスワードが入力されているか確認
	if (!self.mailaddress || !self.password) {
		NSLog(@"please fill the  entryform");
		alert.message = @"メールアドレス，パスワードを入力してください";
		[alert show];
		return;
	}
	
	// webApi用設定
	ismWebApi *api = [[ismWebApi alloc] init];
	api.mailAddress = self.mailaddress;
	api.password = self.password;
	
	
	//通信中インジケータ準備
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]
										  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	indicator.frame = CGRectMake(0, 0, 50, 50);
	indicator.center = self.view.center;
	[self.view addSubview:indicator];

	//通信インジケータ開始
	[indicator startAnimating];
	
	//HTTPリクエスト開始
	NSDictionary* resDict;
	resDict = [api getTime];
	if(!resDict){
		NSLog(@"get time error");
		[indicator stopAnimating];
		alert.message = @"GetTimeError";
		[alert show];
		return;
	}
	resDict = [api getUserId];
	if(!resDict){
		NSLog(@"get user id error");
		[indicator stopAnimating];
		alert.message = @"ログインに失敗しました¥nメールアドレス，パスワードを確認してください";
		[alert show];
		return;
	}
		//取得データを保存（ユーザID）
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	[ud setObject:[resDict objectForKey:@"user_id"] forKey:@"user_id"];
	
	//通信インジケータ終了
	[indicator stopAnimating];
	
	//次の画面へ移動
	NSLog(@"login success");
	ismClassSelect *classSelect = [[ismClassSelect alloc] init];
	[self.navigationController pushViewController:classSelect animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	switch (textField.tag) {
		case MAILADDRESS:
			self.mailaddress = textField.text;
			[ud setObject:textField.text forKey:@"mailaddress"];
			break;
		case PASSWORD:
			self.password = textField.text;
			[ud setObject:textField.text forKey:@"password"];
			break;
		default:
			break;
	}
    // キーボードを隠す
	[self.view endEditing:YES];
	
    return YES;
}

@end
