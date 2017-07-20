//
//  EditorItem.h
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iwf/iwf.h>

@interface EditorItem : UIView
@property(nonatomic)IBOutlet UILabel* label;
@property(nonatomic)IBOutlet UITextView* text;
@property(nonatomic)IBOutlet UIImageView* preview;
-(void)set:(NSString*)lable text:(NSString*)text url:(NSString*)url;
-(void)fitSize:(CGFloat)width;
@end
