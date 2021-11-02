![Python Version](https://img.shields.io/badge/python-3.x-blue?style=flat&logo=python)
![OS](https://img.shields.io/badge/OS-GNU%2FLinux-red?style=flat&logo=linux)
![GitHub](https://img.shields.io/github/license/rlyonheart/thelordseye?style=flat&logo=github)
![CodeFactor](https://www.codefactor.io/repository/github/rlyonheart/thelordseye/badge)
![Lines of code](https://img.shields.io/tokei/lines/github/rlyonheart/thelordseye?style=flat&logo=github)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/rlyonheart/thelordseye?style=flat&logo=github) 
![GitHub repo size](https://img.shields.io/github/repo-size/rlyonheart/thelordseye?style=flat&logo=github)

An OSINT tool that searches for devices directly connected to the internet (IoT) with a user specified query.
It returns results for *Webcams*, *Traffic lights*, *Refridgerators*, *Smart TVs* etc. 

# Prerequisites
* shodan.io API Key

Get it [here](https://shodan.io)

# Installation
**Clone repository**:
```
git clone https://github.com/rlyonheart/thelordseye.git
```

```
cd thelordseye
```

```
pip install -r requirements.txt
```

# Usage
```
python eye -q SEARCHQUERY
```

```
python eye -i IPADDRESS
```

```
python eye -p
```


**Alternatively**:
```
chmod +x eye
```

```
./eye -q SEARCHQUERY
```

```
./eye -i IPADDRESS
```

```
./eye -p
```
# Optional Arguments
| Flag          | MetaVar|                 Usage|
| ------------- |:----------------------:|:---------:|
| <code>-q/--query</code>  | **QUERY**    |  *search query; is search query contains spaces, put it inside quote " " symbols*  |
| <code>-i/--ip</code>  |  **IP**  |  *return information relating to the specified IP address*  |
| <code>-p/--ports</code>  |    |  *return a list of ports that are currently being scanned by Shodan*  |
| <code>-o/--output</code>      |   **FILENAME** |  *write output to a specified file*  |
| <code>-r/--raw</code>  |    |  *return output in raw json format (also returns more detailed information)*  |
| <code>-v/--verbosity</code>  |    |  *run thelordseye in verbose mode*  |

> **Note**: If your search query contains spaces, you will have to put it inside " " symbols.

# Disclaimer
*This tool was developed sorely for educational purposes and should not be used in environments without legal authorization.
Therefore, the author shall not be responsible for the damages that might be done with it.*
