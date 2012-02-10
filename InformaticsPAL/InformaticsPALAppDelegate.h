//
//  InformaticsPALAppDelegate.h
//  InformaticsPAL
//
//  Created by Max Woolf on 09/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InformaticsPALViewController;

@interface InformaticsPALAppDelegate : UIResponder <UIApplicationDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) InformaticsPALViewController *viewController;

@end
