//
//  ViewController.m
//  dnd_mailer
//
//  Created by Mykola Tarasov on 8/14/16.
//  Copyright © 2016 Mykola Tarasov. All rights reserved.
//

#import "MainMenu.h"
#import "InboxView.h"
#import "LaunchView.h"
#import "ComposeEmailView.h"
#import <Parse/PFUser.h>
#import <CoreText/CTStringAttributes.h>

@interface MainMenu ()

@end

@implementation MainMenu

static NSString* menuOptionSection1[] = {@"Inbox", @"Starred", @"Drafts", @"Sent", @"Archive", @"Trash", @"Spam"};
static NSString* menuOptionSection2[] = {@"Contacts", @"Settings", @"Logout"};


- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFUser *user = [PFUser currentUser];
    
    UILabel *emailTitleLabel = [[UILabel alloc] init];
    emailTitleLabel.text = user.email;
    emailTitleLabel.textColor = [UIColor blackColor];
    emailTitleLabel.font = [UIFont systemFontOfSize:12];
    emailTitleLabel.numberOfLines = 1;
    [emailTitleLabel sizeToFit];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = [NSString stringWithFormat:@"%@\n%@", user.username, user.email];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    //titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel sizeToFit];
    
  
    self.navigationItem.titleView = titleLabel;
    UIBarButtonItem* composeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                                                    UIBarButtonSystemItemCompose
                                                                    target:self
                                                                    action:@selector(composeAction:)];
    
    self.navigationItem.rightBarButtonItem = composeButton;
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) composeAction:(UIButton*) button {
    ComposeEmailView* cem = [[ComposeEmailView alloc] init];
    [cem showEmail:button];
}

#pragma mark - Config table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 7 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = menuOptionSection1[indexPath.row];
    } else if (indexPath.section == 1) {
        cell.textLabel.text = menuOptionSection2[indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 10;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"Inbox"]) {
        InboxView* inboxView = [[InboxView alloc] init];
        [self.navigationController pushViewController:inboxView animated:YES];
    } else if ([cell.textLabel.text isEqualToString:@"Logout"]) {
        // Send a request to log out a user
        [PFUser logOutInBackgroundWithBlock:^(NSError* error){
            dispatch_async(dispatch_get_main_queue(), ^(void){
                LaunchView* launchView =
                [self.storyboard instantiateViewControllerWithIdentifier:@"LaunchView"];
                [self.navigationController pushViewController:launchView animated:NO];
            });
        }];
    }
}
@end
