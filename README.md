# Mimir

Mimir is a command-line tool designed to enhance the traditional `sleep` command, offering an improved user experience with sound effects while your computer is in a sleep state.

## Features

- Replaces the standard `sleep` command with an enriched audio experience.
- Allows setting a specific duration for the sleep state or an indefinite sleep mode until manually interrupted.
- Easy to use, with a simple command-line interface.

## How to Use

To put your computer to sleep with Mimir and play sound at a variable speed, use the following command:

```bash
mimir <seconds | inf> [standard_deviation]
```

- `<seconds>`: Specify the number of seconds for the sleep duration.
- `inf`: Enter sleep mode indefinitely until manually interrupted.
- `[standard_deviation]`: (Optional) Specify the standard deviation for the speed variation of the sound playback. If not provided, the default value of 0.1 will be used.

Examples:

- `mimir 60`: Puts the computer to sleep for 60 seconds with the default speed variation.
- `mimir 60 0.2`: Puts the computer to sleep for 60 seconds with a standard deviation of 0.2 for the speed variation.
- `mimir inf`: Puts the computer to sleep indefinitely with the default speed variation.

## Installation

To install Mimir, follow these steps:

1. Clone the repository or download the source code.
2. Navigate to the source directory.
3. Run the installation script:

```bash
sudo ./install.sh
```

## Uninstallation

To uninstall Mimir, simply run the uninstallation script:

```bash
sudo ./uninstall.sh
```

## Contributing

Pull requests are welcome! If you have suggestions for improvements or new features, feel free to submit a pull request or open an issue.

## License

```
MIT License

Copyright (c) 2023 FraioVeio

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```