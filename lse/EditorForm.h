//
//  EditorForm.h
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iwf/iwf.h>

@interface EditorForm : UIScrollView<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic)IBOutlet UITextView* title;
@property(nonatomic)IBOutlet UITextField* tags;
@property(nonatomic)IBOutlet UICollectionView* usedTags;
@property(nonatomic)IBOutlet UITextField* from;
@property(nonatomic)IBOutlet UICollectionView* usedFrom;
@property(nonatomic)IBOutlet UITextField* image;
@property(nonatomic)IBOutlet UIImageView* preview;
@property(nonatomic)IBOutlet UITextView* desc;
@property(nonatomic)IBOutlet UILabel* info;
@property(nonatomic)IBOutlet UIButton* submit;
@property(nonatomic)NSMutableArray* tagList;
@property(nonatomic)NSMutableArray* fromList;
//
@property(nonatomic)NSString* uploaded;
@property(nonatomic)NSString* token;
@property(nonatomic)NSString* base;
-(IBAction)onSubmit:(id)sender;
@end
