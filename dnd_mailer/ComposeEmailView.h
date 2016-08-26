//
//  ComposeEmailView.h
//  dnd_mailer
//
//  Created by Mykola Tarasov on 8/18/16.
//  Copyright © 2016 Mykola Tarasov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ComposeEmailView : UIViewController <MFMailComposeViewControllerDelegate>

- (void) showEmail:(NSString*)file;

@end
