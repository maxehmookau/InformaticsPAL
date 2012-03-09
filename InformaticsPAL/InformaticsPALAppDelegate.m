//
//  InformaticsPALAppDelegate.m
//  InformaticsPAL
//
//  Created by Max Woolf on 09/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InformaticsPALAppDelegate.h"
#import "ProfilesViewController.h"
#import "TimetableViewController.h"
#import "SettingsViewController.h"
#import "Reachability.h"

@implementation InformaticsPALAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    
    ProfilesViewController *profilesVC = [[ProfilesViewController alloc] init];
    [profilesVC setTitle:@"PAL Leaders"];
    UINavigationController *profilesNC = [[UINavigationController alloc] initWithRootViewController:profilesVC];
    
    TimetableViewController *timetableVC = [[TimetableViewController alloc] init];
    [timetableVC setTitle:@"PAL Timetable"];
    UINavigationController *timetableNC = [[UINavigationController alloc] initWithRootViewController:timetableVC];
    
    SettingsViewController *settingsVC = [[SettingsViewController alloc] init];
    [settingsVC setTitle:@"Settings"];
    
    
    tabBar.viewControllers = [NSArray arrayWithObjects:timetableNC, profilesNC, settingsVC, nil];
    self.window.rootViewController = tabBar;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PAL Alert!" message:[[userInfo objectForKey:@"aps"]valueForKey:@"alert"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    //Reachability status should be good otherwise no attempt should be made
    //to conncet to UA servers.
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reach currentReachabilityStatus];
    if(internetStatus != NotReachable)
    {
        NSString * token = [[[deviceToken description] 
                             stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] 
                            stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *urlString = [[NSString alloc] initWithString:@"https://go.urbanairship.com/api/device_tokens/"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[urlString stringByAppendingString:token]]];
        [request setHTTPMethod:@"PUT"];
        [[NSURLConnection connectionWithRequest:request delegate:self]start];
        NSLog(@"%@", token);
    }    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    //Connection MUST be authenticated with urban airship with NO persistance to avoid 
    //confliction errors. 
    NSLog(@"Challenged!");
    NSURLCredential *credential = [[NSURLCredential alloc] initWithUser:@"CZzQCz2GRx2go_oF5Hp7xA" password:@"1aZKPsaFSnSEFFf8iPOI3w" persistence:NSURLCredentialPersistenceNone];
    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
