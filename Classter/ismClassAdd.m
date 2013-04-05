//
//  ismClassAdd.m
//  Classter
//
//  Created by kanade on 13/04/05.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismClassAdd.h"

#define ADD_FIELD 0
#define JOIN_FIELD 1

#define ADD_ALERT 0
#define JOIN_ALERT 1

@interface ismClassAdd ()

@end

@implementation ismClassAdd


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		addGroupName = @"";
		joinGroupCode = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButton:(id)sender {
	
	UIAlertView* alert = [[UIAlertView alloc] init];
	alert.title = @"新規クラスの追加";
	if ([addGroupName isEqualToString:@""]) {
		alert.message = @"追加したいクラスの名前を入力してください";
		[alert addButtonWithTitle:@"OK"];
		[alert show];
		return;
	}
	NSLog(@"新規グループ「%@」を追加するよ",addGroupName);
	
	alert.delegate = self;
	alert.message = [NSString stringWithFormat: @"%@を新規クラスとして追加しますか？",addGroupName];
	[alert addButtonWithTitle:@"いいえ"];
	[alert addButtonWithTitle:@"はい"];
	alert.cancelButtonIndex = 0;
	alert.tag = ADD_ALERT;
	[alert show];
}

- (IBAction)joinButton:(id)sender {
	NSLog(@"グループコード[%@]に参加するよ",joinGroupCode);
	UIAlertView* alert = [[UIAlertView alloc] init];
	alert.delegate = self;
	alert.title = @"既存クラスの参加";
	alert.message = [NSString stringWithFormat: @"クラス[%@]に参加しますか？",addGroupName];
	[alert addButtonWithTitle:@"いいえ"];
	[alert addButtonWithTitle:@"はい"];
	alert.cancelButtonIndex = 0;
	alert.tag = JOIN_ALERT;
	[alert show];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == alertView.cancelButtonIndex) {
		return;
	}
	
	NSUserDefaults* ud = [[NSUserDefaults alloc]init];
	ismWebApi* api = [[ismWebApi alloc]init];
	
	api.userId = [ud objectForKey:@"user_id"];
	api.password = [ud objectForKey:@"password"];
	api.mailAddress = [ud objectForKey:@"mailaddress"];
	
	switch (alertView.tag) {
		case ADD_ALERT:
			NSLog(@"追加しますた");
			[api createGroupWithName:addGroupName];
			break;
		case JOIN_ALERT:
			NSLog(@"参加しますた");
			[api joinGroupWithRegCode:joinGroupCode];
			break;
		default:
			break;
	}
	[self.navigationController popViewControllerAnimated:YES];
	return;
}

-(void)textFieldShouldReturn:(UITextField*)textField{
	NSLog(@"textFieldshouldReturn called");
	if (textField.tag == ADD_FIELD) {
		addGroupName = textField.text;
	}else if(textField.tag == JOIN_FIELD){
		joinGroupCode = textField.text;
	}
	[textField resignFirstResponder];
}
@end
