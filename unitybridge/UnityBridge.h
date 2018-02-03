#import "ASScreenRecorder.h"

extern "C" {
    
    void startCapture();
    char* stopCapture();
    char* cStringCopy(const char* string);
    
}
