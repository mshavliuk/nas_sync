export $(egrep -v '^#' .env | xargs)

trap "exit" INT TERM ERR
trap "kill 0" EXIT



sync() {
	SRC=$1
	DST=$2
	LOG=$3


  ls -1dt $SRC/* | parallel -j 4 rsync -vaPE --stats --info=progress2 --log-file=$LOG {} $DST


#	OIFS=$IFS; IFS=$'\n';
#	LIST=( $(ls -1dt $SRC/*) );
#
#	for DIR in ${LIST[*]}
#	do
#	  echo "synching $DIR..."
#		rsync -vaPE --stats --info=progress2 --log-file=$LOG --dry-run $DIR $DST
#	done
#	IFS=$OIFS;
}

LOG=$(date +%F)_log.txt

touch $LOG
sync $SRC $DST $LOG &

tail -f $LOG

wait
