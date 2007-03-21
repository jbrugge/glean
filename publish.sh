#!/bin/bash
scp -P 232 doc/target/*.html jbrugge@jbrugge.com:httpdocs/glean
scp -P 232 doc/target/*.css jbrugge@jbrugge.com:httpdocs/glean
scp -P 232 doc/target/*.jpg jbrugge@jbrugge.com:httpdocs/glean

scp -P 232 dist/* jbrugge@jbrugge.com:httpdocs/glean

