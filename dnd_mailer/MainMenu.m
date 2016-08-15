//
//  ViewController.m
//  dnd_mailer
//
//  Created by Mykola Tarasov on 8/14/16.
//  Copyright © 2016 Mykola Tarasov. All rights reserved.
//

#import "MainMenu.h"
#import "InboxView.h"

@interface MainMenu ()

@end

@implementation MainMenu

static NSString* menuOptionSection1[] = {@"Inbox", @"Starred", @"Drafts", @"Sent", @"Archive", @"Trash", @"Spam"};
static NSString* menuOptionSection2[] = {@"Contacts", @"Settings", @"Logout"};


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main menu";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    }
}
@end
