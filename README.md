![Python Version](https://img.shields.io/badge/python-3.x-blue?style=flat&logo=python)
![OS](https://img.shields.io/badge/OS-GNU%2FLinux-red?style=flat&logo=linux)
![GitHub](https://img.shields.io/github/license/rlyonheart/thelordsseye?ystyle=flat)
![CodeFactor](https://www.codefactor.io/repository/github/rlyonheart/thelordseye/badge)
![Lines of code](https://img.shields.io/tokei/lines/github/rlyonheart/thelordseye)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/rlyonheart/thelordseye) 
![GitHub repo size](https://img.shields.io/github/repo-size/rlyonheart/thelordseye)

An OSINT tool that searches for devices directly connected to the internet (IoT) with a user specified query.
It returns results for *Webcams*, *Traffic lights*, *Refridgerators*, *Smart TVs* etc. 

# Prerequisites
* Shodan API Key

Signup to get an api key [here](https://shodan.io)

# Installation
**Clone this repo**

<code>$ git clone https://github.com/rlyonheart/thelordseye.git</code>

<code>$ cd thelordseye</code>

<code>$ pip install -r requirements.txt</code>

# Optional Args
| Flag           | Or            |MetaVar|                 Usage|
| ------------- |:-------------:|:----------------------:|:---------:|
| <code>-o</code>      | <code>--outfile</code>      |   **FILENAME** |  *Output filename*  |
| <code>-v</code> | <code>--verbosity</code>  |    |  *run program in verbose mode*  |


> **Note**: If your search query contains spaces, you will have to put it inside " " symbols.

# Disclaimer
*This tool was developed sorely for educational purposes and should not be used in environments without legal authorization.
Therefore, the author shall not be responsible for the damages that might be done with it.*




*made with 🖤 by* [rly0nheart](https://about.me)
