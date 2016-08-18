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

@interface LaunchView ()

@end

@implementation LaunchView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"launch_image.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y,
                                 image.size.width, image.size.height);
    
    UIButton *signInButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [signInButton setFrame:CGRectMake(self.view.center.x-100, self.view.center.y+75, 200, 35)];
    [signInButton setTitle:@"Sign In" forState:UIControlStateNormal];
    [signInButton setBackgroundColor:
     [[UIColor alloc] initWithRed:0.f green:50.f blue:130.f alpha:0.5]];
    signInButton.titleLabel.font = [UIFont systemFontOfSize: 18];
    [signInButton setTitleColor:([UIColor whiteColor]) forState:UIControlStateNormal];
    [signInButton titleColorForState:UIControlStateNormal];
    [signInButton addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
    signInButton.userInteractionEnabled = YES;
    
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    [imageView addSubview:signInButton];
    [imageView bringSubviewToFront:signInButton];
    
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
    NSLog(@"viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) signInAction:(UIButton*) button {
    MainMenu* mainMenu = [[MainMenu alloc] init];
    [self.navigationController pushViewController:mainMenu animated:YES];
}

-(void) createAccountAction:(UIButton*) button {
    CreateAccount* createAccount =
                            [self.storyboard instantiateViewControllerWithIdentifier:@"CreateAccount"];
    [self.navigationController pushViewController:createAccount animated:YES];
}

@end
