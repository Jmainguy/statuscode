# HTTP Status Code Generator

This is a simple Sinatra web application that returns random HTTP status codes along with their corresponding messages. The app serves as a playful way to explore various HTTP status codes, including the traditional ones and some custom ones in the 700s.

## Features

- Returns a random HTTP status code when accessing the root endpoint (`/`).
- Returns a specific HTTP status code when accessed via the code as a parameter (e.g., `/404`).
- Provides links to the official sources for standard HTTP status codes and custom status codes.
- Displays a user-friendly message associated with each status code.

## Usage
- Random Status Code: Navigate to https://statuscode.soh.re/ to receive a random HTTP status code and message.
- Specific Status Code: To retrieve a specific status code, use the URL format https://statuscode.soh.re/{status}, where {status} is the desired HTTP status code (e.g., https://statuscode.soh.re/404).

## HTTP Status Codes
The application uses a hash to map status codes to their corresponding messages. Here are some examples:

- 200: OK
- 404: Not Found
- 500: Internal Server Error
- 701: Meh
- 702: Emacs

You can find the complete list of status codes and their meanings within the application.

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for additional status codes, feel free to open an issue or submit a pull request.

## Acknowledgments
This application references the official [HTTP Status Codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) and the [7XX RFC](https://github.com/joho/7XX-rfc) for the custom status codes.
