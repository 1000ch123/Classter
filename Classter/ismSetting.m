//
//  ismSetting.m
//  Classter
//
//  Created by kanade on 13/04/01.,
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismSetting.h"

#define SETTING_CLASSTER 0
#define SETTING_USER 1

#define LOGIN 0
#define GROUP 1
#define PUSH 2
#define TERM 3
#define INVITE 4

#define NAME 0
#define MAIL 1
#define TEL 2
#define MEMO 3

@interface ismSetting ()

@end

@implementation ismSetting

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		self.ud = [[NSUserDefaults alloc]init];
		self.api = [[ismWebApi alloc]init];
        // Custom initialization
		self.title = @"環境設定";
		
		setting_classter = @[@"自動ログイン",@"グループ変更",@"プッシュ通知",@"学期設定",@"友人を招待"];
		setting_user = @[@"名前",@"メールアドレス",@"電話番号",@"メモ"];
		self.settingKeys = @[@"Classterの設定",@"ユーザ情報"];
		self.settingDict = @{self.settingKeys[SETTING_CLASSTER]:setting_classter,
					   self.settingKeys[SETTING_USER]:setting_user};
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [self.settingKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.settingDict[self.settingKeys[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
	static NSString* CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	NSString* cellLabel = self.settingDict[self.settingKeys[indexPath.section]][indexPath.row];
	
	// Configure the cell...
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero
									  reuseIdentifier:@"Cell"];
		
		
	}

	
	//from here
	/*
	if ([cellLabel isEqualToString:setting_classter[LOGIN]]) {
		NSLog(@"cellLabel:%@",cellLabel);
		UISwitch* sw = [[UISwitch alloc]init];
		if (![self.ud objectForKey:@"autoLoginAlreadySet"]) {
			sw.on = YES;
		}else{
			sw.on = [self.ud boolForKey:@"autoLogin"];
		}
		sw.center = CGPointMake(cell.frame.size.width - sw.frame.size.width * 0.8, cell.center.y);
		[sw addTarget:self
			   action:@selector(loginSwitchPushed:)
	 forControlEvents:UIControlEventValueChanged];
		[cell.contentView addSubview:sw];
	}
	*/
	// to here
	
	cell.textLabel.text = cellLabel;
	

	
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return self.settingKeys[section];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)loginSwitchPushed:(id)sender{
	UISwitch* sw = sender;
	NSLog(@"auto Login:%@",sw.on ? @"yes":@"no");
	[self.ud setBool:sw.on forKey:@"autoLogin"];
}

@end
