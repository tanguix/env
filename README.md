

# &#x231b; System
```
play with macOS setting
```
<details>
    <summary style="font-size: 2em;"><i>{...}</i></summary>


### &#x2460; Display 
**+ scale**
```
choose sacle -> more space -> night shift 
```
**+ as host machine**
```
-> advanced -> find prevent automatic sleeping on power adapter when the display is off
```
### &#x2461; Enable three finger drag
**+ accessibility:** 
```
1) pointer control -> trackpad options -> enable dragging -> three finger drag
2) display -> reduce motion (enable)
```
### &#x2462; Unnecessary apps
**+ left with:** 
```
1) finder 
    + open finder 
    + go to view -> Show Path bar -> Show Status bar
    + ctrl + click the icon on the path bar for copying the path
2) safari 
3) system preference
```
### &#x2463; Desktop & Dock
**+ hide dock:** 
```
1) set it automatically show -> Dock size & Magnification
2) position it on anywhere other than bottom
3) go to the bottom for hot corner, setup screen saver
4) mission control (bottom) 
    + displays have separate spaces --> enable (for monitor to act like individual display)
    + automatically rearrange spaces based on most use --> disable (no idea)
```

### &#x2464; Control Center
**+ Accessibility Shortcuts**
```
1) show in Control Center, not in the menu bar
2) play with it 
```
**+ scroll down spotlight**
```
don't show in the Menu Bar
```
### &#x2465; Mouse
**+ replaced by some mouse app later**
```
Accessibility -> Zoom Option -> Hover text

hover
1) Text 32pt 
2) Text font 
3) Activation modifier Option/Alt 
4) Play with color
```
### &#x2466; Arrange Launchpad
**{move unused app into one folder}**

### &#x2467; Appearance
**+ highlight color**
```
1) set favorite highlight color and accent color (usually purple)
2) set appearance to auto
```

### &#x2468; Keyboard
**+ keyboard**
```
*1) cursor smoothness (make hjkl moving smooth inside nvim)
    + increase key repeat rate to the fastest 
    + drag Delay until repeat to the shortest


2) add Unicode Hex Input (optional)
    - ∀: option + 2200
    - ∃: option + 2203
    - ¬: option + 00ac 
    - ∧: option + 2227 


3) fn (do nothing)
```


**+ input source**
```
1) add pinyin 

2) do not check "Use the CAPSLOCK key to switch to and from U.S."
```



### &#x2469; Keyboard Shortcuts

**+ General Shortcuts**
```
• Increase Indent (IDE): cmd + ] 
• Decrease Indent (IDE): cmd + [
• Move the cursor one word forward: Option + Right Arrow
• Move the cursor one word backwad: Option + Left Arrow

• Find Path: open finder => cmd + shift + g
```


**+ Mission Control (for no touchpad situation)**
```
• mission Control                       --> ctrl + up
• show notification center              --> ctrl + left
• application windows                   --> cmd + down
• show desktop                          --> ctrl + right
• move left a space                     --> cmd + left
• move right a space                    --> cmd + right
```
**+ Launchpad**
```
• turn Dock Hiding on/off               --> option + cmd + D
• show Launchpad                        --> ctrl + down
```
**+ Spotlight**
```
• uncheck both
```
**+ App Shortcut**
```
click "+"
Add shortcuts for the following apps (setup alacritty later)

-------------
| Alacritty |
-------------
    • Hide alacritty                    --> shift + cmd + alt + h

----------
| Safari |
----------
    • Show Favorites Bar                --> ctrl + f
    • Hide Favorites Bar                --> ctrl + f

----------
| Chrome |
----------
    • Always Show Bookmarks Bar         --> ctrl + f
    • Reopen Closed Tab                 --> cmd + ctrl + z

----------
| global |
----------
    • Open Location...                  --> ctrl + l
    • New Window                        --> cmd + shift + n
    • Tile Window to Left of Screen     --> ctrl + `
    • Print...                          --> ctrl + cmd + p
    • Open File...                      --> shfit + cmd + o
    • Minimize                          --> ctrl + cmd + option + M

-----------------
| shortcut tips |
-----------------
    • command + shift leftArrow
    • 

[how to restore minimized one ? don't ask me]
```
### &#x246a; Safari
**+ Preference:**
```
1) Privacy -> uncheck website tracking for enabling cookie
2) Tabs -> Compact
3) Extension -> download PocketTube: YouTube Subscription Manager (App Store)
```
### &#x246b; Notes App 
```
make use of this app 
1) Note -> Setting -> Adjust Font size 
2) ...
```
### &#x246c; Reminder App 
```
make use of this app as well
```
### &#x246d; Modified notification window
```
1) Weather: remember to set temperature to Celsius (multiple regions added)
```

### &#x246e; Install [Alfred](https://www.alfredapp.com)
**{...}**

</details>




# &#x26c5; Environment

<img src="./nvim/dashboard.png" width=800>

<details>
    <summary style="font-size: 2em;"><i>{...}</i></summary>

### &#x25cd; Zen Tree 
```
$ cd ~
$ git clone "https://github.com/"your_username"/env.git"
$ mv env .config                                    # rename to .config directory 
$ mkdir "xxx"                                       # main directory 
$ cd "xxx"
$ mkdir blackhole society toKnow 
$ cd "yyy" 
$ mkdir Cok Projects zzz
                                                    Users
                                                      |
                                                      |
                                   ----------------------------------------
                                   |                                      |
                                   |                                      |
                                 "xxx"                                 .config
                                   |                                      |
                                   |                                      |  
                    -------------------------------       ---------------------------------
                    |              |              |       |               |               |
                    |              |              |       |               |               |
                  "yyy"        blackhole       society   nvim           tmux             etc
                    |                                     |               |               |
                    |                                     ----------------------------------
    ----------------------------------                    ----------------------------------
    |               |                |                                | | ... |  
    |               |                |
   Cok           Projects           ...
