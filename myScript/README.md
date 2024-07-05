

## &#x2390; Script
#### &#x260d; Permission <br>
&#x23f5; *run scripts*
```shell
# with command 
>> sh "script_you_wrote"

# only file with execute permission can be run with ./ 
>> chmod +x "scripts_you_wrote"
>> ./"scripts_you_wrote"
```

&#x23f5; `chmod`
```
# long listing
>> ls -l 
...
-rw-r--r--@  1 mikiyax  staff  6626 Jul 23 01:57 README.md
drwxr-xr-x@ 10 mikiyax  staff   320 Jul 23 02:52 functions
-rw-r--r--@  1 mikiyax  staff  9060 Jul 23 02:45 main.py
drwxr-xr-x@  6 mikiyax  staff   192 Jul 23 02:01 models
drwxr-xr-x@  3 mikiyax  staff    96 Jul 23 01:57 saved
-rw-r--r--@  1 mikiyax  staff  1161 Jul 23 01:57 test.py
```

| Letter | Meaning |
| :------ | :-------: |
| `r(read)` | *read content* |
| `w(write)` | *modify content* |
| `x(execute)` | *run files that are programs* |
| `-` | "rwx" replaced by "-", meaning permission has been revoked |
| `u(user)` | apply to only the own of this file |
| `g(group)` | the group that has been assigned to the file or directory |
| `o(other)` | all other users on the system that are not any of two above |

&#x23f5; *examples*
```shell
# make this file that others user can run 
>> chmod o+x file.xxx

# give permission to run scripting file 
>> chmod +x gitPush 

# add (r) and (w) permission to both (u) and (g)
# revoke execute(x) permission from others(o) for file abc.mp4
>> chmod ug+rw,o-x abc.mp4 

# assign (r) and (x) permission to both (u) and (g) and add (r) permission to others for the file abc.c
>> chmod ug=rx,o+r abc.c
```




#### &#x260d; Universal Scripts
- *commands like "ls" are put in the /usr/bin directory. We can use these commands without specifying their path*
- *to create commands for our own purpose, we can write scripts and save to somewhere similar*
    - *just by specifying the path of the commands you saved*
    - *actually you can store wherever you want, but for consistent, storing them at the following*

<!-- &#x23f5; *set universal script* -->
```shell
# set universal script
>> touch your_script                    # write your script 
>> chmod +x your_script                 # give permission to run 
>> sudo mkdir /opt/bin                  # create directory for defined script
>> mv your_script /opt/bin              # move 

# export the path variable to .zprofile (login shell)
export PATH="/opt/bin:${PATH}"
```



