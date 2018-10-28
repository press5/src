## add_other_resolvers.sh - add other resolvers to /etc/resolver 
## (see 'man 5 resolver' for more info)
## 03192017 jkl 

# if /etc/resolver doesn't exist make it 
[ -d /etc/resolver ] || mkdir /etc/resolver; 

# provide for the OpenNIC Project (opennicproject.org) and a few TLD's:
tee <<EOF /etc/resolver/_opennic >/dev/null
nameserver 185.121.177.177
nameserver 2a05:dfc7:5::53
nameserver 185.121.177.53
nameserver 2a05:dfc7:5::5353
nameserver 185.190.82.182
nameserver 2a0b:1904:0:53::
EOF

ln -fs _opennic /etc/resolver/o
ln -fs _opennic /etc/resolver/dyn
ln -fs _opennic /etc/resolver/oss
ln -fs _opennic /etc/resolver/bbs
ln -fs _opennic /etc/resolver/free
ln -fs _opennic /etc/resolver/geek


# that's all for now