```

### ➊  Install Xcode tool
```shell
xcode-select --install
```

### ➋  Install Homebrew 
&#x23f5; *homebrew from [source](https://brew.sh)*
```shell
(+) $HOME=/Users/your_username

echo '# homebrew' >> $HOME/.zprofile 
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```


&#x23f5; *basic commands with brew*
```shell
brew install xxx
brew uninstall/remove xxx
```

<details>
  <summary><i>Install Homebrew Using Mirror (collapsed)</i></summary>

*1) for users having trouble accessing brew.sh, e.g. users in China* <br>
```shell
>> cd /opt 
>> sudo mkdir homebrew 
>> sudo chown -R $(whoami):admin /opt/homebrew 
>> git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git /opt/homebrew
>> echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
(this surpress default apple git, already in zsh/)>> echo "export PATH=/opt/homebrew/bin:$PATH" ~/.zprofile
```
</details>

### ➌  Terminal Emulator
&#x23f5; *[alacritty.toml](./alacritty/alacritty.toml)*
```shell
brew install --cask alacritty
```

&#x23f5; *modify shortcut really quick*
```
1) open / 
2) drag disk and user to the side bar of finder
3) replace hide alacritty command "cmd+h" in shortcut
```

### ➍  Karabiner (virtual keyboard)
&#x23f5; *install karabiner*
```shell
brew install karabiner-elements --cask
```

&#x23f5; *Use Karabiner-Elements for key-mapping*
```
1) Click and open TWO KARABINERs for accessbility in input source inside privacy
    • allow app 
    • target decide: usually I choose for all device 
    • choose whatever you want 
    • for all devices: add item 
    • map "caps_lock" to "left_control"

2) Mapping website: https://ke-complex-modifications.pqrs.org/
    • Vi style arrow
    • click import 
    • import 
    • ok 
    • enable (only enable command + hjkl)
    • is command not control anymore

3) Search for any other combination you want
   {...}

4) Custom Rule 
    • open finder => cmd + shift + g: ~/.config/karabiner/assets/complex_modifications
```
  
### ➎  Nerd Font
&#x23f5; *go to [nerdfont](https://github.com/ryanoasis/nerd-fonts)*
```
1) patched-fonts folder
2) each font folder will have their font appearance inside, probably
3) fonts I like:
	- Monofur Nerd Font
	- Ubuntu (but its NerdFont version doesn't seem to compatible with macOS)

ex).
• Chosen_Font_Name => Light => complete
• Code New Roman Nerd Font Complete.otf 
• Download
• open the .otf file
• click install
• next go to font book looking for it
• do the italic one as well

• few selections: Monofur Nerd Font, CodeNewRoman(light is better), SourceCodePro, etc
```

&#x23f5; *patch your own font with nerdfont [patcher](https://github.com/ryanoasis/nerd-fonts/blob/master/font-patcher)*
```
1) go to nerdfont github, see option 9: Patch Your Own Font 
2) install dependencies: 
>> brew install fontforge

3) download archive scripts provided 
4) go into the nerdfont patcher diretory and execute the font-patcher script
>> fontforge -script font-patcher "/path/to/a-single-.ttf-or.otf"
```

&#x23f5; *[font-collections](./fonts/)*
```
still missing some icon even after patched, look into it later
```


### ➏  Necessity

<details>
    <summary><i>Git (collapsed)</i></summary>

`Personal Access Tokens:` *github --> settings --> developers setting --> token* <br> 
[`.gitignore`](https://www.toptal.com/developers/gitignore): *ignore file generation*

```
1) Intialize/Create Local Repo
------------------------------------------------------------------------------------
>> cd "any_directory"
>> git init                                                     // create .git 
>> git status                                                   // check branch



2) Connect Local Repo with Remote (github)
------------------------------------------------------------------------------------------------
>> git config --global user.name "github_account_name"                      // setup username
>> git config --global user.email "email_asscoiated_with_github@xxx.com"    // setup user.email
>> git config -l                                                            // check both
>> cd "xxx"
>> git branch -M main                                                       // name branch "main"
>> git remote add origin https://github.com/user_name/repo_name.git         // add remote repo
>> git remote -v                                                            // list remote repo
>> git remote set-url origin https://github.com/user_name/repo_name.git     // change remote repo
>> git config --global credential.helper store                              // if no token pop up




3) Add, Commit, Check, Pull/Push 
------------------------------------------------------------------------------------
(add)
>> git add filename.xxx                               // add single changed file
>> git add .                                          // add all changed files

(commit)
>> git commit -m "commit message"                     // describe what you changed 
>> git status                                         // check current status
>> git reset                                          // undo last commit 
>> git reset --soft HEAD~                             // undo all commit 
>> git reset --hard <git log grab SHA>                // reset to specific commit

(check)
>> git log                                            // check passed commit 
>> git log -p                                         // check detailed commit
>> git show 5eba8ab3b718a6ab6610186be934ba214e228a58  // check commit with hash
>> git diff                                           // show all modified

