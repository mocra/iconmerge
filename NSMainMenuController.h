//
//  NSMainMenuController.h
//  iConMerge
//
//  Created by Daniel Leping on 2/1/09.
//  Copyright 2009 Mocra. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSMainMenuController : NSObject {
	IBOutlet NSAnyImageView* imageView1;
	IBOutlet NSAnyImageView* imageView2;
	IBOutlet NSSaveableImageView* imageView3;
	
	IBOutlet NSMenuItem* menuItemOpenMain;
	IBOutlet NSMenuItem* menuItemOpenOverlay;

	NSAnyImageView* _lastOpenedImageView;
}

- (IBAction) swapAction:sender;
- (IBAction) mergeAction:sender;
- (IBAction) openAction:sender;
- (IBAction) saveAction:sender;
- (IBAction) windowClose:sender;

@property (nonatomic, retain) NSAnyImageView *lastOpenedImageView;

- (void)setLastOpenedImage:(id)sender;

@end
