
import SwiftUI
import Combine

class CreateTweetViewModel: ObservableObject {
    func uploadPost(text: String, image: UIImage?) {
        
        guard let user = AuthViewModel.shared.currentUser else {return}
        RequestServices.requestDomain = APIConfig.Endpoints.tweets
        RequestServices.postTweet(text: text, user: user.name, username: user.username, userId: user.id) { result in
            if let image = image {
                if let id = result?["_id"]! {
                    ImageUploader.upload(paramName: "image", fileName: "image1", image: image, urlPath: APIConfig.Endpoints.uploadTweetImage(tweetId: id as! String))
                }
            }
        }
    }
}
