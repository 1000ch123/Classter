//
//  ismClassSelect.m
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismClassSelect.h"


@interface ismClassSelect ()

@end

@implementation ismClassSelect

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
		self.title = @"Group Select";
		
		//API使う準備
		self.api = [[ismWebApi alloc]init];
		self.api.mailAddress = [ud objectForKey:@"mailaddress"];
		self.api.password = [ud objectForKey:@"password"];
		self.api.userId = [ud objectForKey:@"user_id"];
		


		UIBarButtonItem* addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																				  target:self
																				  action:@selector(addButtonPushed)];
		self.navigationItem.rightBarButtonItem = addButton;
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
	//グループリスト取得
	[self.api getTime];
	
	//NSString* dir = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/groups.dat"];
	NSString* dir = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
	NSString* filepath = [dir stringByAppendingPathComponent:@"groups"];
	NSMutableArray* groupArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
	if (groupArray) {
		NSLog(@"success");
	}else{
		NSLog(@"failed.loading");
		groupArray = [[self.api getGroups] objectForKey:@"groups"];
	}
	self.array = groupArray;
	
	NSData* tmpGroupData = [NSKeyedArchiver archivedDataWithRootObject:groupArray];
	[NSKeyedArchiver archiveRootObject:tmpGroupData toFile:dir];
	
	[self.tableView reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];// forIndexPath:indexPath];
    
    // Configure the cell...
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero
									  reuseIdentifier:@"Cell"];
	}
	NSLog(@"%@",self.array);
	cell.textLabel.text = [[self.array objectAtIndex:indexPath.row] objectForKey:@"groupname"];
	
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

-(void)addButtonPushed{
	ismClassAdd* controller = [[ismClassAdd alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
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
	
	
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	NSDictionary* tmpGroup = [self.array objectAtIndex:indexPath.row];
	
	[ud setObject:[tmpGroup objectForKey:@"group_id"] forKey:@"group_id"];
	[ud setObject:[tmpGroup objectForKey:@"groupname"] forKey:@"groupname"];
	[ud setObject:[tmpGroup objectForKey:@"member_id"] forKey:@"member_id"];
	
	//NSLog(@"output test");
	//NSLog(@"obj:%@",[ud objectForKey:@"tmpGroup"]);
	//NSLog(@"obj_inner:%@",[[ud objectForKey:@"tmpGroup"]objectForKey:@"groupname"]);

	ismMainTabController *tab = [[ismMainTabController alloc] init];
	[self.navigationController setNavigationBarHidden:YES];
	[self.navigationController pushViewController:tab animated:YES];
	
}

@end
