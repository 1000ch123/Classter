//
//  ismTimeTable.m
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismTimeTable.h"

@interface ismTimeTable ()

@end

@implementation ismTimeTable

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		
		self.ud = [NSUserDefaults standardUserDefaults];
		//API使う準備
		self.api = [[ismWebApi alloc]init];
		self.api.mailAddress = [self.ud objectForKey:@"mailaddress"];
		self.api.password = [self.ud objectForKey:@"password"];
		self.api.userId = [self.ud objectForKey:@"user_id"];
		self.api.groupId = [self.ud objectForKey:@"group_id"];
		self.api.memberId = [self.ud objectForKey:@"member_id"];
		
		if ([self.ud objectForKey:@"term"]==NULL) {
			NSLog(@"no term registered");
			[self.ud setObject:@"2013-1" forKey:@"term"];
		}
		
		NSString* groupname = [self.ud objectForKey:@"groupname"];
		self.title = @"時間割";
		self.navigationItem.title = [NSString stringWithFormat:@"%@の時間割",groupname];
		
		//授業リスト取得
		NSDictionary* resdict = [self.api getThreads];
		NSArray* allthreads = [resdict objectForKey:@"threads"];
		
		categories = @[@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT",@"ETC"];
		subcategories = @[@"1st",@"2nd",@"3rd",@"4th",@"5th",@"6th",@"ETC"];
		
		
		//授業データ保持インスタンス作成
		//2段ディクショナリでNSMutableArrayを保持する.まずは場所確保だけ．
		NSMutableDictionary* lessons = [[NSMutableDictionary alloc]init];
		for (NSString* key in categories) {
			NSMutableDictionary* tmpDict = [[NSMutableDictionary alloc]init];
			for (NSString* subkey in subcategories) {
				NSMutableArray* array = [[NSMutableArray alloc] init];
				[tmpDict setObject:array forKey:subkey];
			}
			[lessons setObject:tmpDict forKey:key];
		}
	
		
		//授業かうんとテーブル初期化
		/*
		for (int i=0; i<MAX_CATEGORY; i++) {
			for (int j=0; j<MAX_SUBCATEGORY; j++) {
				countTable[i][j] = 0;
			}
		}*/
		
		//スレッドデータパース.lessonDictを作る
		for (NSDictionary* thread in allthreads) {
			NSString* key = thread[@"category"];
			NSString* subkey = thread[@"subcategory"];
			
			//TODO:
			
			//ここで指定termかどうかを確認する．
			//指定じゃなかったらcontinue
		
			//to here
			
			[lessons[key][subkey] addObject:thread];

			int tmpThreads = [lessons[key][subkey] count];
			NSDictionary* tmpThread = lessons[key][subkey][tmpThreads-1];
			NSLog(@"lesson:%@ time:%@-%@",tmpThread[@"name"],tmpThread[@"category"],tmpThread[@"subcategory"]);
		}
		
		
		//リスト化する.
		NSMutableDictionary* lessonList = [[NSMutableDictionary alloc]init];
		for (int i=0; i<[categories count]; i++) {
			NSMutableArray* tmpArray = [[NSMutableArray alloc]init];
			for (int j=0; j<[subcategories count]; j++) {
				for (NSDictionary* thread in lessons[categories[i]][subcategories[j]]) {
					[tmpArray addObject:thread];
				}
			}
		[lessonList setObject:tmpArray forKey:categories[i]];
		}
		self.LessenDict = lessons;
		self.LessonListDict = lessonList;
		
		
		UIBarButtonItem* plus = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																			 target:self
																			 action:@selector(addButtonPushed)];
		self.navigationItem.rightBarButtonItem = plus;
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
    return [self.LessenDict count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
	// TODO:授業数取得
	
	/*
	NSMutableArray* tmpArray = [[NSMutableArray alloc]init];
	
	//NSLog(@"sectionNo:%d",section);
	NSString* key = categories[section];
	for (int i=0; i<[subcategories count]; i++) {
		NSString* subKey = subcategories[i];
		NSArray* a = self.LessenDict[key][subKey];
		if (tmplessons) {
			for (NSDictionary* thread in tmplessons) {
				[tmpArray addObject:thread];
			}
		}
	}
    return [tmpArray count];
	 */
	
	return [self.LessonListDict[categories[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	// Configure the cell...
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									  reuseIdentifier:@"Cell"];
	}
	//NSLog(@"%@",self.array);
	
	/*
	NSMutableArray* tmpArray = [[NSMutableArray alloc]init];

	NSString* key = categories[indexPath.section];
	for (int i=0; i<[subcategories count]; i++) {
		NSString* subKey = subcategories[i];
		NSArray* tmplessons = self.LessenDict[key][subKey];
		if (tmplessons) {
			for (NSDictionary* thread in tmplessons) {
				[tmpArray addObject:thread];
			}
		}
	}
	 
	 cell.textLabel.text = self.LessonListDict[indexPath.section][indexPath.row][@"name"];
	 NSString* detailedText = [NSString stringWithFormat:
	 @"%@-%@",
	 tmpArray[indexPath.row][@"category"],
	 tmpArray[indexPath.row][@"subcategory"]];
	 cell.detailTextLabel.text = detailedText;
	 return cell;

	*/
	
	NSDictionary* tmpLesson = self.LessonListDict[categories[indexPath.section]][indexPath.row];
	NSLog(@"%@",tmpLesson);
	cell.textLabel.text = tmpLesson[@"name"];
	NSString* detailedText = [NSString stringWithFormat:@"%@-%@",tmpLesson[@"category"],tmpLesson[@"subcategory"]];
	cell.detailTextLabel.text = detailedText;
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
	
	//[self.ud setObject:self.LessonListDict[categories[indexPath.section]][indexPath.row] forKey:@"thread_id"];
	
	NSLog(@"call next view");
	NSString* dir = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
	NSString* filepath = [dir stringByAppendingPathComponent:@"thread.dat"];
	NSDictionary* recordData = self.LessonListDict[categories[indexPath.section]][indexPath.row];
	NSLog(@"record:%@",recordData);
	/*
	NSData* tmpThread = [NSKeyedArchiver archivedDataWithRootObject:recordData];
	
	BOOL result = [NSKeyedArchiver archiveRootObject:tmpThread toFile:filepath];
	if (result) {
		NSLog(@"record success");
	}else{
		NSLog(@"record failed..");
	}*/
	
	[self.ud setObject:recordData forKey:@"tmpthread"];
	
	ismTimeTableComments *commentTimeTable = [[ismTimeTableComments alloc] init];
	
	[self.navigationController pushViewController:commentTimeTable animated:YES];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return categories[section];
}

-(void)addButtonPushed{
	NSLog(@"add button pushed");
	ismTimeTableAdd* controller = [[ismTimeTableAdd alloc]init];
	//[self.navigationController pushViewController:controller animated:YES];
	[self presentViewController:controller animated:YES completion:nil];
}

@end
