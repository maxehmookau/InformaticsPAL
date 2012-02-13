//
//  ProfilesViewController.h
//  InformaticsPAL
//
//  Created by Max Woolf on 09/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *plistData;
    IBOutlet UITableView *table;
    NSMutableArray *imagePaths;
}

-(void)readPlist;
@end