(pull/push)
>> git pull origin main                               // pull from remote main branch
>> git push -u origin main                            // -u: for "--set-upstream"
                                                      // main is the <branch_name>
>> git push <remote-name> <branch-name>               // other branch aside from main
>> git push origin other_branch                       // example
>> git push                                           // only have one main branch
>> git push --set-upstream origin main                // if not branch to track

(push latest one with unpush commit)
>> git log                                            // grab the log SHA 
>> git push origin <SHA>:branch --force-with-lease    // example 
>> git push origin abc123:main --force-with-lease     // cover all commits not push



4) large file
------------------------------------------------------------------------------------
>> brew install git-lfs                               // install LFS 
>> git lfs install                                    // enable through git 
>> git lfs track "video/interstallar.mp4"             // track the large file 
>> git add .gitattributes                             // only add once, lfs track will update it 
>> git add . & git commit -m "xx" 
>> git push

>> git lfs uninstall                                  // for large file only 
>> git rm --cached video/interstallar.mp4             
>> git filter-branch --force \                        // clear history
        --index-filter "git rm \ 
        --cached \ 
        --ignore-unmatch video/interstallar.mp4" \
        --prune-empty --tag-name-filter cat -- --all
>> git push origin --force --all                      // force update




5) Leave, Merge, Delete, Diverge/Converge, Rename Branch 
------------------------------------------------------------------------------------
(leave)
>> git checkout -b new_branch                         // -b: create new branchs 
>> git checkout                                       // leave current branch
>> git checkout main                                  // leave, and go to main
>> checkout branch_name                               // switch branch
>> git branch --list                                  // list all existing branches
>> git branch -a                                      // list all branch(local&remote) 
>> git branch -r                                      // list remote 
>> git push -u origin <new_branch>                    // push new branch to remote

(merge)
>> git checkout main                                  // leave the branch about to merge to main
>> git branch                                         // try, won't kill you
>> git merge gh-pages                                 // merge branch "gh-pages" to main
>> git push origin main                               // push all the new changes merged to main

(delete) 
>> git branch -d branch_name                          // first delete local branch
>> git push origin --delete branch_name               // delete remote branch as well

(diverge/converge)
'''
if you make changes directly through github(remote)
and make different changes in local repo at the same time 
will cause version conflict 
'''
>> git pull origin main                               // pull from remote branch main
>> git status 
>> git merge origin/branch_name                       // here branch_name = main

(rename)
>> git branch -m older_name new_name                  // rename local repo
>> git fetch origin 
>> git branch -u origin/new_name new_name 
>> git remote set-head origin -a
# change remote
>> repo -> settings -> under Code and automation -> click Branches -> rename
```
</details>


```shell
# install through homebrew
>> brew install git
>> git --version

# apple's git default, download env, so you have zsh/ 
# then export git path for replacing apple default git
>> echo 'export PATH="/opt/homebrew/bin:${PATH}"' >> $HOME/.config/zsh/zsh-exports
```

&#x23f5; *C++ compiler*
```shell
# many things depends on this gcc
>> brew install gcc
```

&#x23f5; *mongoDB: [server](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-os-x/)* | *[compass](https://www.mongodb.com/try/download/atlascli) (choose ARM64 Platform)*
```shell
# install mongoDB server
>> brew tap mongodb/brew

# install community edition (refer to the official doc for versions)
>> brew install mongodb-community

# if run into error "brew services list"
>> brew update-reset
>> brew doctor
>> brew services list

# start for use
>> brew services start mongodb-community@7.0
>> brew services stop mongodb-community@7.0
>> mongosh  # for checking
```

&#x23f5; *Node.js: [macOS installer LTS version](https://bit.ly/nodenpm)*
```shell
# better to download prebuild version through website
>> node --version
>> npm --version
```


&#x23f5; *additional*
```shell
# for what?
brew install ripgrep

# print out structure of directory in terminal 
brew install tree
```


&#x23f5; *YouTube Video [`Download`](https://github.com/yt-dlp/yt-dlp)*
```shell 
>> brew install yt-dlp
>> ffmpeg

# basic download
>> yt-dlp "https://www.youtube.com/watch?v=8PsG3ycLx3o"

# setting up the resolution for downloading (less or equal than 4k if videos are available)
>> yt-dlp -f "bestvideo[height<=2160][ext=webm]+bestaudio[ext=m4a]/best[height<=2160]" --merge-output-format mp4 "<youtube url>"

# convert video to MPEG-4
>> ffmpeg -i <video1.mp4> -vcodec libx264 -acodec aac <video2.mp4>

# for some videos, if store differently on youtube, will download separate files (.m4a & webm), mannully convert 
>> ffmpeg -i "video_name.webm" -i "video_name.m4a" -c:v copy -c:a copy "video_name.mp4"

# convert video to audio file (e.g. mp4/mkv to mp3)
>> ffmpeg -i input.mkv -b:a 192K -vn output.mp3
```



&#x23f5; *Sound Player*
```shell
# play .wav file 
>> brew install sox 
>> sox /path/to/wav_file -d
```



&#x23f5; *Find IP Address*
```shell
# on linux/unix 
# find the inet value under 'wlp39s0', usually the last one
>> ifconfig
>> ip addr

# more straightforward way of checking the address
>> ifconfig | grep "inet "
```

&#x23f5; *Setup Static IP or DHCP*
```shell

