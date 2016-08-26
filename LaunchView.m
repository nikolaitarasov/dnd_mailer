//
//  LaunchView.m
//  dnd_mailer
//
//  Created by Mykola Tarasov on 8/15/16.
//  Copyright © 2016 Mykola Tarasov. All rights reserved.
//

#import "LaunchView.h"
#import "MainMenu.h"
#import "CreateAccount.h"
#import "LoginView.h"

@interface LaunchView ()

@end

@implementation LaunchView

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];   //it hides
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];    // it shows
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"launch_image.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y,
                                 image.size.width, image.size.height);
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setFrame:CGRectMake(self.view.center.x-100, self.view.center.y+75, 200, 35)];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setBackgroundColor:
     [[UIColor alloc] initWithRed:0.f green:50.f blue:130.f alpha:0.5]];
    loginButton.titleLabel.font = [UIFont systemFontOfSize: 18];
    [loginButton setTitleColor:([UIColor whiteColor]) forState:UIControlStateNormal];
    [loginButton titleColorForState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.userInteractionEnabled = YES;
    
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    [imageView addSubview:loginButton];
    [imageView bringSubviewToFront:loginButton];
    
    UIButton *createAccountButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [createAccountButton setFrame:CGRectMake(
                                self.view.center.x-100, self.view.center.y+10, 200, 35)];
    [createAccountButton setTitle:@"Create New Account" forState:UIControlStateNormal];
    [createAccountButton setBackgroundColor:
     [[UIColor alloc] initWithRed:0.f green:50.f blue:130.f alpha:0.5]];
    createAccountButton.titleLabel.font = [UIFont systemFontOfSize: 18];
    [createAccountButton setTitleColor:([UIColor whiteColor]) forState:UIControlStateNormal];
    [createAccountButton titleColorForState:UIControlStateNormal];
    [createAccountButton addTarget:self action:@selector(createAccountAction:) forControlEvents:UIControlEventTouchUpInside];
    createAccountButton.userInteractionEnabled = YES;
    
    [imageView addSubview:createAccountButton];
    [imageView bringSubviewToFront:createAccountButton];
    [imageView setUserInteractionEnabled:YES];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(
                                            self.view.center.x-100, self.view.center.y-150, 250, 45)];
    label.text = @"dndM@il";
    label.font = [UIFont fontWithName:@"AvenirNext-Bold" size:45];
    label.textColor = [UIColor whiteColor];
    [imageView addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) loginAction:(UIButton*) button {
    LoginView* loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
    [self.navigationController pushViewController:loginView animated:YES];
}

-(void) createAccountAction:(UIButton*) button {
    CreateAccount* createAccount =
                            [self.storyboard instantiateViewControllerWithIdentifier:@"CreateAccount"];
    [self.navigationController pushViewController:createAccount animated:YES];
}

@end
