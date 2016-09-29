
import Foundation

open class FolderMonitor {
    
    enum State {
        case on, off
    }
    
    fileprivate let source: DispatchSource
    fileprivate let descriptor: CInt
    fileprivate let qq: DispatchQueue = DispatchQueue.main
    fileprivate var state: State = .off
    
    /// Creates a folder monitor object with monitoring enabled.
    public init(url: URL, handler: @escaping ()->Void) {

        state = .off
        descriptor = open((url as NSURL).fileSystemRepresentation, O_EVTONLY)
        
        source = DispatchSource.makeFileSystemObjectSource(fileDescriptor: descriptor, eventMask: DispatchSource.FileSystemEvent.write, queue: qq) /*Migrator FIXME: Use DispatchSourceFileSystemObject to avoid the cast*/ as! DispatchSource
        
        source.setEventHandler { 
            handler()
        }
        start()
    }
    
    /// Starts sending notifications if currently stopped
    open func start() {
        if state == .off {
            state = .on
            source.resume()
        }
    }
    
    /// Stops sending notifications if currently enabled
    open func stop() {
        if state == .on {
            state = .off
            source.suspend()
        }
    }
    
    deinit {
        close(descriptor)
        source.cancel()
    }
}
