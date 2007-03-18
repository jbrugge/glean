echo on
set JPS=javapetstore.admin javapetstore.opc javapetstore.supplier javapetstore.waf
set SAMPLES=apache-ant commons-lang jdom spring struts-cookbook %JPS%

set ANT_OPTS=-Xmx256M

for %%S in (%SAMPLES%) do ant -Dfeedback.properties=sample\%%S.feedback.properties -Dgen.report.root="%USERPROFILE%"\glean\%%S clean glean
