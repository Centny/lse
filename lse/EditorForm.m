//
//  EditorForm.m
//  ude
//
//  Created by Centny on 20/07/2017.
//  Copyright © 2017 Dayang. All rights reserved.
//

#import "EditorForm.h"
#import <CommonCrypto/CommonDigest.h>
#import "EditorUsed.h"

@interface EditorForm ()
@property(nonatomic)EditorUsed* preused;
@end


@implementation EditorForm

- (void)awakeFromNib{
    [super awakeFromNib];
    self.preused=[UIView viewWithXib:@"EditorUsed"];
    [self.usedTags registerNib:[UINib nibWithNibName:@"EditorUsed" bundle:nil] forCellWithReuseIdentifier:@"text"];
    [self.usedFrom registerNib:[UINib nibWithNibName:@"EditorUsed" bundle:nil] forCellWithReuseIdentifier:@"text"];
    NSUserDefaults* def=[NSUserDefaults standardUserDefaults];
    NSArray* tags=[def objectForKey:@"tags"];
    if(tags){
        self.tagList=[NSMutableArray arrayWithArray:tags];
    }else{
        self.tagList=[NSMutableArray new];
    }
    NSArray* from=[def objectForKey:@"from"];
    if(from){
        self.fromList=[NSMutableArray arrayWithArray:from];
    }else{
        self.fromList=[NSMutableArray new];
    }
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.contentSize=CGSizeMake(frame.size.width, self.submit.frame.origin.y+self.submit.frame.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.usedTags==collectionView){
        return self.tagList.count;
    }else{
        return self.fromList.count;
    }
}
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.usedTags==collectionView){
        self.preused.text=[self.tagList objectAtIndex:indexPath.row];
    }else{
        self.preused.text=[self.fromList objectAtIndex:indexPath.row];
    }
    self.preused.title.frame=CGRectMake(5, 5, FRAM_W(collectionView), 20);
    [self.preused.title sizeToFit];
    return CGSizeMake(FRAM_W(self.preused.title)+10, FRAM_H(self.preused.title)+10);
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"text" forIndexPath:indexPath];
    EditorUsed* used=(EditorUsed*)cell;
    if(self.usedTags==collectionView){
        used.text=[self.tagList objectAtIndex:indexPath.row];
    }else{
        used.text=[self.fromList objectAtIndex:indexPath.row];
    }
    used.title.frame=CGRectMake(5, 5, FRAM_W(collectionView), 20);
    [used.title sizeToFit];
    return cell;
}

-(BOOL)collectionView:( UICollectionView *)collectionView shouldSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    return YES ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.usedTags==collectionView){
        NSString* tag=[self.tagList objectAtIndex:indexPath.row];
        if(self.tags.text.length<1){
            self.tags.text=tag;
            return;
        }
        NSMutableArray* using=[NSMutableArray arrayWithArray:[self.tags.text componentsSeparatedByString:@","]];
        if([using containsObject:tag]){
            [using removeObject:tag];
        }else{
            [using addObject:tag];
        }
        self.tags.text=[using componentsJoinedByString:@","];
        return;
    }else{
        NSString* from=[self.fromList objectAtIndex:indexPath.row];
        if(self.from.text.length<1){
            self.from.text=from;
            return;
        }
        NSMutableArray* using=[NSMutableArray arrayWithArray:[self.from.text componentsSeparatedByString:@","]];
        if([using containsObject:from]){
            [using removeObject:from];
        }else{
            [using addObject:from];
        }
        self.from.text=[using componentsJoinedByString:@","];
        return;
    }
}

-(void)alert:(NSString*)title message:(NSString*)message{
    UIAlertView* view=[[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [view show];
}

- (NSString*)SHA1:(NSString*)val{
    NSData *data = [val dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

-(IBAction)onSubmit:(id)sender{
    if(self.title.text.length<1){
        self.info.text=@"title is empty";
        return;
    }
    if(self.preview.url==nil){
        self.info.text=@"image is empty";
        return;
    }
    if(self.uploaded){
        [self doSubmit];
    }else{
        [self doUpload];
    }
}

-(NSString*)urlencode:(NSString*)text{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)text,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8 ));
}

-(void)doUpload{
    self.info.text=@"uploading";
    URLReqJsonCompleted completed=^(URLRequester *req, NSData *data, NSDictionary* json, NSError *err) {
        NSDLog(@"->%@", [data UTF8String]);
        if(err){
            self.info.text=@"upload fail";
            return;
        }
        if([[json checkValueForKey:@"code"]intValue]!=0){
            self.info.text=@"upload fail";
            return;
        }
        self.uploaded=[json checkValueForKey:@"data"];
        self.info.text=@"uploaded";
        [self doSubmit];
    };
    NSData* data=UIImageJPEGRepresentation(self.preview.image, 1.0);
    NSInputStream* stream=[NSInputStream inputStreamWithData:data];
    [H doPost:[NSString stringWithFormat:@"http://fs.kuxiao.cn/usr/api/uload?token=%@&pub=1",self.token] data:data name:@"file" filename:@"abc.jpg" type:@"image/jpeg" fields:nil json:completed];
}

-(void)doSubmit{
    [self syncUsed];
    NSMutableDictionary* dargs=[NSMutableDictionary new];
    [dargs setValue:[self SHA1:self.base] forKey:@"iid"];
    [dargs setValue:[self urlencode:self.title.text] forKey:@"title"];
    [dargs setValue:self.tags.text forKey:@"owner"];
    [dargs setValue:self.from.text forKey:@"author"];
    [dargs setValue:[self urlencode:self.uploaded] forKey:@"img"];
    [dargs setValue:[self urlencode:self.base] forKey:@"link"];
    [dargs setValue:[self urlencode:self.desc.text] forKey:@"desc"];
    [dargs setValue:@"ARTICLE" forKey:@"type"];
    [H doPost:[NSString stringWithFormat:@"http://links.chk.gdy.io/usr/api/upsertItem?token=%@",self.token] dargs:dargs json:^(URLRequester *req, NSData *data, NSDictionary *json, NSError *err) {
        if(err){
            self.info.text=@"submit fail";
            return;
        }
        if([[json checkValueForKey:@"code"]intValue]!=0){
            self.info.text=@"submit fail";
            return;
        }
        NSDLog(@"->%@", [data UTF8String]);
        self.info.text=@"done";
    }];
}

-(void)syncUsed{
    NSUserDefaults* def=[NSUserDefaults standardUserDefaults];
    if(self.tags.text.length){
        NSArray* using=[self.tags.text componentsSeparatedByString:@","];
        for(NSString* tag in using){
            if([self.tagList containsObject:tag]){
                continue;
            }
            [self.tagList insertObject:tag atIndex:0];
        }
        [def setObject:self.tagList forKey:@"tags"];
    }
    if(self.from.text.length){
        NSArray* using=[self.from.text componentsSeparatedByString:@","];
        for(NSString* from in using){
            if([self.fromList containsObject:from]){
                continue;
            }
            [self.fromList insertObject:from atIndex:0];
        }
        [def setObject:self.fromList forKey:@"from"];
    }
    [def synchronize];
    [self.usedTags reloadData];
    [self.usedFrom reloadData];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(self.image==textField){
        self.preview.url=textField.text;
    }
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end









