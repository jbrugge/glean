#!/bin/sh

if [ $# -eq 0 ]
then
    JPS="javapetstore.admin javapetstore.components javapetstore.opc javapetstore.supplier javapetstore.waf"
    SAMPLES="apache-ant commons-lang jdom spring struts-cookbook $JPS"
else
    SAMPLES=$1
fi

ANT_OPTS=-Xmx256M

for sample in $SAMPLES
do
    echo "============ Running Glean over $sample code ==============="
    ant -Dfeedback.properties=sample/$sample.feedback.properties \
        -Dgen.report.root=$HOME/glean/$sample clean glean
done
