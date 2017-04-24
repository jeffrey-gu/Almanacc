# Almanacc
Almanacc is an alumni connection application for IOS. It uses the Facebook API to pull friends' locations. Almanacc is convenient because it allows you to search a specific location and see all of your friends who are Almanacc users, in that location.

In order to test the application, you must be listed as an Application developer, since our app is not in production mode. If you would like to test the app, please contact a member of our team at jessehuang@wustl.edu, rahi.r.shah@wustl.edu, jshieh@wustl.edu, or  jeffreygu@wustl.edu.

### Feature List
- Edit basic profile information: Location, Employer, Education
- Invite friends to use the app. 
- Search for friends by Location using Google Maps API; TableView will populate with names of Facebook friends in a given city
- View profiles of each friend by city
- View recent activities of all friends in a Newsfeed. The newsfeed tracks any changes to location, employer, or education.

### Technologies Used: 
- Xcode
- Firebase
- Facebook API
- Google Maps API

### Issues:
- When changing location in the profile tab, the corresponding UILabel takes upwards of 30 seconds to reflect the change (whereas the database and console are written to immediately). We asked about this on Piazza (#331), and it may be due to some background process causing the delay. However, we did not find a specific threading instance in our codebase that noticeably causes this problem.

