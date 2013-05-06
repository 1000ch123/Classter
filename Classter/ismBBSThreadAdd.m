//
//  ismBBSThreadAdd.m
//  Classter
//
//  Created by kanade on 13/04/06.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismBBSThreadAdd.h"

@interface ismBBSThreadAdd ()

@end

@implementation ismBBSThreadAdd

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		
		self.ud = [[NSUserDefaults alloc]init];
		self.api =[[ismWebApi alloc]init];
		
		self.api.mailAddress	= [self.ud objectForKey:@"mailaddress"];
		self.api.password		= [self.ud objectForKey:@"password"];
		self.api.userId			= [self.ud objectForKey:@"user_id"];
		self.api.groupId		= [self.ud objectForKey:@"group_id"];
		self.api.memberId		= [self.ud objectForKey:@"member_id"];
		
		titleString = @"";
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

- (IBAction)returnButton:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addButton:(id)sender {
	UIAlertView* alert = [[UIAlertView alloc]init];
	alert.delegate = self;
	alert.title = @"スレッドの追加";
	alert.message = [NSString stringWithFormat:@"スレッド[%@]を追加しますか？",titleString];
	[alert addButtonWithTitle:@"cancel"];
	[alert addButtonWithTitle:@"OK"];
	[alert setCancelButtonIndex:0];
	[alert show];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == alertView.cancelButtonIndex) {
		return;
	}
	[self addThread];
}

-(void)addThread{
	[self.api createThreadWithName:titleString term:@"BBS" category:@"BBS" subcaegory:@"BBS"];
	[_ud setBool:YES forKey:@"reloadData"];
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	titleString = textField.text;
	[textField resignFirstResponder];
	return YES;
}


@end
