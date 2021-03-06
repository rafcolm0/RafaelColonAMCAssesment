# RafaelColonAMCAssesment
* Developer: Rafael J. Colon

## NOTES:
 * Tech stack: Swift, Alamofire, SwiftyJSON, Kingfisher.
 * Application follows MVVM design pattern. There is one main view controller with its view model for the main tableview. And there is a dynamically assigned extended UITableViewCell that acts as the "view controller" for each gallery carousel cells, each with its own view model.  All data and service objects are also modular and separated from the View and View models.
 * Comments about edge cases, concerns and suggestions provided throughout the code.
 * Photos are fetched from my Flickr galleries at: https://www.flickr.com/photos/161771981@N05/galleries. Note that these are used dynamically: each newly created gallery on my account will generate a single table view poster carousel, containing however many posters are in that referenced Flickr gallery.
 * App icons (app logo & loading placeholder) are free licensed, obtained from: https://www.iconfinder.com/icons/345353/horror_icon and https://icons8.com/icon/set/loading/all 
