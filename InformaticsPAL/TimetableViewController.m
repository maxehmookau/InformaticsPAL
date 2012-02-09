//
//  TimetableViewController.m
//  InformaticsPAL
//
//  Created by Max Woolf on 09/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TimetableViewController.h"

@implementation TimetableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage* anImage = [UIImage imageNamed:@"calendar.png"];
        UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:@"Group" image:anImage tag:0];
        self.tabBarItem = theItem;
    }
    return self;
}

-(void)readPlist
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"Courses.plist"];
    plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
}

#pragma mark - Table Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return [[plistData objectForKey:@"FirstYear"]count];
    }
    return [[plistData objectForKey:@"SecondYear"]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];  
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if(indexPath.section == 0)
    {
        [cell.textLabel setText:[[[plistData objectForKey:@"FirstYear"]allKeys]objectAtIndex:indexPath.row]];
    }else{
        [cell.textLabel setText:[[[plistData objectForKey:@"SecondYear"]allKeys]objectAtIndex:indexPath.row]];
    }    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"First Year Courses";
    }
    return @"Second Year Courses";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - View lifecycle
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [self readPlist];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.549 green:0.824 blue:0.925 alpha:1.000]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
