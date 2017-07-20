//
//  WebVC.h
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iwf/iwf.h>
#import <WebKit/WebKit.h>

@interface WebVC : UIViewController
@property(nonatomic)NSString* url;
@property(nonatomic)IBOutlet WKWebView* webview;

-(IBAction)onBack:(id)sender;
-(IBAction)onNavBack:(id)sender;
@end
