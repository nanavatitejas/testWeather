# testWeather

#App description
This app is to display weather forcast using http://openweathermap.org/
This app is having 3 page
Landing page showing minimum 3 city weather report and maximun 7 
Current location forcast for 5 days (permisson will be aksed from user to share its location on granting it data will get displayed)
Select City page for selecting city to see weather report on landing page
I have made 3 defaults city  forcast as a part of landing page in order to make UI/UX better for the user.
Also have done JSON parsing in two ways, one with JSONDecoder and another with JSONSerialization

#Test cases

Check proper generation of URl in order to get desired data
Check request and test case for error retuning from request
Check JSON result
I have used mocked local json for implementing test cases.

# Pod required TagListView
To give better user experince while selecting city TagListView is used to display selected city, in order to remove city simple click will help user to remove selected city

