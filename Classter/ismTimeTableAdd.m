//
//  ismTimeTableAdd.m
//  Classter
//
//  Created by kanade on 13/04/05.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismTimeTableAdd.h"

@interface ismTimeTableAdd ()

@end

@implementation ismTimeTableAdd

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		self.ud = [NSUserDefaults standardUserDefaults];
		//API使う準備
		self.api = [[ismWebApi alloc]init];
		self.api.mailAddress = [self.ud objectForKey:@"mailaddress"];
		self.api.password = [self.ud objectForKey:@"password"];
		self.api.userId = [self.ud objectForKey:@"user_id"];
		self.api.groupId = [self.ud objectForKey:@"group_id"];
		self.api.memberId = [self.ud objectForKey:@"member_id"];
		self.api.threadId = [self.ud objectForKey:@"thread_id"];

		
        // Custom initialization
		terms = @[@"2013-1",@"2013-2",@"2013-3",@"2013-4"];
		categories = @[@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT",@"ETC"];
		subcategories = @[@"1st",@"2nd",@"3rd",@"4th",@"5th",@"6th",@"ETC"];
		
		dataList = @[terms,categories,subcategories];
		
		lessonTitle = @"";
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

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 3;//[dataList[component]count];;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [dataList[component]count];
}

// 表示する内容を返す例
-(NSString*)pickerView:(UIPickerView*)pickerView
		   titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	
	// 行インデックス番号を返す
	return [NSString stringWithFormat:@"%@", dataList[component][row]];
	
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	lessonTitle = textField.text;
	[textField resignFirstResponder];
	return YES;
}

- (IBAction)registerLesson:(id)sender {
	UIAlertView* alert= [[UIAlertView alloc]init];
	alert.delegate = self;
	
	if ([lessonTitle isEqualToString:@""]) {
		alert.title = @"授業追加エラー";
		alert.message = @"授業名を入力してください";
		[alert addButtonWithTitle:@"OK"];
		[alert show];
		return;
	}
	NSLog(@"授業%@を登録するよ",lessonTitle);
	alert.title = @"授業の追加";
	
	addTerm = terms[[self.picker selectedRowInComponent:0]];
	addCategory = categories[[self.picker selectedRowInComponent:1]];
	addSubCategory = subcategories[[self.picker selectedRowInComponent:2]];
	alert.message = [NSString stringWithFormat:@"%@:%@:%@の授業[%@]を追加しますか？",addTerm,addCategory,addSubCategory,lessonTitle];
	[alert addButtonWithTitle:@"Cancel"];
	[alert addButtonWithTitle:@"OK"];
	[alert setCancelButtonIndex:0];
	
	[alert show];
	
	return;
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == alertView.cancelButtonIndex) {
		NSLog(@"canceled");
		return;
	}
	NSLog(@"add lesson!");
	//授業addする
	[self.api createThreadWithName:lessonTitle term:addTerm category:addCategory subcaegory:addSubCategory];
	
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButton:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
	return;
}


@end
