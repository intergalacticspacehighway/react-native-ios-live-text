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
    
    private let imageAnalyzer = ImageAnalyzer()
    
   
    
    @objc var enabled: Bool = false {
        didSet {
            if (enabled) {
                
                if let imageView = self.subviews.first?.subviews.first as? RCTUIImageViewAnimated {
                    
                
                        imageView.addInteraction(interaction)
                
                        guard let image = imageView.image else {
                            return
                        }
                        
                        Task {
                            let configuration = ImageAnalyzer.Configuration([.text])
                            
                            do {
                                let analysis = try await imageAnalyzer.analyze(image, configuration: configuration)
                                
                                DispatchQueue.main.async {
                                    self.interaction.analysis = analysis
                                    self.interaction.preferredInteractionTypes = .automatic
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
        }
    }
    
}