```

&#x23f5; *SSH*

```shell
# check if ip-address exist in remote, if not then used jump host
>> nslookup 

# direct connection
>> ssh -i xxx_xxx.pem username@ip-address

# Need to change permission if using key file(.pem)
>> chmod 600 ~/.ssh/xxx_xxx.pem
>> ssh my-server

# local ssh config, read more: https://linux.die.net/man/5/ssh_config
>> vim ~/.ssh/config
---------------------------------------------------------
| Host lambda-server-1                                  |
|   HostName xxx.x.xxx.xx                               |
|   User ubuntu(or others)                              |
|   IdentityFile ~/.ssh/xxxxxx.pem                      |
|                                                       |
| Host lambda-server-2                                  |
|   HostName yyy.y.yyy.yy                               |
|   User ubuntu                                         |
|   IdentityFile ~/.ssh/yyyyyy.pem                      |
|                                                       |
| Host my-server                                        |
|   HostName zzz.zzz.z.zzz                              |
|   User my_username                                    |
---------------------------------------------------------
```
&#x23f5; *FileZilla Setup ([Jump Host](https://www.unixcloudfusion.in/2016/01/using-filezilla-to-connect-ec2-with.html))*

| Connection Type | Inputs |
| :------ | :-------: |
| normal connection | *Host - Username - Password - Port* |
| connect as jump host | *1) Settings > Generic Proxy > `Sock 5`* <br> *2) Proxy host: `127.0.0.1` - Proxy port: `8001`* |
| with private key(.pem) | *1) File - Site Manager - New Site* <br> *2) Protocol: select the `SFTP` one -> Host: `ip-address`* <br> *3) Logon Type: `Key File` -> User -> Location of key file* |


&#x23f5; *Remote Connection [FileZilla](https://filezilla-project.org)*
```
# SSH setup for remote login with .pem (keyfile)
1) unzip and put it into Application                                  
2) open FileZilla, click File on the top-left, select Site Manager... 
3) New site, name it                                                  
4) Protocol: select SFTP - SSH File Transfer Protocol                 
5) Host: Enter the specific ip address for remote server              
6) Logon Type: select Keyfile                                         
7) User: xxxx [xxxx@xxx.xxx.xxx.xxx]                                  
8) Browse your Keyfile                                                
9) connect                                                            
10) drag and draw                                                     
```


### ➐  Terminal Level
#### &#x260d; tmux
&#x23f5; *[tmux.conf](./tmux/tmux.conf)*
```shell
# configuration explained in .conf
>> brew install tmux

# checking if tmux is missing some color
# path variable needed to be setup first, and you have to be inside tmux session
>> tmux info | grep -e RGB -e Tc

# for tmux package manager to work in the tmux.conf 
# first need to download it 
>> git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
>> tmux
>> prefix + I       # for downloading necessary plugins
```

#### &#x260d; zsh
```
brew install zsh
```
&#x23f5; *Add the following command to **.zprofile***
```
# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# zsh config dir
export ZDOTDIR=$HOME/.config/zsh

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
```
&#x23f5; *Setup zsh Directory(or just download zsh/)*
```
# you can download all from env
>> cd ~/.config 
>> mkdir zsh 
>> touch .zshrc
```
&#x23f5; *Configure zsh Directory*
```
# powerlevel10k (before you know how to write your own prompt use this)

# path variables all setup within zsh/, just need to check path correstness
>> brew install powerlevel10k
# keep track of the installation path of powerlevel10k
>> echo "source '$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme'" >> ~/.config/zsh/.zshrc
# "$(brew --prefix)" is basically where your homebrew lies "/opt/homebrew"
>> cd zsh 
>> git clone "...zsh_directory_in_github_repo..."
>> if the syntax highlighting and autocomplete not working, remove and reinstall
```

#### &#x260d; Neovim
[`my config`](./nvim/) | [`kickstart.nvim`](https://github.com/nvim-lua/kickstart.nvim)

```shell
>> brew install neovim
# remove cache, don't know why, I guess this make sure new config doesn't mixed with old ones
>> rm -rf ~/.local/share/nvim/

~/.config/nvim/
├── init.lua
├── lazy-lock.json
├── lua/
│   ├── "your_username"/
│   │   ├── core
│   │   │   ├── init.lua
│   │   │   ├── keymaps.lua
│   │   │   └── options.lua
│   │   └── plugins
│   │       ├── lsp/
│   │       ├── nvim-tree.lua
│   │       ├── ...(list of plugins config)
│   │       └── dashboard.lua
│   └── lazy.lua

# download all nvim/ setting, let Lazy & Mason do their job
# some lsp server require npm to be installed as dependency, so make sure install that first
>> :Lazy 
>> :Mason
```


&#x23f5; *Notes*
| Target  | Action    |
| :------ | :-------: |
| `/` | *match words for searching (n: next, N: previous)* |
| `:Open Buffer` | *- oepn file to buffer: `:e "path/to/file`* <br> *- new empty buffer: `<leader> + b`* |
| `:Lazy`  |  *Lazy Console UI*  |
| `:Lazy reload "some_file.nvim"` | *reload certain .nvim plugins to take effect(no path needed)* |
| `:Lazy sync` | *download all new plugins* |
| `:NvimTree` | *- toggle open/close: `ctrl + n`* <br> *- mark file: `m`* |
| `:Telescope` | *- all file: `<leader> f f`* <br> *- for only opened buffer: `<leader> f b`* |
| `:ColorizerToggle` | *cancel color preview from current buffer* |
| `:TSInstall python` | *- install new highlighters(name): `:TSInstall <name>`* <br> *- check installed syntax: `TSInstallInfo`* |
| `:Mason`  |  *Mason LSP Console UI*  |
| `:MasonUninstallAll`  |  *uninstall all lsp-server through mason*  |
| `:MasonInstall <name>` | *LSP plugin manager, if new plugins not listed, exit and reopen with vim* |
| `:I`  |  *Install the package under the cursor*  |
| `:u`  |  *Update the package under the cursor*  |
| `:U`  |  *Install all package under the cursor*  |
| `:X`  |  *Uninstall the package under the cursor*  |



