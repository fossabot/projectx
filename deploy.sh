user='devDB'
server='droplet1.dnehrig.com'
path='~/progs/devDB/'
arrow='=====>'

printf "$arrow Deploying\n"
ssh -l ${user} ${server} "/home/devDB/progs/deploy.sh"
printf "$arrow Deployment Finished\n"
