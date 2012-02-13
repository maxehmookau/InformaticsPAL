//
//  DetailedProfileViewController.h
//  InformaticsPAL
//
//  Created by Max Woolf on 09/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSDictionary *dataDictionary;
    IBOutlet UITableView *table;
}

-(id)initwithDataDictionary:(NSDictionary *)data;
@end