#### &#x260d; Script
&#x23f5; *automate operation that are repetitive for your convenience, refer to my [`scripts`](./myScript/README.md)*
```
# original git operation
>> git add .
>> git commit -m "message"
>> git push (-u origin main)

# custom script wrapped up all three lines
>> gpush
```


#### &#x260d; Conda
&#x23f5; *miniconda (silicon difference)*
```
# for apple silicon (arm64)

# there seems to have a mamba environment preinstall in latest version
>> brew install miniforge 
>> conda init "$(basename "${SHELL}")"
(this conda init line basically adding the following)
# =========================
# >>> conda initialize >>>
# __conda_setup="$(...)"
# if ...
# ...
# fi ...
# unset __conda_setup
# <<< conda initialize <<<
# =========================
```

&#x23f5; *conda command notes*
```
# create new env 
>> conda create -n myenv python=3.x     # python version 
>> conda create -n myenv scipy          # with sepcific package

# remove conda env 
>> conda remove --name myenv --all

# install packages using .yml in existing conda env 
# --prune: this command remove dependencies that are no longer listed in the .yml file
# --name myenv: sepcify which env to update
>> conda env update --name myenv --file xxx.yml --prune 

# when you update env using .yml file, few things to notice 
# 1) comment the "name:" section in the .yml file, 
#    otherwise it will create another env if name is not the same as the current one
# 2) newer version will be overrided by older version 
#    - in my case, if tensorflow is installed with python=3.10, and pytorch is 3.9 
#    - then tensorflow will be removed after install pytorch using .yml file 
# 3) newer version is compatible with older version (mostly) 
#    - install pytorch with python=3.9, then install tensorflow with python=3.10 if fine
```

&#x23f5; *pytorch*: [*official website*](https://pytorch.org) *or refer to* [*yaml file*](https://github.com/jeffheaton/app_deep_learning/blob/main/install/pytorch-install-aug-2023.ipynb)
```shell
# basic setup for pytorch conda in macOS
>> conda create -n env & conda activate env     # create new env
>> pip3 install torch torchvision torchaudio    # torch website, select stable/nightly version


# use mps 
>> conda env create -f torch-conda.yml 
================= .yml =================
name: [your-env-name]
channels:
  - pytorch
  - conda-forge
dependencies:
    - python=3.11
    - pip>=19.0
    - pytorch 
    - torchvision 
    - torchaudio
    - jupyter
    - scikit-learn
    - scipy
    - pandas
    - pandas-datareader
    - matplotlib
    - pillow
    - tqdm
    - requests
    - h5py
    - pyyaml
    - flask
    - boto3
    - ipykernel
    - pip:
        - bayesian-optimization
        - gym
        - kaggle
================= .yml =================

# connect to jupyter notebook
>> python -m ipykernel install --user --name torch --display-name "Python 3.10 (pytorch)"
>> jupyter notebook                             # test 

# macOS m-chip use MPS (Apple Metal for GPU), target MPS for training.
>> has_mps = getattr(torch, 'has_mps', False)
>> device = "mps" if getattr(torch, 'has_mps', False) \
else "gpu" if torch.cuda.is_available() else "cpu"
```

&#x23f5; *python test* <br>
```python
import torch
import math

# this ensures that the current MacOS version is at least 12.3+
print(torch.backends.mps.is_available())
# this ensures that the current current PyTorch installation was built with MPS activated.
print(torch.backends.mps.is_built())
```

&#x23f5; *how to remove ipykernel name*
```
# check kernel list 
>> jupyter kernelspec list 
>> jupyter kernelspec uninstall kernel_name
```

&#x23f5; *Tensorflow: [here](https://github.com/jeffheaton/t81_558_deep_learning/tree/master/install)*
```
>> cd ~/anywhere-yml-for-installation

# go to base environment 
>> conda install -y jupyter 
>> conda deactivate 
>> conda env create -f tensorflow-apple-metal.yml -n tensorflow
>> conda info -e 
>> conda activate tensorflow
>> python -m ipykernel install --user --name tensorflow --display-name "Python 3.10 (tf)"
>> jupyter notebook

# check 
>> tf.config.list_physical_devices('GPU')
```

