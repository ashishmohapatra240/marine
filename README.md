# Marine App

## Overview
Marine is a Flutter app designed to help tackle the issue of river pollution and acidification. The app allows users to upload data about the marine environment, such as the presence of garbage and the pH levels of the water, as well as track data on fish populations. The app also integrates with a robot operating system (ROS) to enable underwater cleaning of garbage. It also serves as a portal for general public to explore the aquatic flora and fauna around them.

## Implementation
To build our solution, we used Flutter for both the frontend and backend languages. We also used ROS to simulate the robot with the capability to travel underwater and pick up garbage. Python was used to develop and train our ML models, and REST APIs were used to connect our app with the ML models.

## Technical Components
- **Backend**: Firebase
- **Frontend**: Flutter
- **Technologies**: ROS, Python, REST APIs
- **Programming Languages**: Dart, Python

## Feedback / Testing / Iteration
We sent the app to a few of our friends to test and provide feedback. Based on their feedback, we made improvements to the login process, the process of uploading fish data, and the analytics page.

## Success and Completion of Solution
Our app addresses the problem of river pollution and acidification by providing users with a platform to upload data about the marine environment and track fish populations. The impact of our solution was evidenced through research papers and articles on the issue. Future plans for the app include keeping track of how clean the rivers are getting, optimizing the process for betterment of fisheries, and promoting the solution to a larger audience.

## Scalability / Next Steps
The current technical architecture of our solution is scalable, using Firebase for storing user data and integrating with ML models. We can use the same architecture to scale up our app to a larger user base.

## Installation

### Flutter

1. Install Flutter by following the instructions on the official Flutter website: https://flutter.dev/docs/get-started/install
2. Clone this repository
3. Navigate to the root directory of the project in your terminal
4. Run `flutter pub get` to install the app dependencies
5. Run `flutter run` to start the app in debug mode

### Flask API

1. Install Python 3.x
2. Install Flask by running `pip install flask`
3. Install Flask-RESTful by running `pip install flask-restful`
4. Install NumPy by running `pip install numpy`
5. Clone this repository
6. Navigate to the `ml api` directory in your terminal
7. Run `python app.py` to start the Flask API

## Credits

- Flutter: https://flutter.dev/
- Flask: https://flask.palletsprojects.com/
- NumPy: https://numpy.org/
- ML Model: https://www.kaggle.com/datasets/adityakadiwal/water-potability
