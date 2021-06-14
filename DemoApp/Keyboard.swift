

import SwiftUI
import Combine

final class Keyboard: ObservableObject {
  
  @Published var height: CGFloat = 0
  
  var cancellables: Set<AnyCancellable> = []
  
  init() {
    NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
      .compactMap({ (notification) -> CGFloat? in
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return nil }
        if frame.origin.y == UIScreen.main.bounds.height {
          return 0
        }
        return frame.size.height
      })
      .assign(to: \.height, on: self)
      .store(in: &self.cancellables)
  }
  
  deinit {
    self.cancellables.forEach { $0.cancel() }
  }
}

