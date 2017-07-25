//
//  ListEntryVC.h
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iwf/iwf.h>

@interface ListEntryVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)NSString* last;
@property(nonatomic)IBOutlet UITextField* lastview;
@property(nonatomic)IBOutlet UIView* process;
@property(nonatomic)NSString* token;
@property(nonatomic)IBOutlet UITableView* list;
-(IBAction)onEdit:(id)sender;
-(IBAction)onWeb:(id)sender;
@end
