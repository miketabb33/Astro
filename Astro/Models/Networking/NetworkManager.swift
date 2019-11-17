import Foundation

class NetworkManager {
    func createDataTask(session: URLSession, url: URL, onSuccess: @escaping (Data?) -> ()) -> URLSessionDataTask {
        return session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error in request: \(error)")
            } else {
                onSuccess(data)
            }
        }
    }
}
