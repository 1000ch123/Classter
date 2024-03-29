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
#define ENTRANCE 3
#define TERM 4
#define INVITE 5
#define CLASSTER_CELLS 6

#define NAME 0
#define MAIL 1
#define TEL 2
#define MEMO 3
#define USER_CELLS 4

#define CELL_ORIGINAL	0
#define CELL_TEXT		1

@interface ismSetting ()

@end

@implementation ismSetting

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		self.ud = [[NSUserDefaults alloc]init];
		self.api = [[ismWebApi alloc]init];
		
		//api準備
		self.api.mailAddress = [self.ud objectForKey:@"mailaddress"];
		self.api.password = [self.ud objectForKey:@"password"];
		self.api.userId = [self.ud objectForKey:@"user_id"];
		self.api.groupId = [self.ud objectForKey:@"group_id"];
		self.api.memberId = [self.ud objectForKey:@"member_id"];
		
        // Custom initialization
		self.title = @"環境設定";
		
		setting_classter	= @[@"自動ログイン",@"グループ変更",@"プッシュ通知",@"入学年度",@"学期設定",@"友人を招待"];
		setting_user		= @[@"名前",@"メールアドレス",@"電話番号",@"メモ"];
		self.settingKeys	= @[@"Classterの設定",@"ユーザ情報"];
		self.settingDict	= @{self.settingKeys[SETTING_CLASSTER]:setting_classter,
								self.settingKeys[SETTING_USER]:setting_user};
		
		userData = [self.api getMemberProfile][@"member"];
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
	
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	[self.tableView registerClass:[ismCellTextField class] forCellReuseIdentifier:@"ismCellTextField"];
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
    
	// Configure the cell...
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
									  reuseIdentifier:@"Cell"];
	}
	
	 
	
	//from here
	/*
	int cellMode[CLASSTER_CELLS][USER_CELLS] = {
		{CELL_ORIGINAL,CELL_ORIGINAL,CELL_ORIGINAL,CELL_ORIGINAL,CELL_ORIGINAL,CELL_ORIGINAL},
		{CELL_TEXT,CELL_TEXT,CELL_TEXT,CELL_TEXT}
	};
	
	NSLog(@"make cell");
	int tmpCellMode = cellMode[indexPath.section][indexPath.row];
	
	NSString* cellIdentifier = @"";
	
	switch (tmpCellMode) {
		case CELL_ORIGINAL:
			NSLog(@"in to origin");
			cellIdentifier = @"cell";
			break;
		case CELL_TEXT:
			NSLog(@"in to text");
			cellIdentifier = @"ismCellTextField";
			break;
		default:
			NSLog(@"in to default");
			break;
	}
	
	NSLog(@"make %@ cell",cellIdentifier);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    */
	// to here

	NSString* cellLabel = self.settingDict[self.settingKeys[indexPath.section]][indexPath.row];
	cell.textLabel.text = cellLabel;
	
	switch (indexPath.section) {
		case SETTING_CLASSTER:
			switch (indexPath.row) {
				case LOGIN:
					cell.detailTextLabel.text = [self.ud boolForKey:@"autoLogin"] ? @"有効":@"無効";
					break;
				case GROUP:
					cell.detailTextLabel.text = [self.ud objectForKey:@"groupname"];

					break;
				case PUSH:
					cell.detailTextLabel.text = [self.ud boolForKey:@"bPushNotification"] ? @"有効":@"無効";
					break;
				case ENTRANCE:
					cell.detailTextLabel.text = [self.ud objectForKey:@"entrance"];
					break;
				case TERM:
					cell.detailTextLabel.text = [self.ud objectForKey:@"term"];
					break;
				case INVITE:
					//セルに表示はなし
					break;
				default:
					break;
			}
			break;
		case SETTING_USER:
			switch (indexPath.row) {
				case NAME:
					cell.detailTextLabel.text = userData[@"name"];
					//cell.textField.text = userData[@"name"];
					
					break;
				case MAIL:
					cell.detailTextLabel.text = userData[@"email"];
					//cell.textField.text = userData[@"email"];
					break;
				case TEL:
					if ([userData[@"tel_no"] isEqualToString:@""]) {
						cell.detailTextLabel.text = @"登録してください";
					}else{
						cell.detailTextLabel.text = userData[@"tel_no"];
					}
					break;
				case MEMO:
					if ([userData[@"notes"] isEqualToString:@""]) {
						cell.detailTextLabel.text = @"登録してください";
					}else{
						cell.detailTextLabel.text = userData[@"notes"];
					}
					break;
					
				default:
					break;
			}
			break;
		default:
			break;
	}


	
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
	
	BOOL tmpBool;
	switch (indexPath.section) {
		case SETTING_CLASSTER:
			switch (indexPath.row) {
				case LOGIN:
					tmpBool = [self.ud boolForKey:@"autoLogin"];
					[self.ud setBool:!tmpBool forKey:@"autoLogin"];
					[self.tableView reloadData];
					break;
				case GROUP:
					//ピッカービュー
					break;
				case PUSH:
					tmpBool = [self.ud boolForKey:@"bPushNotification"];
					[self.ud setBool:!tmpBool forKey:@"bPushNotification"];
					[self.tableView reloadData];
					break;
				case ENTRANCE:
					//割と固定なきがする
					break;
				case TERM:
					//ピッカービュー
					break;
				case INVITE:
					//メール起動
					break;
				default:
					break;
			}
			break;
		case SETTING_USER:
			switch (indexPath.row) {
				case NAME:
					
					break;
				case MAIL:
					
					break;
				case TEL:
					
					break;
				case MEMO:
					
					break;
					
				default:
					break;
			}
			break;
		default:
			break;
	}
}

-(void)loginSwitchPushed:(id)sender{
	UISwitch* sw = sender;
	NSLog(@"auto Login:%@",sw.on ? @"yes":@"no");
	[self.ud setBool:sw.on forKey:@"autoLogin"];
}

@end
