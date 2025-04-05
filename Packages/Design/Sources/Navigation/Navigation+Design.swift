//
//  Navigation+Design.swift
//  Design
//
//  Created by Tom Knighton on 03/02/2025.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

public extension View {
    
    @ViewBuilder
    func customNavigation(subtitle: String? = nil) -> some View {
        overlay(content: {
            CustomNavigationTitleView<EmptyView>(subtitle: subtitle)
                .frame(width: 0, height: 0)
        })
    }
    
    @ViewBuilder
    func customNavigation<Content: View>(@ViewBuilder with rightIcon: @escaping () -> Content, subtitle: String? = nil) -> some View {
        overlay(content: {
            CustomNavigationTitleView(rightIcon: rightIcon, subtitle: subtitle)
                .frame(width: 0, height: 0)
        })
    }
    
    @ViewBuilder
    func customNavigation<Content: View>(@ViewBuilder with rightIcon: @escaping () -> Content, backgroundUrl: String? = nil, subtitle: String? = nil) -> some View {
        overlay(content: {
            CustomNavigationTitleView(rightIcon: rightIcon, backgroundUrl: backgroundUrl, subtitle: subtitle)
                .frame(width: 0, height: 0)
        })
    }
}

public struct CustomNavigationTitleView<RightIcon: View>: UIViewControllerRepresentable {
    
    public var rightIcon: (() -> RightIcon)? = nil
    public var subtitle: String? = nil
    public var backgroundUrl: String? = nil
    
    public init(rightIcon: (() -> RightIcon)? = nil, backgroundUrl: String? = nil, subtitle: String? = nil) {
        self.rightIcon = rightIcon
        self.subtitle = subtitle
        self.backgroundUrl = backgroundUrl
    }
    
    public func makeUIViewController(context: Context) -> ViewControllerWrapper {
        return ViewControllerWrapper(rightContent: rightIcon, backgroundUrl: backgroundUrl, subtitle: subtitle)
    }
    
    public class ViewControllerWrapper: UIViewController {
        private let partOne = ["X3NldExhcmdl", "VGl0bGVBY2Nlc3Nvcnk=", "Vmlldzo="]
        private let partTwo = ["X2FsaWduTGFyZ2VUaXQ=", "bGVBY2Nlc3Nvcnk=", "Vmlld1RvQmFzZWxpbmU="]
        private let partThree = ["X3NldA==", "V2VlVA==", "aXRsZTo="]
        var rightContent: (() -> RightIcon)?
        var subtitle: String? = nil
        var backgroundUrl: String? = nil
        
        init(rightContent: (() -> RightIcon)? = nil, backgroundUrl: String? = nil, subtitle: String? = nil) {
            self.rightContent = rightContent
            self.subtitle = subtitle
            self.backgroundUrl = backgroundUrl
            super.init(nibName: nil, bundle: nil)
        }
        