#### &#x260d; Aerospace Tiling Window Manager 
[tutorial_link](https://www.youtube.com/watch?v=-FoWClVHG5g)
[latent_space_visualization](https://www.youtube.com/watch?v=o_cAOa5fMhE)

#### &#x260d; C++
&#x23f5; *Compile .cpp file and run*
```
# full command 
>> g++ -Wall -std=c++20 xxx.cpp -o run && ./run

# compiler:                  g++
# warnings:                  -Wall
# C++ version:               std=c++20
# program to compile:        xxx.cpp
# name your compiled file:   -o run
# run compiled file:         ./run
```

&#x23f5; *Check a GLIBCXX*
```
# 1) if you know the file 
>> strings /usr/lib64/libstdc++.so.6 | grep GLIBCXX 

# 2) check globally 
>> strings $(g++ -print-file-name=libstdc++.so) | grep GLIBCXX 

# 3) check the path to the 'libstdc++.so' library that was used to compile 'my_program'
>> ldd my_program | grep libstdc++
```

&#x23f5; *SFML Library*
```
brew install sfml
brew info sfml

# find the where sfml folder has beedn downloaded
# aside from the usual command, two path need to sepcify
# where is SFML package (I)
# where is the necessary libraries (L)
```
&#x23f5; *Compile SFML (a bit messy)*
```
>> g++ test.cpp -Wall -I/[1] -o run -L/[2] -lsfml-graphics -lsfml-window -lsfml-system

# [1]: opt/homebrew/Cellar/sfml/2.5.1_1/include
# [2]: opt/homebrew/Cellar/sfml/2.5.1_1/lib
# [?]: you can try build with source, and save the package to somewhere with less name
```
   
#### &#x260d; Java
&#x23f5; *Download java env*
```
# 1. Java (JDK): https://java.com/en/download/help/develop.html
# 2. Java SE Development Kit: https://www.oracle.com/java/technologies/downloads/
# 3. restart terminal
    
>> javac file.java
>> java file
```

#### &#x260d; VimTex

&#x23f5; *VimTex [repo](https://github.com/lervag/vimtex)* <br>
```
# compiler is needed, but you don't have to install the whole MaxTex
# ------------------------------------------------------------------

# option that I had tried
>> brew install --cask mactex-no-gui

# other option
>> brew install --cask basictex

# also inside plugin.lua 
>> use 'lervag/vimtex'
```
&#x23f5; *check if successfully installed*
```
>> latexmk 
>> pdflatex
```

&#x23f5; *generate pdf through command line*
```
>> pdflatex xxx.tex 
```
&#x23f5; *inside .tex file*
```
:echo g:vimtex_view_enabled
```
&#x23f5; *PDF preview plugin* <br>
&#x23f5; *add the configuration to VimTex.lua setting skim as default preview app*
```
>> brew install --cask skim
>> echo "vim.g['vimtex_view_method'] = 'skim'" >> ~/.config/.../VimTex.lua
```
&#x23f5; *[mapping shortcut](https://www.ejmastnak.com/tutorials/vim-latex/vimtex.html#options)*
```
[normal mode]:
--------------
dse: Delete surrounding environments(\begin{} and \end{}

cse: Change surrounding environments(change what's in bracket)

..map them with alacritty..
```

&#x23f5; *basic command*
```
# compile .tex file to pdf -> mapped with <leader>r
:VimtexCompile

# 
:
```


### ➑  Fun Stuff

&#x23f5; *LSCOLORS*
```
echo '\n# customize LS-colors (directory) https://geoff.greer.fm/lscolors/' \ 
>> ~/.config/zsh/.zshrc 
echo '# green & unbold' >> ~/.config/zsh/.zshrc 
echo 'export LSCOLORS=cxfxexdxbxegedabagacac' >> ~/.config/zsh/.zshrc
```

&#x23f5; *openssl*
```
>> brew install openssl

# sometimes openssl@3, follow the tips output from the terminal shell
# mostly, the terminal output will prompt you to set path variable

echo 'export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"' >> ~/.config/zsh/.zshrc
echo 'export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"' >> ~/.config/zsh/.zshrc
echo 'export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"' >> ~/.config/zsh/.zshrc
```
&#x23f5; *MacOS control -> [drag windows without titlebar](https://www.mackungfu.org/UsabilityhackClickdraganywhereinmacOSwindowstomovethem)*
```
# enable
>> defaults write -g NSWindowShouldDragOnGesture -bool true
>> exit

# disable
>> defaults delete -g NSWindowShouldDragOnGesture
```

&#x23f5; *for fun*
```
brew install numi --cask
brew install keycastr --cask
brew install cmatrix
sudo npm install -g mapscii      # require node.js installed
brew install cointop
brew install bpytop 
brew tap teamookla/speedtest
brew update
brew install speedtest --force 
brew uninstall speedtest --force
```

<details>
    <summary><i>Ubuntu Keymap (collapsed)</i></summary>


*• gnome-desktop*
```shell
sudo apt install gnome-tweak
```
*• tweak-tool* 
```
# search for tweak, open it 
1) Startup Applications
    + Caffeine indicator 
2) Top Bar 
    + Weekday 
    + Date 
3) Keyboard & Mouse 
    + Show Extended Input Sources ? 
    + Mouse 
        > Pointer Location 
        > Middle Click Paste 
    + Touchpad 
        > Disable While Typing 
    + Mouse Click Emulation 
        > Fingers 
    + Additional Layout Option 
        > Caps Lock Behavior: ...
        > Ctrl Position
            - Caps Lock as Ctrl
            - (you can move between tabs using capslock + key1...9)
        > Alt and Win behavior 
            - Meta is mapped to win (disable super for search)
    + Enable Emacs input (======== not perfect, better to use vim-style moving like karabiner =======)
        > Ctrl+a: to move the cursor to the beginning of the line
        > Ctrl+e: to move the cursor to the end of the line
        > Ctrl+k: to cut the text from the cursor to the end of the line
        > Ctrl+y/v: to paste the most recently cut text
        > Ctrl+p: (previous) and `Ctrl+N` (next) to navigate up and down in history or suggestions
        > Ctrl+b: to move the cursor back one character
        > Ctrl+f: to move the cursor forward one character
        > Ctrl+d: to delete the character under the cursor
        > Ctrl+h: to delete the character before the cursor
    - lose some shortcut once Emacs input enable (you have to do it by hand)
        > ctrl + a: select all, still work on page level or folder level, just doesn't work for text-input level
            >> but text-level select all could be replaced by Super + A
        > ctrl + w: can't close tab is on text/typing
    + still missing two shortcut, move a line up and down globally like karabiner does

# Find something like xbindkeys, or find out why xbindkeys is not working

# Open setting |- Keyboard |- View and Customize Shortcuts 
1) Accessibility
    ( don't know why, but zoom in and zoom out could use ctrl+= & ctrl+-)
    + Zoom in: Disabled 
    + Zoom out: Disabled
2) Launchers 
    + Home folder: Alt+Super+H
    + Launch terminal: Alt+Super+T
    + Launch web browser: Alt+Super+B
    + Setting: Alt+Super+S
3) Navigation
    + Hide all normal windows: Disabled
4) System 
    + Focus the active notification: Disabled (leave super + N)
    + Show the notification list: Disabled (leave super + M and super + V)
    + Restore the keyboard shortcuts: Disabled (avoid miss type)
    + Show the overview: Super + Space (it's like Alfred)
    + Lock Screen: Alt + L 
    + Show all application: Alt + A
5) Windows 
    + Hide window: Disabled (free Super + H)
    + Navigation between tabs in browser or tmux, we usually used Command + 1/2/3/... or Super + 1/2/3/...
        > disable it gnome-wise 
            # in ubuntu, Super + num were mapped to switch between applications in the dock order, 
            # disable it gnome-wise using "gsettings"
            # "N" represent the number you want to unbind, in ubuntu's case, you have to unbind 0-9 separately
            >> "gsettings set org.gnome.shell.keybindings switch-to-application-N []"
            >> gsettings set org.gnome.shell.keybindings switch-to-application-0 []
            >> gsettings set org.gnome.shell.keybindings switch-to-application-1 []
            ...
        > However, for browser you can use ctrl + numbers to navigate. For tmux tabs, map Ctrl to use them in alacritty is also a solution (below)

# alacritty 
    + key_bindings
        > setup copy and paste with super key in alacritty 
            # copy 
            - { key: C mods: Super, action: Copy }
            # paste 
            - { key: V mods: Super, action: Paste }
            # remember to use ctrl + c/v outside of alacritty, ctrl + t for new tabs or something
        > change all tmux binding from using Command to Super
            # split pane left and right
            - { key: M, mods: Super, chars: "\x01\x4d" }          
            # split pane top and down
            - { key: B, mods: Super, chars: "\x01\x42" }
            # save neovim 
            - { key: S, mods: Super, chars: "\x1b\x3a\x77\x0a" }
            # rename current session
            - { key: R, mods: Super, chars: "\x01\x24" }
            # new tmux window 
            - { key: T, mods: Super, chars: "\x01\x63" }
            # detach current session 
            - { key: D, mods: Super, chars: "\x01\x64" }
            # select a tmux session to attach while inside tmux (p stands for preview): original command prefix + w 
            # disable Super + P in Ubuntu's default binding: 
            # >> gsettings set org.gnome.mutter.keybindings switch-monitor "['']"
            # re-enable:
            # >> gsettings set org.gnome.mutter.keybindings switch-monitor "['<Super>p']"
            - { key: P, mods: Super, chars: "x01\x77" }
            # select window 1-9 
            - { key: Key1, mods: Control, chars: "\x01\x31" }
            - { key: Key2, mods: Control, chars: "\x01\x32" }
            - ...

        > option will be considered as Alt, so you need to remove other minor keybind used Alt 
            # comment out
            - { key: D, mods: Option, chars: "\x64\x73\x65" }
            # comment out
            - { key: C, mods: Option, chars: "\x63\x73\x65" }

# enable Emacs input (untested)
    + navigation mapping
        > Super + a = Home key 
        > Super + e = End key 
        > Super + h = Ctrl + leftarrow
        > Super + j = Ctrl + Downarrow
        > Super + k = Ctrl + Uparrow
        > Super + l = Ctrl + rightarrow
```


</details>



</details>


# &#x26f2; Application

<details>
    <summary style="font-size: 2em;"><i>{...}</i></summary>

### &#x260d; Download
*[QuickTime Player](https://www.youtube.com/watch?v=LSmM5FXzVBg)*
```
[OK] chrome
[OK] zoom.us
[OK] notability
[OK] movist
[?] cursor Pro
[?] xcode (app store)
[?] The Unarchiver (app store)
[?] parallels
[?] blender
[?] Unzip One
```

### &#x260d; vscode

&#x23f5; *settings*
```
@ Open Settings (cmd+,) 
======================================
1) Font Family: SauceCodePro Nerd Font
2) Font Size: 13
3) Cursor Style: underline

@ theme
1) Tokyo Night*
2) Monokai Pro 
3) Nord
======================================
```


&#x23f5; *shortcuts* | link: [[1]](https://michaelychen.medium.com/my-experience-using-vim-keybindings-in-vscode-ea6d335aa155)
[[2]](https://www.youtube.com/watch?v=H2gvHxC9gFY)
[[3]](https://www.youtube.com/watch?v=fJEbVCrEMSE)
[[4]](https://www.youtube.com/watch?v=Ljv1ejQQk-U)
[[5]](https://www.youtube.com/watch?v=zwyHmFxeJtg)
```
# vscode => View => Command Palette...  => macos shortcuts
@ Command Palette                       --> cmd + shift + p
@ keyboard shortcuts                    --> bottom left setting icon  
                                        ==> click top-right corner file icon to open "keybindings.json"
                                        ==> also find "~/Library/Application Support/Code/User/keybindings.json"

# Basic (Search in Command Palette)
===================================
• close command palette                 --> [ESC]
• Open File/Folder                      --> cmd + o
• Open Recent                           --> cmd + r
• Run Python File                       --> cmd + enter
• Toggle Side Bar                       --> cmd + b
• New File                              --> cmd + n
• Delete File in toggle bar             --> cmd + delete
• Toggle Terminal                       --> ctrl + t

# navigation (j and k is used for switching focus, better to use one key)
=========================================================================
• resize terminal left                  --> ctrl + shift + h
• resize terminal down                  --> ctrl + shift + j
• resize terminal up                    --> ctrl + shift + k 
• resize terminal right                 --> ctrl + shift + l
• navigate editor group                 --> { 
                                                "key": "ctrl+1", 
                                                "command": "workbench.action.focusFirstEditorGroup"
                                            },
• navigate tabs (1,2,3,n)               --> { 
                                                "key": "cmd+1", 
                                                "command": "workbench.action.openEditorAtIndex1" 
                                            },
• focus on terminal                     --> {
                                                "key": "ctrl+j",
                                                "command": "workbench.action.terminal.focus"
                                            },
• focus on editor                       --> {
                                                "key": "ctrl+k",
                                                "command": "workbench.action.focusActiveEditorGroup",
                                                "when": "terminalFocus" 
                                            }

# connection 
============
• Remote-SSH: Connect to Host...        --> ctrl + shift + c
```


&#x23f5; *extension* | [theme](https://www.youtube.com/watch?v=tUUI5hKw0DQ) 
| [ssh](https://support.cs.wwu.edu/home/survival_guide/tools/VSCode_Jump.html) 
| [vim](https://www.youtube.com/watch?v=ShfVJ04RHmw) 
| [turnoff](https://www.youtube.com/watch?v=fmzVJ0Wt29I)
```
# "Remote - SSH" Extension
# =========================
# 1) Command Palette -> ssh -> + Add New SSH Host.. -> open /Users/mikiyax/.ssh/config
# 2) Connect to HOST through a jump host, or you can't connect jump host solely
Host Jump-Host
    Hostname xxx.xx.xxx.com
    Port 22
    User xxx
    ForwardX11 yes
    ForwardX11Trusted yes
  
Host Destination-Host
    HostName xxx.xxxxxxx.xxx.com
    Port 22
    User xxxxxx
    ForwardX11 yes
    ForwardX11Trusted yes
    ProxyJump Jump-Host

Host Use-key 
    HostName 11.111.111.111 
    User xxxx 
    IdentityFile ~/.ssh/xxx.pem


# Markdown Preview 
# ================= 
# 1) built-in 
# 2) open .md file, and look for the unique icon on the top right beside run icon
```


### &#x260d; Window Management 
&#x23f5; *install [Amethyst](https://github.com/ianyh/Amethyst) and enable accessibility features*
```
brew install --cask amethyst
```
&#x23f5; *preference setting*
```
1) Floating --> choose automatically float all applications except those listed
    + Alacritty
    + Google Chrome
    + Notability
    + Safari
    + Preview (MacOS pdf)
    + Skim
    + ...

2) Mouse
    + check resize windows using mouse
    + check swap windows using mouse

3) Layouts
    + add 3 Column Middle

4) General 
    + window margins enable 
        • 15px 
    + smart window enable 
    + screen padding 
        • all set to 10px for now

5) Shortcut (farthest-left window is the main pane by default) 
    + shrink main pane:                                     --> control + shift + H
    + expand main pane:                                     --> control + shift + L 
    + move focus to main window:                            --> control + shift + M
    + move focus counter clockwise:                         --> control + shift + k
    + move focus clockwise:                                 --> control + shift + J 
    + swap the focused window with main window:             --> control + shift + enter
    + swap focused window to counter clockwise:             --> control + option + shift + K
    + swap focused window to clockwise:                     --> control + option + shift + J
    + swap focused window to counter clockwise screen:      --> control + option + shift + H
    + swap focused window to clockwise screen:              --> control + option + shift + L
    + select main layout(currently is 3columns):            --> control + option + cmd + M
    + select Column Layout:                                 --> control + option + shift + N
    + select Row Layout:                                    --> control + option + shift + B
    + relauch Amethyst                                      --> control + option + cmd + Z
    + ...more to setup...(throw screen n, focus screen n)   --> for now just use mouse

6) different screen/desktop could have different layouyt (I guess, not certain)
    >> go to the long vertical one, and use shortcut to setup the Row Layout
    >> it's just need to manually specify each time
```

</details>


# &#x26f3; To-Do 
- [ ] *[Yabai](https://www.youtube.com/watch?v=k94qImbFKWE) usage & configuration*
- [ ] *Jupyter Notebook & Colab IDE configuration*
- [ ] *Custom Command Prompt (zsh) as good as the current one without using powerlevel10k*




