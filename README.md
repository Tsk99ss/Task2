# E-Commerce Flutter App

This is a simple e-commerce application built with Flutter. It features a splash screen, login screen, category dashboard, product details screen, and cart screen. It uses the [Fake Store API](https://fakestoreapi.com/) to fetch and display dynamic product data.

## Features

- **Splash Screen**: Displays the app logo with a 3-second delay before navigating to the login screen or home screen if already logged in.
- **Login Screen**: Users can log in using email and password, with form validation. The login state is saved using Shared Preferences.
- **Dashboard Screen**: Displays product categories fetched from the Fake Store API in a grid view. Allows users to tap on a category to view products.
- **Product Details Screen**: Shows product details, including an image, title, description, and price. Users can add items to the cart.
- **Cart Screen**: Displays the list of products added to the cart. Users can edit the quantity, remove items, and view the total price.
- **Persistent Login**: Once logged in, users will be redirected directly to the home screen on subsequent app launches.

## Screens

1. **Splash Screen**
2. **Login Screen**
3. **Dashboard Screen**
4. **Product Details Screen**
5. **Cart Screen**

## API

The app uses the [Fake Store API](https://fakestoreapi.com/) to fetch categories and product data.

### Endpoints Used:

- Categories: `https://fakestoreapi.com/products/categories`
- Products: `https://fakestoreapi.com/products`
- Product by Category: `https://fakestoreapi.com/products/category/{category}`

## Setup Instructions

1. Clone the repository:

    ```bash
    git clone https://github.com/yourusername/ecommerce_flutter_app.git
    ```

2. Navigate to the project directory:

    ```bash
    cd ecommerce_flutter_app
    ```

3. Install the necessary dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app:

    ```bash
    flutter run
    ```

## Dependencies

- `flutter`
- `http`: For making API requests.
- `shared_preferences`: For persisting login state.
- `carousel_slider`: For displaying a carousel slider in the dashboard screen.



