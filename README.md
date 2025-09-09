# Weather CLI

A simple Bash script to fetch and display weather information for your current location using your IP address.

## Features
- Automatically detects your current location using an IP geolocation API
- Fetches current weather for your location
- Lightweight and fast
- No dependencies except `curl` and `jq`

## Usage

1. Make the script executable:
   ```bash
   chmod +x weather.sh
   ```
2. Run the script:
   ```bash
   ./weather.sh
   ```
   The script will automatically detect your location and display the current weather.

## Requirements
- Bash
- curl
- jq

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
