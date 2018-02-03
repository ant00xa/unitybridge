#import "UnityBridge.h"

ASScreenRecorder *recorder = [ASScreenRecorder sharedInstance];

void startCapture()
{
    [recorder startRecording];
    NSLog(@"Start recording");
}

char* stopCapture()
{
    NSString* videoPath = nil;
    
    videoPath = [recorder stopRecordingWithCompletion:^{
        NSLog(@"Finished recording");
    }];
    
    return cStringCopy([videoPath UTF8String]);
}

char* cStringCopy(const char* string)
{
    if (string == NULL)
        return NULL;
    char* res = (char*)malloc(strlen(string) + 1);
    strcpy(res, string);
    return res;
}

