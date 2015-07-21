#!/bin/sh
RHQ_RELEASE_BRANCH=origin/release/jon3.3.x
TRANSLATIONS_DIR=modules/enterprise/gui/coregui/src/main/resources/org/rhq/coregui/client

echo_zanata_cfg () {
	cat <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<config xmlns="http://zanata.org/namespace/config/">
  <url>https://translate.jboss.org/</url>
  <project>jon32strings</project>
  <project-version>jon33x</project-version>
  <project-type>properties</project-type>

  <locales>
    <locale>de</locale>
    <locale>ja</locale>
  </locales>

</config>
EOF
}

if [ ! -d "$RHQ" ]; then
    echo "Environment variable \$RHQ must be set to a local clone of the RHQ repo"
    exit 1
fi 

(
 	cd "$RHQ"
	echo "Checkout $RHQ_RELEASE_BRANCH"
	git checkout "$RHQ_RELEASE_BRANCH" >/dev/null 2>&1 || echo "Error checking out branch: $RHQ_RELEASE_BRANCH"
	echo "Writing zanata.xml file"
	echo_zanata_cfg > zanata.xml
	echo "Invoking zanata-cli to pull files"
	zanata-cli pull -B --project-type properties -s "$TRANSLATIONS_DIR" -t "$TRANSLATIONS_DIR"
)
echo "Removing zanata.xml"
rm -f "$RHQ"/zanata.xml
