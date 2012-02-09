//
//  ProfilesViewController.m
//  InformaticsPAL
//
//  Created by Max Woolf on 09/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ProfilesViewController.h"
#import "DetailedProfileViewController.h"

@implementation ProfilesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIImage* anImage = [UIImage imageNamed:@"group.png"];
        UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:@"Group" image:anImage tag:0];
        self.tabBarItem = theItem;
    }
    return self;
}

-(void)readPlist
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"Profiles.plist"];
    plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Table View Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[plistData valueForKey:@"Names"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    cell.textLabel.text = [[plistData objectForKey:@"Names"]objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[[plistData objectForKey:@"PictureNames"] objectAtIndex:indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Generate dictionary with information
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:[[plistData objectForKey:@"Names"]objectAtIndex:indexPath.row] forKey:@"Name"];
    [data setValue:[UIImage imageNamed:[[plistData objectForKey:@"PictureNames"]objectAtIndex:indexPath.row]] forKey:@"Image"];
    [data setValue:[[plistData objectForKey:@"Bios"]objectAtIndex:indexPath.row] forKey:@"Bio"];
    DetailedProfileViewController *detailVC = [[DetailedProfileViewController alloc] initwithDataDictionary:data];
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.549 green:0.824 blue:0.925 alpha:1.000]];
    [self readPlist];
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
