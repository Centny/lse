//
//  LoginVC.h
//  lse
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Centny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iwf/iwf.h>

@interface LoginVC : UIViewController
@property(nonatomic)IBOutlet UITextField* usr;
@property(nonatomic)IBOutlet UITextField* pwd;

-(IBAction)onLogin:(id)sender;
@end
