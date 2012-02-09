//
//  SessionDetailViewController.m
//  InformaticsPAL
//
//  Created by Max Woolf on 09/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SessionDetailViewController.h"
#import <EventKitUI/EventKitUI.h>

@implementation SessionDetailViewController

-(id)initWithDataDictionary:(NSDictionary *)data title:(NSString *)title;
{
    dataDictionary = data;
    courseName = title;
    return [self init];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return  [[dataDictionary objectForKey:@"Times"]count];
            
        case 2:
            return [[dataDictionary objectForKey:@"Tutors"]count];
            
        case 3:
            return 1;
        default:
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:SimpleTableIdentifier];
    
    if (indexPath.section == 0) {
        [cell.textLabel setText:@"Location"];
        [cell.detailTextLabel setText:[dataDictionary valueForKey:@"Location"]];
    }else if(indexPath.section == 1)
    {
        [cell.textLabel setText:@"Time"];
        NSString *time = [[dataDictionary valueForKey:@"Times"]objectAtIndex:indexPath.row];
        NSString *day = [[dataDictionary valueForKey:@"Days"]objectAtIndex:indexPath.row];
        [cell.detailTextLabel setText:[[day stringByAppendingString:@" "]stringByAppendingString:time]];
    }else if(indexPath.section == 2)
    {
        [cell.textLabel setText:@"Tutor"];
        [cell.detailTextLabel setText:[[dataDictionary valueForKey:@"Tutors"] objectAtIndex:indexPath.row]];
    }else if(indexPath.section == 3)
    {
        [cell.detailTextLabel setText:[dataDictionary valueForKey:@"Website"]];
    }
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *headers = [[NSArray alloc] initWithObjects:@"Where?", @"When?", @"Who?", @"Website", nil];
    return [headers objectAtIndex:section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EKEvent *event = [EKEvent eventWithEventStore:nil];
    EKEventViewController *calVC = [[EKEventViewController alloc] init];
    calVC.event = myEvent;
    calVC.allowsEditing = YES;
    [self presentModalViewController:calVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self setTitle:courseName];
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
