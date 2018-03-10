echo -E '  __________
 / ___  ___ \
/ / @ \/ @ \ \
\ \___/\___/ /\
 \____\/____/ |
 /     /\\\\\/
|      \\\\\\\\
 \      \\\\\\\
  \______/\\\\
   _||_||_
    -- --
'



alias p="pwd"
alias l="ls"
alias ll="ls -alpth"



# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH



#change prompt
myIp="$(dig +short myip.opendns.com @resolver1.opendns.com)"
export PS1="\u@\h @${myIp}# "
