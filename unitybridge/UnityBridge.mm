#import "UnityBridge.h"

DelegateCallbackFunction delegate = NULL;
@interface UnityBridge : NSObject<UnityDelegate>
@end
static UnityBridge *__delegate = nil;

//---------------------------------------------------------------
ASScreenRecorder *recorder = nil;

void startCapture()
{
    recorder = [ASScreenRecorder sharedInstance];
    [recorder startRecording];
    NSLog(@"Start recording");
}

void stopCapture()
{
    [recorder stopRecordingWithCompletion:^(NSString* videoPath){
        videoPath = [videoPath stringByReplacingOccurrencesOfString:@"file://"
                                                         withString:@""];
        NSLog(@"Finished recording: %@", videoPath);
        char* returnPath = cStringCopy([videoPath UTF8String]);
        [ASScreenRecorder sendPathToDelegate:returnPath];
    }];
}

char* cStringCopy(const char* string)
{
    if (string == NULL)
        return NULL;
    char* res = (char*)malloc(strlen(string) + 1);
    strcpy(res, string);
    return res;
}
//---------------------------------------------------------------

void framework_trigger_delegate() {
    char* returnChar = (char*)"It's work!";
    [ASScreenRecorder sendPathToDelegate:returnChar];
}

void framework_setDelegate(DelegateCallbackFunction callback) {
    if (!__delegate) {
        __delegate = [[UnityBridge alloc] init];
    }
    [ASScreenRecorder setDelegate:__delegate];
    
    delegate = callback;
}

@implementation UnityBridge
-(void)videoPath:(char*)path {
    if (delegate != NULL) {
        delegate(path);
    }
}
@end
