//
//  SessionDetailViewController.h
//  InformaticsPAL
//
//  Created by Max Woolf on 09/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *dataDictionary;
    NSString *courseName;
    IBOutlet UITableView *table;
}

-(id)initWithDataDictionary:(NSDictionary *)data title:(NSString *)title;

@end
