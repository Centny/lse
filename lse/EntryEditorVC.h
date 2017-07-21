//
//  EntryEditorVC.h
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iwf/iwf.h>
#import <WebKit/WebKit.h>
#import "EditorForm.h"

@interface Entry : NSObject
@property(nonatomic)NSString* title;
@property(nonatomic)NSString* tags;
@property(nonatomic)NSString* from;
@property(nonatomic)NSString* img;
@property(nonatomic)NSString* desc;

@end

@interface EntryEditorVC : UIViewController
@property(nonatomic)NSString* url;
@property(nonatomic)IBOutlet UIView* main;
@property(nonatomic)IBOutlet UIView* wvbase;
@property(nonatomic)IBOutlet WKWebView* webview;
@property(nonatomic)IBOutlet UIButton* edit;
@property(nonatomic)IBOutlet UIProgressView* progress;
@property(nonatomic)EditorForm* form;
//
-(IBAction)onBack:(id)sender;
-(IBAction)onRefresh:(id)sender;
-(IBAction)onProcImg:(id)sender;
-(IBAction)onProcDesc:(id)sender;
-(IBAction)onEdit:(id)sender;
@end
