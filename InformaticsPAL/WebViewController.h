//
//  WebViewController.h
//  SussexStudent
//
//  Created by Max Woolf on 03/08/2011.
//  Copyright 2011 University of Sussex Students' Union. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface WebViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate,MFMailComposeViewControllerDelegate>
{
    NSURL *url;
    IBOutlet UIWebView *webView;
    BOOL local;
}

-(void)setURL:(NSString *)address;
-(void)showActionSheet;
-(void)presentTweeter;

@property (retain, nonatomic) UIWebView *webView;
@end
