#!/bin/sh

if [ $# -eq 0 ]
then
    JPS="javapetstore.admin javapetstore.opc javapetstore.supplier javapetstore.waf"
    SAMPLES="apache-ant commons-lang jdom spring struts-cookbook $JPS"
else
    SAMPLES=$1
    shift
fi

ANT_OPTS=-Xmx256M

cd src
for sample in $SAMPLES
do
    echo "============ Running Glean over $sample code ==============="
    ant -Dfeedback.properties=sample/$sample.feedback.properties \
        -Dgen.report.root=$HOME/Sites/$sample $* glean
done
