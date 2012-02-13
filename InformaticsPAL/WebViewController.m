//
//  WebViewController.m
//  SussexStudent
//
//  Created by Max Woolf on 03/08/2011.
//  Copyright 2011 University of Sussex Students' Union. All rights reserved.
//

#import "WebViewController.h"
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@implementation WebViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - Set url properties
-(void)setURL:(NSString *)address
{
    url = [[NSURL alloc] initWithString:address];
}


#pragma mark - Web View Delegate Methods
//These are VERY buggy. Maybe implement in another version

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString *errorString = [[NSString alloc] initWithFormat:[error localizedDescription]];
    UIAlertView *failureAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [failureAlert show];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
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
