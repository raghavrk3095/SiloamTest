# SiloamTest

#### This is test assignment.

## What is done in *SiloamTest*

- Created **SignIn / SignUp** functionality using **Keychain** storage option:
  
  - User can enter username and password and it is converted to the *base64 encoded string* and stored in the *Keychain*. On successful sign up, user directs to the **sign in** page for sign in.
  - User can sign in with same credentials. It fetches the data from *Keychain*, first converts that into *base64 string*, then decodes to the *normal string* for matching purpose.

- Utilising **Meal DB API**:
  
  - Initially, there is search bar and empty list of *meals*:
  - Implemented **list all meals by first letter API** when user enter single character in search bar and showing meals as list. Emptying the list in other cases (Entering multiple characters in search bar).
  - User can see meal details on clicking of any item in list as **Lookup full meal details by id API** is implemented in detail UI.
  - User can also view meal image as **full screen image and also, zoom in / zoom out image** either by clicking image in the *meals list UI* or in the *meal detain UI*.
  - For API integration, **Alamofire** is used.

- Implemented **Unit Test** using **XCTEST** framework:

  - Created two unit test case classes -
    - Testing basic functionality of login button in one class.
    - Testing API functionality in other class. Cases include -
      - test_meals_with_one_letter
      - test_meals_with_no_letter_or_more_letters
      - test_meal_with_valid_id
