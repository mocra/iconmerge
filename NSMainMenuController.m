//
//  NSMainMenuController.m
//  iConMerge
//
//  Created by Daniel Leping on 2/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NSAnyImageView.h"
#import "NSSaveableImageView.h"
#import "NSMainMenuController.h"
#import "IconFamily.h"


@implementation NSMainMenuController

@synthesize lastOpenedImageView=_lastOpenedImageView;

- (void)awakeFromNib {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLastOpenedImage:) name:NSAnyImageViewDraggedImage object:nil];
}

- (IBAction) swapAction:sender {
	NSImage* image = imageView1.image;
	imageView1.image = imageView2.image;
	imageView2.image = image;
	[self mergeAction:sender];
}

- (IBAction) mergeAction:sender {
	int part = 2;
	int rate = 5;
	NSImage* image1 = [imageView1 image];
	NSImage* image2 = [imageView2 image];
	NSSize size1 = [image1 size];
	NSSize size2 = [image2 size];
	NSSize size1quater = { size1.width / rate, size1.height / rate };
	NSImage* resultImage = [[NSImage alloc] initWithSize:size1];
	NSRect rect1from = { 0, 0, size1.width, size1.height };
	NSRect rect1to = rect1from;
	NSRect rect2from = { 0, 0, size2.width, size2.height };
	NSRect rect2to = { size1quater.width * (rate - part), 0, size1quater.width * part, size1quater.height * part };
	[resultImage lockFocus];
	[image1 drawInRect:rect1to fromRect:rect1from operation:NSCompositeSourceOver fraction:1];
	[image2 drawInRect:rect2to fromRect:rect2from operation:NSCompositeSourceOver fraction:1];
	[resultImage unlockFocus];
	
	imageView3.image = resultImage;
	[resultImage release];
}

- (IBAction) openAction:sender {
	NSOpenPanel* panel = [NSOpenPanel openPanel];
	if( [panel runModalForTypes:nil] == NSOKButton ) {
    BOOL success = FALSE;
    if (self.lastOpenedImageView == imageView1) {
      success = [imageView2 loadFile:[panel filename]];
      //self.lastOpenedImageView = imageView2;
    } else {
      success = [imageView1 loadFile:[panel filename]];
      //self.lastOpenedImageView = imageView1;
    }
    if(success) {
      [self mergeAction:sender];
    }
	}
}

- (void)setLastOpenedImage:(id)sender
{
  self.lastOpenedImageView = [sender object];
  [self mergeAction:sender];
}

- (IBAction) saveAction:sender {
	BOOL result;
	NSString* filename;
	if([sender tag] == SaveItem) {
		NSSavePanel* panel = [NSSavePanel savePanel];
		[panel setRequiredFileType:@"icns"];
		if( result = [panel runModal] == NSOKButton ) {
			filename = [panel filename];
		}
	} else {
		NSOpenPanel* panel = [NSOpenPanel openPanel];
		[panel setPrompt:@"Save"];
		[panel setTitle:@"Save"];
		if( result = [panel runModal] == NSOKButton ) {
			filename = [panel filename];
		}
	}
	if( result ) {
		NSImage* image = [imageView3 image];
		if([sender tag] == SaveItem) {
			NSData* data = [image TIFFRepresentation];
			IconFamily* iconFamily = [IconFamily iconFamilyWithThumbnailsOfImage:[[NSImage alloc] initWithData:data]];
			result = [iconFamily writeToFile:filename];
		} else {
			result = [[NSWorkspace sharedWorkspace] setIcon:image forFile:filename options:0];
		}
		if( !result ) {
			NSRunAlertPanel(@"File Writing Error", [NSString stringWithFormat:@"Sorry, but I failed to save the icon at \"%@\"", filename], nil, nil, nil);
		}
	}
}

- (IBAction) windowClose:sender {
//	[aboutWindow setDelegate:nil];
	[NSApp terminate:self];
}

- (void)dealloc
{
  [_lastOpenedImageView release];
  
  [super dealloc];
}

@end
