
import Foundation

public class FolderMonitor {
    
    enum State {
        case On, Off
    }
    
    private let source: dispatch_source_t
    private let descriptor: CInt
    private let qq: dispatch_queue_t = dispatch_get_main_queue()
    private var state: State = .Off
    
    /// Creates a folder monitor object with monitoring enabled.
    public init(url: NSURL, handler: ()->Void) {

        state = .Off
        descriptor = open(url.fileSystemRepresentation, O_EVTONLY)
        
        source = dispatch_source_create(
            DISPATCH_SOURCE_TYPE_VNODE,
            UInt(descriptor),
            DISPATCH_VNODE_WRITE,
            qq
        )
        
        dispatch_source_set_event_handler(source, handler)
        start()
    }
    
    /// Starts sending notifications if currently stopped
    public func start() {
        if state == .Off {
            state = .On
            dispatch_resume(source)
        }
    }
    
    /// Stops sending notifications if currently enabled
    public func stop() {
        if state == .On {
            state = .Off
            dispatch_suspend(source)
        }
    }
    
    deinit {
        close(descriptor)
        dispatch_source_cancel(source)
    }
}
