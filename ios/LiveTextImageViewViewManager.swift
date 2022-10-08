import UIKit
import VisionKit
import Vision

@objc(LiveTextImageViewViewManager)
class LiveTextImageViewViewManager: RCTViewManager {
    override func view() -> (UIView) {
        if #available(iOS 16.0, *) {
            return LiveTextImageViewView()
        } else {
            return UIView()
            // Fallback on earlier versions
        }
    }
    
    @objc override static func requiresMainQueueSetup() -> Bool {
        return false
    }
}

@available(iOS 16.0, *)
class LiveTextImageViewView : UIView {
    private lazy var interaction: ImageAnalysisInteraction = {
        let interaction = ImageAnalysisInteraction()
        interaction.preferredInteractionTypes = .automatic
        return interaction
    }()
    
    private let _imageAnalyzer = ImageAnalyzer()
    private var _mySub: Any? = nil;
    private var _imageView: UIImageView? = nil;
    
    
    override func didMoveToWindow() {
        if let imageView = self.subviews.first?.subviews.first as? UIImageView {
            self._imageView = imageView
            
            self._imageView?.addInteraction(interaction);
            
            self.attachAnalyzerToImage()
            
            self._mySub = _imageView?.observe(\.image, options: [.new]) { object, change in
                    self.attachAnalyzerToImage()
                }
            }
    }
    
    
    func attachAnalyzerToImage() {
        guard let image = self._imageView?.image else {
                return
            }
        
        Task {
            let configuration = ImageAnalyzer.Configuration([.text])
            
            do {
                let analysis = try await self._imageAnalyzer.analyze(image, configuration: configuration)
                
                DispatchQueue.main.async {
                    self.interaction.analysis = analysis
                    self.interaction.preferredInteractionTypes = .automatic
                }
            } catch {
                print(error.localizedDescription)
            }
        }
            
    }
    
    deinit {
        self._imageView = nil;
        self._mySub = nil
    }
}
