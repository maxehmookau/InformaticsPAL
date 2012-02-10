//
//  DetailedProfileViewController.m
//  InformaticsPAL
//
//  Created by Max Woolf on 09/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailedProfileViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DetailedProfileViewController

-(id)initwithDataDictionary:(NSDictionary *)data
{
    dataDictionary = data;
    return [self init];
}

#pragma mark - Table Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier: @"DetailCell"];
    
    if (!cell) {
        if(indexPath.section==0)
        {
            cell = [[UITableViewCell alloc]
                    initWithStyle: UITableViewCellStyleDefault
                    reuseIdentifier: @"DetailCell"];
            cell.detailTextLabel.numberOfLines = 3;
            cell.imageView.layer.masksToBounds = YES;
            cell.imageView.layer.cornerRadius = 5.0;
            [cell.textLabel setText:[dataDictionary valueForKey:@"Name"]];
            [cell.imageView setImage:[dataDictionary valueForKey:@"Image"]];
        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetailCell"];
            [cell.textLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [cell.textLabel setNumberOfLines:0];
            [cell.textLabel setText:[dataDictionary valueForKey:@"Bio"]];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section ==0)
    {
        return 75;
    }
    CGSize size = [[dataDictionary valueForKey:@"Bio"]
                   sizeWithFont:[UIFont systemFontOfSize:14]
                   constrainedToSize:CGSizeMake(300, CGFLOAT_MAX)];
    return size.height + 20;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
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
