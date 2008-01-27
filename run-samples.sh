#!/bin/sh

if [ $# -eq 0 ]
then
    JPS="javapetstore.petstore javapetstore.supplier javapetstore.waf"
    SAMPLES="apache-ant commons-lang jdom spring struts-cookbook $JPS"
else
    SAMPLES=$1
    shift
fi

export ANT_OPTS="-Xmx512M -Dfile.encoding=UTF-8 -Dcom.sun.management.jmxremote"

cd src
for sample in $SAMPLES
do
    echo "============ Running Glean over $sample code ==============="
    ant -Dfeedback.properties=sample/$sample.feedback.properties \
        -Dglean.log.dir=logs/`date +%G%m%d` \
        -Dgen.report.root=$HOME/Sites/$sample $* clean glean
done
