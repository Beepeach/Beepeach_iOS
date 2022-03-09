import UIKit


let urlString = "http://music.naver.com/listen/top100.nhn?domain=OVERSEA&duration=1h"

let url = URL(string: urlString)

if let url = url {
    url.absoluteString
    url.scheme
    url.host
    url.path
    url.query
}




