# elasticsearchdumper.sh
Dumps elasticsearch Index and delete it, this script has been developped on a FreeBSD server but can be used for any linux machine by adjusting the paths and the date format (different from GNU format), it requires the following ;

- Elasticdump, you can install it through NPM (node packet manager).
- Bash.   
- An elsticSearch stack (mine is based on FluentD, ElasticSearch and Kibana).

Note that you can change the behaviour of the script whether it closes the index, delete it or flush it.
