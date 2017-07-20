//
//  ListEntryVC.h
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListEntryVC : UIViewController
@property(nonatomic)NSString* last;
@property(nonatomic)IBOutlet UITextView* lastview;
-(IBAction)onEdit:(id)sender;
-(IBAction)onWeb:(id)sender;
@end
