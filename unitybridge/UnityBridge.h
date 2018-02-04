#import "ASScreenRecorder.h"

extern "C" {
    
    void startCapture();
    void stopCapture();
    
    char* cStringCopy(const char* string);
    
    void framework_trigger_delegate();
    typedef void (*DelegateCallbackFunction)(char* path);
    void framework_setDelegate(DelegateCallbackFunction callback);
    void framework_sendMessage(char message);
    
}

