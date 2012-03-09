//
//  SettingsViewController.m
//  InformaticsPAL
//
//  Created by Max Woolf on 23/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"gear.png"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)readPlist
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"Settings.plist"];
    plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
}

-(NSDictionary *)readCoursesPlist
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"Courses.plist"];
    return [NSDictionary dictionaryWithContentsOfFile:finalPath];
}

#pragma mark - Table Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 2;
    }
    else if(section == 1)
    {
        if([[plistData objectForKey:@"Year"]isEqualToString:@"1"])
        {
            return [[[self readCoursesPlist]objectForKey:@"FirstYear"]count];
        }else{
            return [[[self readCoursesPlist]objectForKey:@"SecondYear"]count];
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];  
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            NSLog(@"%@", [plistData objectForKey:@"Year"]);
            if([[plistData objectForKey:@"Year"]isEqualToString:@"1"])
            {
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            }
            [cell.textLabel setText:@"First Year"];
        }else{
            if([[plistData objectForKey:@"Year"]isEqualToString:@"2"])
            {
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            }
            [cell.textLabel setText:@"Second Year"];
        }
    }else if(indexPath.section == 1)
    {
        if([[plistData objectForKey:@"Year"]isEqualToString:@"1"])
        {
            [cell.textLabel setText:[firstYearCourses objectAtIndex:indexPath.row]];
        }else{
            [cell.textLabel setText:[secondYearCourses objectAtIndex:indexPath.row]];
        }
        
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [headers objectAtIndex:section];
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [footers objectAtIndex:section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryNone)
        {
            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
            
            [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }else if(indexPath.section == 1)
    {
        if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryNone)
        {
            [[tableView cellForRowAtIndexPath:indexPath]setAccessoryType:UITableViewCellAccessoryCheckmark];
        }else{
            [[tableView cellForRowAtIndexPath:indexPath]setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [navBar setTintColor:[UIColor colorWithRed:0.549 green:0.824 blue:0.925 alpha:1.000]];
    [self readPlist];
    firstYearCourses = [NSArray arrayWithArray:[[[self readCoursesPlist]objectForKey:@"FirstYear"]allKeys]];
    secondYearCourses = [NSArray arrayWithArray:[[[self readCoursesPlist]objectForKey:@"SecondYear"]allKeys]];
    headers = [[NSArray alloc] initWithObjects:@"I am a...", @"Notify me when the following sessions are starting...", nil];
    footers = [[NSArray alloc] initWithObjects:@"Tap to Select",@"",  nil];
    [table setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]]];
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
