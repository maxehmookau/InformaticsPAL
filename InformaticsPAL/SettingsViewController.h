//
//  SettingsViewController.h
//  InformaticsPAL
//
//  Created by Max Woolf on 23/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

{
    NSArray *headers;
    NSArray *content;
    NSArray *footers;
    IBOutlet UITableView *table;
    NSDictionary *plistData;
    NSArray *firstYearCourses;
    NSArray *secondYearCourses;
    IBOutlet UINavigationBar *navBar;
}

-(void)readPlist;
-(NSDictionary *)readCoursesPlist;
@end