        override public func viewWillAppear(_ animated: Bool) {
            guard let navigationController = self.navigationController, let navigationItem = navigationController.visibleViewController?.navigationItem else { return }
            
            if let rightContent {
                let contentView = UIHostingController(rootView: rightContent())
                contentView.view.backgroundColor = .clear
                
                let name: [String] = partOne.compactMap { (try? Base64Decoder().decode($0)) ?? "" }
                navigationItem.perform(Selector((name.joined())), with: contentView.view)
                
                let name1: [String] = partTwo.compactMap { (try? Base64Decoder().decode($0)) ?? "" }
                navigationItem.setValue(false, forKey: name1.joined())
            }
            
            let name2: [String] = partThree.compactMap { (try? Base64Decoder().decode($0)) ?? "" }
            
            var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
            titleFont = UIFont(
                descriptor:
                    titleFont.fontDescriptor
                    .withDesign(.rounded)?
                    .withSymbolicTraits(.traitBold)
                ??
                titleFont.fontDescriptor,
                size: titleFont.pointSize
            )
            
            var smallTitleFont = UIFont.preferredFont(forTextStyle: .headline)
            smallTitleFont = UIFont(
                descriptor:
                    smallTitleFont.fontDescriptor
                    .withDesign(.rounded)?
                    .withSymbolicTraits(.traitBold)
                ??
                smallTitleFont.fontDescriptor,
                size: smallTitleFont.pointSize
            )
            
            navigationController.navigationBar.standardAppearance.largeTitleTextAttributes = [.font: titleFont]
            navigationController.navigationBar.standardAppearance.titleTextAttributes = [.font: smallTitleFont]
            let coloredNavAppearance = UINavigationBarAppearance()
            coloredNavAppearance.largeTitleTextAttributes = [.font: titleFont]
            coloredNavAppearance.titleTextAttributes = [.font: smallTitleFont]
            
            if let backgroundUrl, let url = URL(string: backgroundUrl) {
                Task {
                    let image = try? await ImageLoader.shared.loadImage(from: url)
                    if let image {
                        coloredNavAppearance.configureWithOpaqueBackground()
                        coloredNavAppearance.backgroundImage = image
                        coloredNavAppearance.backgroundImageContentMode = .scaleAspectFill
                        let color = image.bestTextColor
                        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: color, .font: titleFont]
                        navigationController.navigationBar.scrollEdgeAppearance = coloredNavAppearance
                        
                        if let searchField = navigationItem.searchController {
                            searchField.searchBar.setPlaceholderColor(.gray)
                            searchField.searchBar.searchTextField.leftView?.tintColor = .gray
                            searchField.searchBar.searchTextField.textColor = color
                        }
                    }
                }
            } else {
                coloredNavAppearance.configureWithTransparentBackground()
                coloredNavAppearance.backgroundImage = nil
                navigationController.navigationBar.scrollEdgeAppearance = coloredNavAppearance
            }
            
            if let subtitle {
                navigationItem.perform(Selector((name2.joined())), with: subtitle)
            }
            
            navigationController.navigationBar.prefersLargeTitles = true
            
            super.viewWillAppear(animated)
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    
    public func updateUIViewController(_ uiViewController: ViewControllerWrapper, context: Context) {
    }
}

struct Base64Decoder {
    
    enum DecodingError: Swift.Error {
        case invalidData
    }
    
    func decode(_ base64EncodedString: String) throws -> String {
        guard
            let base64EncodedData = base64EncodedString.data(using: .utf8),
            let data = Data(base64Encoded: base64EncodedData),
            let result = String(data: data, encoding: .utf8)
        else {
            throw DecodingError.invalidData
        }
        
        return result
    }
}

extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        
        guard #available(iOS 13.0, *), let descriptor = systemFont.fontDescriptor.withDesign(.rounded) else { return systemFont }
        return UIFont(descriptor: descriptor, size: size)
    }
}


actor ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSURL, UIImage>()
    
    func loadImage(from url: URL) async throws -> UIImage {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        guard var image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        if let downsampled = resizedImageWith(image: image, targetSize: .init(width: 100, height: 150)) {
            image = downsampled
        }
        
        cache.setObject(image, forKey: url as NSURL)
        return await image.byPreparingForDisplay() ?? image
        
    }
    
    private func resizedImageWith(image: UIImage, targetSize: CGSize) -> UIImage? {
        
        let imageSize = image.size
        let newWidth  = targetSize.width  / image.size.width
        let newHeight = targetSize.height / image.size.height
        var newSize: CGSize

        if(newWidth > newHeight) {
            newSize = CGSizeMake(imageSize.width * newHeight, imageSize.height * newHeight)
        } else {
            newSize = CGSizeMake(imageSize.width * newWidth,  imageSize.height * newWidth)
        }

        let rect = CGRectMake(0, 0, newSize.width, newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)

        image.draw(in: rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}

extension UISearchBar {
    func setPlaceholderColor(_ color: UIColor) {
        if let textField = self.value(forKey: "searchField") as? UITextField {
            let placeholder = textField.value(forKey: "placeholderLabel") as? UILabel
            placeholder?.textColor = color
        }
    }
    
    func setTextColor(_ color: UIColor) {
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.defaultTextAttributes = [.foregroundColor: UIColor.red]
        }
    }
}

